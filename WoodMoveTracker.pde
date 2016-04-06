import java.util.*;
class WoodMoveTracker
{
  // relative Humidity
  float currRH;
  float prevRH;
  
  // Moisture Content in Air
  float currAirMC;
  float prevAirMC;
  
  // Moisture Content in Wood
  float woodMC;

  
  // equilibrium Moisture content
  float emc ;
  
  int currRowNo ;// cell row number which is being updated. 
  
  float prevTanX = 0;
  float prevRadZ = 0;
  
  Wood wood;
  
  // Formula Req
  
  final float  FSP = 0.28 ; // fiber saturation point [ Constant ]
  final float SFR = 0.20 ; // shrinkage factor  - Radial - 4.1 percent
  final float SFT = 0.34 ; // shrinkage factor - Tangential - 6.8 percent
  
   List<String> faceTypeOrder = new ArrayList<String>()
  {
    {
      //tem
     // order of cell wall as per in grammar
     add("-o");
     add("-e");
     add("+o");
     add("+e");
    }
  };
  
  Map<Float,Float> rhEmcMapping = new HashMap<Float,Float>(){
   {
     put(0.0,0.0);
     put(0.25,0.05);
     put(0.50,0.09);
     put(0.75,0.14);
     put(1.00,0.28);
   }  
  };
  public WoodMoveTracker(Wood wood)
  {
    this.prevRH = 0.0;
    this.prevAirMC = 0.0;
    this.woodMC = 0.0;
    this.wood = wood ;
  }
  
  public void triggerRHChange(float rh)
  {
    prevTanX = 0;
    prevRadZ = 0;
    
    prevRH = currRH;
    prevAirMC = currAirMC;
    woodMC = prevAirMC ;
    currRH = rh;
    for(Map.Entry<Float,Float> en : rhEmcMapping.entrySet())
    {
     if( currRH <= en.getKey())
     {
       float upRH = en.getKey();
       float upEMC = en.getValue();
       
       emc = (currRH * upEMC) / upRH ;
       currAirMC = emc ;
       break ;
     }  
    }
   resetWoodCellSaturation();
  }
  public void updateWoodModel(int firstRow , int lastRow,int colLayer)
  {
    if(prevRH < currRH)
     initWoodModelExpansionOrShrinkage(firstRow,lastRow,colLayer,true);
    else
     initWoodModelExpansionOrShrinkage(firstRow,lastRow,colLayer,false);
  }
  public void initWoodModelExpansionOrShrinkage(int firstRow,int lastRow,int colLayer,boolean isSwell)
  {
    boolean updateWholeRow = true ;
    
   // println(" Tanx , RadZ "+prevRadZ,prevTanX);
    
    float currTanX = 0;
    float currRadZ = 0;
    
    for(int i = 0 ; i < wood.cellRowList.size() ; i++)
   { 
     
     //if(firstRow == i ||  lastRow == i)
     // updateWholeRow = true ;
     //else
     // updateWholeRow = false ;
     CellRow cr = wood.cellRowList.get(i);
                 
     currTanX = calculateTanLenForExpandedCell(cr.cellList.get(0).tanXLen);
     currRadZ = calculateRadLenForExpandedCell(cr.cellList.get(0).radZLen);
     if(updateWholeRow )
     {
       for(int j = 0 ; j < cr.cellList.size() ; j++)
       { 
         
         
          Cell c = cr.cellList.get(j);
          if(isSwell)
          {
           c.tanXLen += currTanX ;
           c.radZLen += currRadZ ;
          }
          else
          {
           c.tanXLen -= currTanX ;
           c.radZLen -= currRadZ ;
          }
          c.startVector = new PVector(prevTanX,0,prevRadZ);
         updateCellModel(c,wood.woodShape.getChild(i).getChild(j));
         prevTanX += c.tanXLen; 
         if( j == 0 )
          cr.setStartVector(c.startVector);
        else if(j == cr.cellList.size() - 1 )
          cr.setEndVector( new PVector(prevTanX + c.tanXLen ,0,prevRadZ + c.radZLen ));
          
       }
       
         
     }else
     {
         for(int j = 0 ; j < cr.cellList.size() ; j++)
       {
           
         
         Cell c = cr.cellList.get(j);
         if( j == colLayer || j == (cr.cellList.size() - colLayer - 1))
         {
           
           c.tanXLen += currTanX ;
           c.radZLen += currRadZ ;
           c.startVector = new PVector(prevTanX,0,prevRadZ);
           updateCellModel(c,wood.woodShape.getChild(i).getChild(j));
          
         } else
         {
           //c.startVector = new PVector(prevTanX,0,prevRadZ);
           updateCellModel(c,wood.woodShape.getChild(i).getChild(j));
          
         }
          prevTanX += c.tanXLen ; 
       }
     }
     prevRadZ += cr.cellList.get(0).radZLen ;
     prevTanX = 0;
   }
   
  }
 public void updateCellModel( Cell c , PShape cell)
 {
   LinkedHashMap<String,PShape> faceTypeMapping = c.getNewFaceMappingForUpdate();
   
   for(int i = 0 ;i< faceTypeOrder.size() ; i++)
   {
    
     PShape woodFace = cell.getChild(i);
     PShape newFace = faceTypeMapping.get(faceTypeOrder.get(i));
     assignNewFaceToOld(newFace,woodFace);
   }
 }
 
 public void initWoodModelShrinkage(int firstRow,int lastRow,int colLayer)
 {
 }
 public void assignNewFaceToOld(PShape nFace,PShape oFace)
 {
   for(int i = 0 ; i<nFace.getChildCount();i++)
   {
     PShape oldPlane = oFace.getChild(i);
     PShape newPlane = nFace.getChild(i);
    
     for(int j = 0 ; j <oldPlane.getVertexCount(); j++)
     {
        
       PVector newV = newPlane.getVertex(j);
       PVector oldV = oldPlane.getVertex(j);
       oldV.set(newV);
       oldPlane.setVertex(j,oldV);
     }
   }
 }
 public void resetWoodCellSaturation()
 {
   for(CellRow cr : wood.cellRowList)
   {
     for(Cell c : cr.cellList)
     {
       c.isSaturated = false ;
     }
   }
 }
 
 public float calculateTanLenForExpandedCell(float tanX)
 {
   
   float cTanX = tanX * SFT * (currAirMC - (woodMC/FSP));
   println("calc Tanx ==> "+tanX+" * "+SFT+" * ("+currAirMC +" - ("+woodMC+" / "+FSP+")) ==>"+Math.abs(cTanX));
   return Math.abs(cTanX);
 }
 
 public float calculateRadLenForExpandedCell(float radZ)
 {
  
   float cRadZ = radZ * SFR * (currAirMC - (woodMC/FSP));
    println("calc Radx ==> "+radZ+" * "+SFR+" * ("+currAirMC +" - ("+woodMC+" / "+FSP+"))==>"+Math.abs(cRadZ));
   return Math.abs(cRadZ);
 }
}
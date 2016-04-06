class Wood
{
  PShape woodShape ;
  PVector b1Vector ;
  PVector b2Vector ;
  PVector b3Vector ;
  PVector b4Vector ;
  float defaultLongYLen = 250;
  List<CellRow> cellRowList ;

  public Wood(String production)
  {
    b1Vector = new PVector(0,0,0);
    
    cellRowList = new ArrayList();
    
    woodShape = createShape(GROUP);
  
     fill(191, 191, 191);
     ambient(122, 122, 122);
     lightSpecular(30, 30, 30);
     specular(122, 122, 122);
     shininess(0.7);
     
     translate(width/4,height/2,0);
     
     ModelManager mu = new ModelManager(this);
      
     mu.parseGrammar(production);
      
     setCoordinatesOfWood(); 
     //LUT.initialize();
  }
  public void setCoordinatesOfWood()
  { 
    // b1 and b2 from 1 st cell row
     
     CellRow cellRow = cellRowList.get(0);
     
     b1Vector = cellRow.startVector;
     b2Vector = cellRow.endVector;
    
    //b3 and b4 from last cell row
    
     cellRow = cellRowList.get(cellRowList.size()-1);
     
     
     b3Vector = cellRow.startVector;
     b4Vector = cellRow.endVector;
    
  }
  public void addSubStuctureWood(CellRow cellRow)
  {
    
    cellRowList.add(cellRow);
    
    println(" wood child "+woodShape.getChildCount());
    woodShape.addChild(cellRow.cellRowShape);
  }
  
  
  public void displayWood()
  {
    shape(woodShape);
    
    //println(" b1Vector ====>"+b1Vector.x,b1Vector.y,b1Vector.z);
    //println(" b2Vector ====>"+b2Vector.x,b2Vector.y,b2Vector.z);
    //println(" b3Vector ====>"+b3Vector.x,b3Vector.y,b3Vector.z);
    //println(" b4Vector ====>"+b4Vector.x,b4Vector.y,b4Vector.z);
    
    
  }
  
  
}
class Cell
{
  
  float tanXLen  ; // incre in x direction
  float radZLen  ; // incre in z direction
  float longYLen ;
  
  PShape cellShape ; 
  
  String cellType ;
  
  PVector startVector ; // For a cell, start vector and end vector same
  Face currFace ;
  
  float maxLen = 70 ;   // maximum len of Cell is 2.5mm to 7mm
  float maxWid = maxLen / 10 ; // width = len / 100 ; hypo ==> width = len /10 ;
  
  
   
  
  boolean isRay = false ;
  boolean isTracheid = false ;
  
  public Cell()
  {
    cellShape = createShape(GROUP);
    
  }
  
  public void setStartVector(PVector startVector)
  {
    this.startVector = startVector ;
  }
  
  public Face constructFace(String faceType)
   {
     
      PVector v1 = getV1CoordinatesForFace(faceType);
      PVector v2 = getV2CoordinatesForFace(faceType) ;
      PVector v3 = getV3CoordinatesForFace(faceType) ;
      PVector v4 = getV4CoordinatesForFace(faceType) ;
      
      currFace = new Face(v1,v2,v3,v4,faceType);
      
      currFace.setFaceWeight(tanXLen,radZLen,cellType);
      
      currFace.buildFace();
      
      cellShape.addChild(currFace.faceShape);
      
      
      return currFace ;
   }
   
   public PVector getV1CoordinatesForFace(String faceType)
   {
     PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + 0 ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + radZLen ;
       
     }
     else if(faceType.equals("+o"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + radZLen ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + 0 ;
       
     }
     return v;
   }
   
   public PVector getV2CoordinatesForFace(String faceType)
   {
     PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + 0 ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + radZLen ;
       
     }
     else if(faceType.equals("+o"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + radZLen ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + 0 ;
       
     }
     return v;
   }
   
   public PVector getV3CoordinatesForFace(String faceType)
   {
     PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + radZLen ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + radZLen ;
       
     }
     else if(faceType.equals("+o"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + 0 ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + 0 ;
       v.z = startVector.z + 0 ;
       
     }
     return v;
   }
   
    public PVector getV4CoordinatesForFace(String faceType)
   {
     PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + radZLen ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + radZLen ;
       
     }
     else if(faceType.equals("+o"))
     {
       v.x = startVector.x + 0 ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + 0 ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = startVector.x + tanXLen ;
       v.y = startVector.y + longYLen ;
       v.z = startVector.z + 0 ;
       
     }
     return v;
   }
   
  
}
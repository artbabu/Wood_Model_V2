class CellRow
{
  int id ; 
  List<Cell> cellList ;
  
  float tanXLen = 0 ; // incre in x direction
  float radZLen = 0; // incre in z direction
  float longYLen = 0;
  
  int lInc = 10 ;
  int eInc = 10 ;
  
  PShape cellRowShape ;
  
  PVector startVector ;
  PVector endVector ;
  
   float maxTanZFaceWeight  ;
  float maxRadXFaceWeight  ;
  
  public CellRow()
  {
     cellList =  new ArrayList();
     cellRowShape = createShape(GROUP);
     
  }
  
  public void setStartVector(PVector sv)
  {
    this.startVector = sv ;
  }
  
  public void setEndVector(PVector ev)
  {
    this.endVector = ev ;
  }
  public float calculateRadZLen(float minRadZLen,float maxRadZLen,int rowCount,String cellType)
  {
    if(cellType.equals("EARLY_WOOD"))
      radZLen = maxRadZLen - (eInc /rowCount );
    else
      radZLen = maxRadZLen - (lInc /rowCount);
      
      if(radZLen < minRadZLen)
         radZLen = minRadZLen ;
      
    return radZLen;
  }
  public float calculateTanXLen(float minTanXLen,float maxTanXLen,int rowCount,String cellType)
  {
    if(cellType.equals("EARLY_WOOD"))
      tanXLen = minTanXLen + (eInc / rowCount );
    else
      tanXLen = minTanXLen + (lInc / rowCount );
      
      if(tanXLen > maxTanXLen)
         tanXLen = maxTanXLen ;
         
         
      
    return radZLen;
  }
  public void setFaceWeight(Float tanLen,Float radLen,String cellType)
  {
   
    if(cellType.equals("EARLY_WOOD"))
      {
        maxTanZFaceWeight = tanLen / 7 ;
        maxRadXFaceWeight = radLen / 7 ;
      }
     else if(cellType.equals("LATE_WOOD"))
     {
       maxTanZFaceWeight = tanLen / 5 ;
       maxRadXFaceWeight = radLen / 5 ;
     }
     
  }
  
}
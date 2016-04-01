class ModelManager
{
   
  
   CellRow currCellRow ;
   Cell currCell ;
   Face currFace ;
   
   float maxTanXLen = 80 ; // incre in x direction
   float maxRadZLen = 80; // incre in z direction
   float maxLongYLen ;
   
   
   Wood currWood;
   
   ModelUtil mu ;
   
   float tanXLen ; // incre in x direction
   float radZLen ; // incre in z direction
   float longYLen ;
  
    char[] csArray ;
    int currPos = 0 ;

   public ModelManager(Wood wood)
   {
     tanXLen = 25 ; // incre in x direction
     radZLen = 25 ; // incre in z direction
     longYLen = 250;
     currWood = wood ;
     mu = new ModelUtil();
   }
   
   public void parseGrammar(String production)
   
   { 
     csArray = production.toCharArray();
     
    for (; currPos<csArray.length;currPos++) 
    {
      mu.executeForLiteral(csArray[currPos],this);
    }
     
   
   }
   
   public void setCurrCellRow(CellRow cr)
   {
     //incrementCellDimension();
     currCellRow = cr ;
   }
   
   public void incrementCellDimension()
   {
     if((tanXLen + 5) <  maxTanXLen)
      tanXLen = tanXLen + 3 ;
     if((radZLen + 5) <  maxRadZLen)
       radZLen = radZLen + 2 ;
       
   }
   
   public void addCurrCellRowToWood(PVector endColVec)
   {
     currCellRow.setEndVector(endColVec) ;
     currWood.cellRowList.add(currCellRow);
     currWood.woodShape.addChild(currCellRow.cellRowShape);
   }
   
   public void setCurrCell(Cell c)
   {
     c.tanXLen = tanXLen ;
     c.radZLen = radZLen ;
     c.longYLen = longYLen ;
     currCell = c ;
   }
   
   public void addCurrCellToCellRow()
   {
     currCellRow.cellList.add(currCell);
     currCellRow.cellRowShape.addChild(currCell.cellShape);
   }
   
   public void createFaceForCell()
   {
     
     if(csArray[currPos + 1 ] == '(')
     { 
       currPos = currPos + 2 ;
       String faceType = mu.getsubPartStr(csArray,')',currPos);
       currPos = currPos + (faceType.length() );
       currFace =  currCell.constructFace(faceType);
     }
   }
   
}
class ModelManager
{
   
  
   CellRow currCellRow ;
   Cell currCell ;
   Face currFace ;
   
   Wood currWood;
   
   ModelUtil mu ;
   
   float tanXLen = 25 ; // incre in x direction
   float radZLen = 25 ; // incre in z direction
   float longYLen = 250;
  
    char[] csArray ;
    int currPos = 0 ;

   public ModelManager(Wood wood)
   {
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
     currCellRow = cr ;
   }
   
   public void addCurrCellRowToWood(PVector endColVec)
   {
     currCellRow.setEndVector(endColVec) ;
     currWood.cellRowList.add(currCellRow);
     currWood.woodShape.addChild(currCellRow.cellRowShape);
   }
   
   public void setCurrCell(Cell c)
   {
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
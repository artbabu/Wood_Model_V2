class ModelManager
{
   
  
   CellRow currCellRow ;
   Cell currCell ;
   Face currFace ;
   
   int cellRowCount ;
   
   
   Wood currWood;
   
   ModelUtil mu ;
   
   float maxLTanXLen = 25 ;
   float maxETanXLen = 50 ;
  
   //float maxLRadZLen = 20 ;
   //float maxERadZLen = 50 ; // incre in z direction
   
   float defRadZLen = 5 ;
   float defLongYLen = 250;
  
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
       currCellRow.longYLen = defLongYLen ;
       currCellRow.radZLen = defRadZLen ;
     
   }
   
   public void addCurrCellRowToWood(PVector endColVec)
   {
      if(currCellRow.cellList.size() != 0)
     {
     currCellRow.setEndVector(endColVec) ;
     currWood.cellRowList.add(currCellRow);
     currWood.woodShape.addChild(currCellRow.cellRowShape);
     }
   }
   
   public void setCurrCell(Cell c)
   {
     currCell = c ;
   }
   
   public void addCurrCellToCellRow()
   {
     
     println("currCellRow tanXLen==>"+currCellRow.tanXLen);
     println("currCellRow radZLen==>"+currCellRow.radZLen);
     println("currCellRow longYLen==>"+currCellRow.longYLen);
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
class CellRow
{
  List<Cell> cellList ;
  
  PShape cellRowShape ;
  
  PVector startVector ;
  PVector endVector ;
  
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
}
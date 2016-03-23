class Wood
{
  PShape woodShape ;
  PVector startVector ;
  PVector endVector ; 
  
  List<CellRow> cellRowList ;

  public Wood(String production)
  {
    startVector = new PVector(0,0,0);
    
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
      
     //LUT.initialize();
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
  }
  
  
}
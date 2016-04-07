
class ModelUtil 
{
  
  
   PVector colVector = new PVector(0,0,0);
   PVector rowVector = new PVector(0,0,0);

   boolean isCellRowActive = false ;
  
   boolean  isCellActive = false ;
 
 public void executeForLiteral(char c , ModelManager mm )
 {
  switch(c)
  {       
    // increment x for main shape
    case 'r' :
            {
              if(!isCellRowActive)
                {
                  isCellRowActive = true ;
                  
                  CellRow cr =  new CellRow();
                  
                  colVector = rowVector;
                  cr.setStartVector(new PVector(colVector.x,colVector.y,colVector.z));
                 // rowVector = new PVector(rowVector.x,rowVector.y,rowVector.z+(mm.radXLen)); // updating row vector for next row.
                  
                  mm.setCurrCellRow(cr);
                  
                }
              else
                {
                  colVector.x = colVector.x + mm.tanXLen;
                  mm.addCurrCellRowToWood(colVector);
                  isCellRowActive = false;
                }   
              break;         
            }
    
    case 'c' :
             {
              if(!isCellActive)
                {
                  isCellActive = true ;
                  
                  Cell cell =  new Cell();
                  cell.setStartVector(new PVector(colVector.x,colVector.y,colVector.z));
                  //colVector = new PVector(colVector.x+(mm.tanLen),colVector.y,colVector.z); // updating row vector for next col in a row.
                  
                  mm.setCurrCell(cell);
                  
                }
              else
                {
                  mm.addCurrCellToCellRow();
                  isCellActive = false;
                }   
              break;         
            }             
    case 'F':
            {
              if(isCellActive)
              {
                if(mm.currCell.cellType == null)
                   mm.currCell.cellType = "EARLY_WOOD";   
             
                mm.createFaceForCell();
              }
            }
              
    case 'G':
             {
               
              if(isCellActive)
              {
                if(mm.currCell.cellType == null)
                   mm.currCell.cellType = "LATE_WOOD";   
             
                mm.createFaceForCell();
              }
             }
 
    case 'H':
            {
              //To Do
              break; 
            }            
    case '[' : 
            {
             // pushMatrix();
              break ;
            } 
       
    case ']' :
            {
             //popMatrix();
              break ;
            }
 
    case 'f':
            {
             //To Do
              break;                 
            } 
  
    case 'g':
            {
              //To Do
              break; 
            }                
    case 'h':
            {
             //To Do
              break; 
            }
    case '+': // tangential change - forward i.e x = x + c
            {
              if(!isCellActive)
                colVector = new PVector(colVector.x + mm.tanXLen,colVector.y,colVector.z);
              
              if(!isCellRowActive)  
                rowVector = new PVector(rowVector.x + mm.tanXLen,rowVector.y,rowVector.z);
              break ;
              
            }
    case '-':// tangential change - backward i.e x = x - c
            {
              if(!isCellActive)
                colVector = new PVector(colVector.x - mm.tanXLen,colVector.y,colVector.z);
              
              if(!isCellRowActive)  
                rowVector = new PVector(rowVector.x - mm.tanXLen,rowVector.y,rowVector.z);
              break ;
            }
    case '>': // longitudinal change - forward i.e y = y + c
            {
               if(!isCellActive)
                colVector = new PVector(colVector.x ,colVector.y + mm.longYLen,colVector.z);
              
              if(!isCellRowActive)  
                rowVector = new PVector(rowVector.x ,rowVector.y + mm.longYLen,rowVector.z);
              
              break; 
            }
    case '<':  // longitudinal change - backward i.e y = y - c
            {
               if(!isCellActive)
                colVector = new PVector(colVector.x ,colVector.y - mm.longYLen,colVector.z);
              
              if(!isCellRowActive)  
                rowVector = new PVector(rowVector.x ,rowVector.y - mm.longYLen,rowVector.z);
              
              break; 
            }
    case '^':  // radial change - forward i.e z = z + c
            {
              if(!isCellActive)
                colVector = new PVector(colVector.x ,colVector.y ,colVector.z + mm.radZLen);
              
              if(!isCellRowActive)  
                rowVector = new PVector(rowVector.x ,rowVector.y ,rowVector.z + mm.radZLen);
              
              break; 
            }
    case '&': // radial change - backward i.e z = z - c
            {
             if(!isCellActive)
                colVector = new PVector(colVector.x ,colVector.y ,colVector.z - mm.radZLen);
              
              if(!isCellRowActive)  
                rowVector = new PVector(rowVector.x ,rowVector.y ,rowVector.z - mm.radZLen);
              
              break; 
            }
    case '{':
            {
              //drawShape = true ;
              //currShape = createShape(GROUP);
              break;
            }
    case '}':
            {
              //translateX += distance ;
              //currShape.translate(translateX,translateY,translateZ);
              //cellRow.addChild(currShape);
              //drawShape = false ;
              break;
            }
    case '|':
            {
              //ang = radians(180);
              //currAngle = 180 ;
              break;
            }
    case '~':
            {
              //ang = radians(90);
              //currAngle = 90 ;
              break;
            }
    case '#' :
            {
              //ang = radians(def_ang);
              //currAngle = 0 ;
              break;
            }
    case '1':
            {
             //repeats += 1;
             break; 
            }          
    case 'W':
    case 'E':
    case 'L':
    case 'B':
    case 'S':
      break;
    default:
      System.err.println("character " + c + " not in grammar");
    }
  }


  public String getsubPartStr(char[] csArray,char endChar,int pos)
  {
    String newProd = "";
    for(int i = pos ; csArray[i] != endChar ; i++)
      {
        newProd += String.valueOf(csArray[i]);
      }
    return newProd ;
  }

}
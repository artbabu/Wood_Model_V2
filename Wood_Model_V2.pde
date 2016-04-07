
import lsystem.util.*;
import lsystem.turtle.*;
import lsystem.collection.*;
import lsystem.*;
import processing.pdf.*;

import java.util.*; 


import peasy.*;
 
PeasyCam cam; 

String production = "";
Grammar grammar ;
Wood w ;
WoodMoveTracker woodMT ;
int depth = 3;
int numBalls = 100;
int ballSize = 10;
int ballHitCount = 0;
static int memberid = 0;
ArrayList balls = new ArrayList();
float xMax;
float xMin;
float yMin;
float yMax;
float zMin;
float zMax;
int drawCount =1;

float minRH = 0.10 ;
float currRH = 0.0;
float maxRH = 0.50 ;

boolean RHInc = true ;
boolean swell = false;

//PVector end = new PVector(endX, endY, endZ);
 
 // Exapnsion Parameters
 List<Float> rhList = new ArrayList<Float>()
 {
   {
     //add(0.00);
     add(0.10);
     add(0.12);
     add(0.15);
     add(0.17);
     add(0.20);
     add(0.22);
     add(0.25);
     add(0.27);
     add(0.30);
     add(0.32);
     add(0.35);
     add(0.37);
     add(0.40);
     add(0.45);
     add(0.50);
     add(0.55);
     add(0.60);
     add(0.65);
     add(0.70);
     add(0.75);
     add(0.80);
     add(0.85);
     add(0.90);
     add(0.95);
   }
 };
  boolean rhIncChange = true ;
  
  
  int rhCount = 0;
 
  int currSRow = 0;
  int currSCol = 0;
  
  int currERow = 0;
  int currECol = 0;
  
  int maxRow = 0;
  int midRow = 0;
  int maxCellInRowNo =0;
  
void setup() {
  
  size(1200, 1000, P3D);
 
  ambientLight(80, 80, 80);
  directionalLight(100, 100, 100, -1, -1, 1);  
  background(20, 20, 200);
  lights();
  setupGrammar(this);
  w = new Wood(production);
  //printStartVector();
  woodMT = new WoodMoveTracker(w);
  
  
  float[] xArray = {w.b1Vector.x, w.b2Vector.x, w.b3Vector.x, w.b3Vector.x, w.b4Vector.x};
  float[] yArray = {w.b1Vector.y, w.b2Vector.y, w.b3Vector.y, w.b3Vector.y, w.b4Vector.y};
  float[] zArray = {w.b1Vector.z, w.b2Vector.z, w.b3Vector.z, w.b3Vector.z, w.b4Vector.z};
  println(min(zArray), max(zArray));
  xMin = min(xArray);
  xMax = max(xArray);
  yMin = min(yArray);
  yMax = 250;
  zMin = min(zArray);
  zMax = max(zArray) ;
 
   initateRHChange();
   
  
  cam = new PeasyCam(this,0,0,0,1500);   
}
public void printStartVector()
{
    for(int i = 0 ; i < w.cellRowList.size() ; i++)
    {
     
      CellRow cr = w.cellRowList.get(i);
                 
      
      
        for(int j = 0 ; j < cr.cellList.size() ; j++)
        { 
          println("start Vector ===>"+cr.cellList.get(j).startVector);
        }
    }
}
 
void draw() {
  
 
  background(30, 20, 200);
  drawCount ++; 
  textSize(30);
  fill(0);
  text("Current Relative Humidity    =>"+currRH, - (width/4 + 290),- (height/2 + 290)); 
  fill(0);
  text("Current Air Moisture Content =>"+woodMT.currAirMC,- (width/4 + 290),- (height/2 + 260));
  fill(0);
  text("Current Wood Moisture Content =>"+woodMT.woodMC,- (width/4 + 290),- (height/2 + 230)); 

  rotateX(PI / 3);
  rotateY(PI / 3);
  stroke(255);
  if(swell){
    for (int i=0; i < balls.size(); ++i) {
    pushMatrix();
    Ball b = (Ball) balls.get(i);
    int reached = b.move(w);
    if(reached == 1){
      ballHitCount ++;
      //balls.remove(b);
    }else if(reached == 3) {
      balls.remove(b);
    }  
    popMatrix();
    }
    if(balls.size() < numBalls){
      balls.add(new Ball(2,memberid++));
    }
  }
  
  if(drawCount % 10 == 0 ){
    if(currSRow <= currERow )
    {
      woodMT.updateWoodModel(currSRow,currERow,currSCol,currECol);
      currSRow ++;
      currERow --;
      currSCol ++ ;
      currECol -- ;
    
    }
    
    if( currSRow == midRow && currERow == midRow)
    {
       initateRHChange();
    }
  }
  w.displayWood();
}
 
public void initateRHChange()
{
   maxRow = w.cellRowList.size() ;
  
  midRow = maxRow / 2 ;
  maxCellInRowNo = w.cellRowList.get(0).cellList.size();
  currSRow = 0;
  currSCol = 0;
  currERow = maxRow ;
  currECol = maxCellInRowNo ;
  
  if(!RHInc && currRH >= minRH)
  {
    currRH = currRH - 0.05;
  }else if(RHInc && currRH <= maxRH)
  {
    currRH = currRH + 0.05;
  }else
  {
    RHInc = !RHInc;
    setup();
  }
  println("trigger ==>"+currRH);
  woodMT.triggerRHChange(currRH);

}
void setupGrammar(PApplet pthis) {
  
  grammar = new SimpleGrammar(pthis, "W");   // this only required to allow applet to call dispose()
  grammar.addRule('W', "[L^L^L^E^E^E^E^E]");
  grammar.addRule('E', "rB+B+B+B+B+B+B+Br");
  grammar.addRule('L', "rS+S+S+S+S+S+S+Sr");
  grammar.addRule('B', "cF(-o)F(-e)F(+o)F(+e)c");
  grammar.addRule('S', "cG(-o)G(-e)G(+o)G(+e)c");
  production = grammar.generateGrammar(depth);
  println(" prod ===>"+production);
  if (depth > 0) {
    //distance *= 1/(pow(2, depth) - 1);
  }
}

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
int numBalls = 40;
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

//PVector end = new PVector(endX, endY, endZ);
 
 // Exapnsion Parameters
 List<Float> rhList = new ArrayList<Float>()
 {
   {
     add(0.10);
     add(0.20);
     add(0.30);
     add(0.40);
     add(0.50);
     add(0.60);
     add(0.70);
     add(0.80);
     add(0.90);
   }
 };
  boolean rhIncChange = true ;
  
  
  int rhCount = 0;
  int frontRow = 0 ;
  int lastRow = 0;
  int cellColLayer = 0;
  int midRow = 0;
 
void setup() {
  
   size(1200, 1000, P3D);
 
  ambientLight(80, 80, 80);
  directionalLight(100, 100, 100, -1, -1, 1);  
  background(20, 20, 200);
  lights();
  setupGrammar(this);
  w = new Wood(production);
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
  zMax = max(zArray) + 20;
  
    cam = new PeasyCam(this,0,0,0,1500); 
  //for (int i = 0; i < numBalls; i++) {
  //  //balls[i] = new Ball(15);
  //  balls.add(new Ball(ballSize,memberid++));
  //}
  
}

 
void draw() {
 
 background(20, 20, 200);
 
  rotateX(PI / 3);
  rotateY(PI / 3);
 
 //if( frontRow == midRow && lastRow == midRow)
 //{
 //initateRHChange();
 //}
 
  // w.displayWood();
 //lights(); 
 stroke(255);
 for (int i=0; i < balls.size(); ++i) {
  pushMatrix();
  Ball b = (Ball) balls.get(i);
  int reached = b.move(w);
  if(reached == 1){
    ballHitCount ++;
    //if(!emc)
    //  balls.remove(b);
  }else if(reached == 3) {
      balls.remove(b);
  }  
  popMatrix();
 }
 if(balls.size() < numBalls){
    balls.add(new Ball(10,memberid++));
 }
  
 //if(frontRow <= midRow)
 //{
   //woodMT.updateWoodModel(frontRow,lastRow,cellColLayer);
   //cellColLayer ++;
   //frontRow++;
   //lastRow --;
 //}
//// 
 w.displayWood();
 //try{
 //Thread.sleep(1200);
 //}catch(Exception e)
 //{
 //}
}
 //void keyPressed() {
 // if(key == 's'){
 //   noLoop();
 // }else if(key == 'a'){
 //   loop();
 // }
//}

public void initateRHChange()
{
  if(rhCount < (rhList.size()-1))
     rhCount ++ ;
  else
  {
    setup();
     rhCount = 0;
  }
     
  println("********************trigger RH Change***********"+rhList.get(rhCount));   
  woodMT.triggerRHChange(rhList.get(rhCount));
   cellColLayer = 0;
   frontRow = 0;
   lastRow = rhList.size() - 1 ;
   midRow = lastRow / 2 ;
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
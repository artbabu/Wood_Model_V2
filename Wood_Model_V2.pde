
import lsystem.util.*;
import lsystem.turtle.*;
import lsystem.collection.*;
import lsystem.*;
import processing.pdf.*;

import java.util.*; 

//import processing.opengl.*; // optimised for new version (else there is clipping)
// It'll be even better when I get PShapes3D to work!!!
import peasy.*;
 
PeasyCam cam; 

String production = "";
Grammar grammar ;
Wood w ;
int depth = 3;
int numBalls = 100;
static int memberid = 0;
ArrayList balls = new ArrayList();

//PVector end = new PVector(endX, endY, endZ);
 
void setup() {
  
   size(1200, 1000, P3D);
 
  ambientLight(80, 80, 80);
  directionalLight(100, 100, 100, -1, -1, 1);  
  background(20, 20, 200);
  lights();

  setupGrammar(this);
  w = new Wood(production);

  cam = new PeasyCam(this,0,0,0,1500); 
  for (int i = 0; i < numBalls; i++) {
    //balls[i] = new Ball(15);
    balls.add(new Ball(1,memberid++));
  }
   
}

 
void draw() {
 
 background(20, 20, 200);
  w.displayWood();
  //lights(); 
  stroke(255);
  for (int i=0; i < balls.size(); ++i) {
    pushMatrix();
    Ball b = (Ball) balls.get(i);
    boolean reached = b.move(w);
    if(reached){
      balls.remove(balls.indexOf(b));
    }
    popMatrix();
  }
  if(balls.size() == 0){
    
    for (int i = 0; i < numBalls; i++) {
      //balls[i] = new Ball(15);
      balls.add(new Ball(10,memberid++));
    }
  }
  
}
 
void setupGrammar(PApplet pthis) {
  
  grammar = new SimpleGrammar(pthis, "W");   // this only required to allow applet to call dispose()
  grammar.addRule('W', "L^L^L^L^L^E^E^E^E^E");
  grammar.addRule('E', "[rB+B+B+B+B+B+B+Br]");
  grammar.addRule('L', "[rS+S+S+S+S+S+S+Sr]");

  grammar.addRule('B', "cF(+e)F(+o)F(-e)F(-o)c");
  grammar.addRule('S', "cG(+e)G(+o)G(-e)G(-o)c");
 production = grammar.generateGrammar(depth);
 println(" prod ===>"+production);
  if (depth > 0) {
    //distance *= 1/(pow(2, depth) - 1);
  }
}

void mousePressed(){
  //endX = mouseX;
  //endY = mouseY;
 
}
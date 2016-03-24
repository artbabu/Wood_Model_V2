
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

 
void setup() {
  
   size(1200, 1000, P3D);
 
  ambientLight(80, 80, 80);
  directionalLight(100, 100, 100, -1, -1, 1);  
  background(20, 20, 200);
  lights();

  setupGrammar(this);
  w = new Wood(production);

  cam = new PeasyCam(this,0,0,0,1500); 
   
}

 
void draw() {
 
 background(20, 20, 200);
  w.displayWood();
}
 
void setupGrammar(PApplet pthis) {
  
  grammar = new SimpleGrammar(pthis, "W");   // this only required to allow applet to call dispose()
  grammar.addRule('W', "[rLr]^[rLr]^[rLr]^[rEr]^[rEr]^[rEr]^[rEr]^[rEr]^[rEr]^[rEr]^W");
  grammar.addRule('E', "BBBBBBBBBBBB");
  grammar.addRule('L', "SSSSSSSS");
  grammar.addRule('B', "cF(+e)F(+o)F(-e)F(-o)c");
  grammar.addRule('S', "cG(+e)G(+o)G(-e)G(-o)c");
 production = grammar.generateGrammar(depth);
 println(" prod ===>"+production);
  if (depth > 0) {
    //distance *= 1/(pow(2, depth) - 1);
  }
}
class Ball{
  
  private int ballid;;
  int radius;
  PVector location = new PVector();
  PVector speed;
  //float xSpeed=random(5);
  //float ySpeed=random(5);
  //float zSpeed=random(5);
   
  int xDirection=1;
  int yDirection=1;
  int zDirection=1;
  
  float xPos;
  float yPos;
  float zPos;
  
  float beginX; // Initial x-coordinate
  float beginY;  // Initial y-coordinate
  float beginZ;  // Initial x-coordinate
  float distX;          // X-axis distance to move
  float distY;          // Y-axis distance to move
  float distZ;          //Z-axis distance to move
  float exponent = 4;   // Determines the curve
  float gravity = 0.33;
  
  float step = 0.01;    // Size of each step along the path
  float pct = 0.0;      // Percentage traveled (0.0 to 1.0)
  float endX;   // Final x-coordinate
  float endY;// Final y-coordinate
  float endZ;    // Final z-coordinate

  Ball(int r, int id){
    //beginX = -500;
    //beginY = -500;
    //beginZ = 0;
    beginX = random(-800, 800);
    beginY = random(-800, 800);
    beginZ = random(-800, 800);
   
    endX = 20;
    endY = 150;
    endZ = 150;
    ballid = id;
    radius = r;
    location.x = beginX ;
    location.y = beginY ;
    location.z = beginZ ;
  }
  
  boolean move(Wood w){

    //endX = random(-500, 500);
    //endY = random(-500, 500);
    //endZ = random(-500, 500);
    // inital ball set up
    if(location.x  >= xMin - radius && location.x <= xMax + radius && location.y >= yMin - radius && location.y <= yMax + radius  && location.z >= zMin - radius && location.z <= zMax + radius){
      pct = 1.0;
    }
    distX = endX - beginX;
    distY = endY - beginY;
    distZ = endZ - beginZ;
    
    translate (location.x, location.y, location.z);
    sphere(radius);; noFill();
    pct += step;
    // motion setup
    //location.x = location.x + (xSpeed * xDirection); 
    //location.y = location.y + (ySpeed * yDirection);
    //location.z = location.z + (zSpeed * zDirection);
    if (pct < 1.0) {
      location.x = beginX + (pct * distX );
      location.y = beginY + (pct * distY );
      location.z = beginZ + (pct * distZ );
      //location.y += gravity;
      if (location.x>width-50) {
       xDirection*=-1;
      }
     
      if (location.y>height-50) {
        yDirection*=-1;
      }
     
      if (location.z>500) {
        zDirection*=-1;
      }
     
      if (location.x<50) {
        xDirection*=-1;
      }
     
      if (location.y<50) {
        yDirection*=-1;
      }
     
      if (location.z<0) {
        zDirection*=-1;
      }
    }else{
      return true;
    }
    return false;

  }
  
  void update(){
    translate (location.x, location.y, -location.z);
    sphere(radius);
  }
}
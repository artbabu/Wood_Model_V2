class Face
{
  PVector v1 ;
  PVector v2 ;
  PVector v3 ;
  PVector v4 ;
  PVector v11 ;
  PVector v22 ;
  PVector v33 ;
  PVector v44 ;
  
  color brown = color(152,80,60);
  color darkBrown = color(44,36,22);
   
  PShape faceShape ;
  
  float maxTanZFaceWeight  ;
  float maxRadXFaceWeight  ;
   
  String faceType;
  
  public Face(PVector c1, PVector c2, PVector c3, PVector c4, String faceType)
  {
    faceShape = createShape(GROUP);
    this.faceType = faceType ;
    this.v1 = c1;
    this.v2 = c2;
    this.v3 = c3;
    this.v4 = c4;
  }
  
  void buildFace()
{
  
  this.v11 = getV11CoordinatesForFace();
  this.v22 =  getV22CoordinatesForFace();
  this.v33 =  getV33CoordinatesForFace();
  this.v44 = getV44CoordinatesForFace();
        
  PShape face = createShape();
  face = drawFace(face,v1,v2,v3,v4,brown,true,true);
  faceShape.addChild(face);
  
  
  
  face = createShape();
  face = drawFace(face,v11,v22,v33,v44,darkBrown,false,true); 
  faceShape.addChild(face);
  
  face = createShape();
  face = drawFace(face,v1,v2,v22,v11,brown,false,false);
  faceShape.addChild(face);
  
  face = createShape();
 face = drawFace(face,v2,v3,v33,v22,brown,false,false);
 faceShape.addChild(face);
 
 face = createShape();
  face = drawFace(face,v3,v33,v44,v4,brown,false,false);
  faceShape.addChild(face);
  
  face = createShape();
 face = drawFace(face,v1,v11,v44,v4,brown,false,false);
 faceShape.addChild(face);
  
}

PShape drawFace(PShape face,PVector c1, PVector c2, PVector c3, PVector c4,color c,boolean isStrokeActive,boolean isPorusFace)
{ 
   face.beginShape(POLYGON);
   
   
   face.fill(c);
   if(isStrokeActive)
    {
      face.stroke(5);
      face.strokeWeight(2);
    }else
     face.noStroke();
     
     face.vertex(c1.x, c1.y, c1.z);
     face.vertex(c2.x, c2.y, c2.z);
     face.vertex(c3.x, c3.y, c3.z);
     face.vertex(c4.x, c4.y, c4.z);
     
     if(isPorusFace)
   {
    if( faceType.equals("-o") || faceType.equals("+o"))
    insertPorousintoRadialWall(face,c1,c2,c3);
   }
     face.endShape();
     return face;
}
public void setFaceWeight(Float tanLen,Float radLen,String cellType)
  {
   
    if(cellType.equals("EARLY_WOOD"))
      {
        maxTanZFaceWeight = tanLen / 5 ;
        maxRadXFaceWeight = radLen / 6 ;
      }
     else if(cellType.equals("LATE_WOOD"))
     {
       maxTanZFaceWeight = tanLen / 4 ;
       maxRadXFaceWeight = radLen / 4 ;
     }
     
  }
  /*
   Since the porous are inserted radial face , x = const , minY = v2.y maxY = v1.y, minZ = v2.z , maxZ = v3.z
   if its tangential face Z would have been constant.
  */
void insertPorousintoRadialWall(PShape cellWall,PVector v1,PVector v2,PVector v3)
{
  
   int holeRes = 50 ;                        // no of face to construct circle
  float holeRad = maxRadXFaceWeight * 0.50; // 25 % of cell face 
  
  float x = v1.x;
  float maxY = v1.y ;
  float minY = v2.y ;
  float maxZ ;
  float minZ  ;
  println(""+v2.z,v3.z);
  if(faceType.equals("-o") )
  {
     maxZ = v3.z - holeRad;
     minZ = v2.z + holeRad ;
  }
  else
  {
    maxZ = v2.z - holeRad;
    minZ = v3.z + holeRad ;
  } 
 
 
   
  float incY = maxY / 10 ;
    float py = minY + incY ;
    float pz = minZ + ((maxZ - minZ) / 2) ;
    //float pz = (minZ,maxZ);
 while( py < (maxY - incY) )
 {
    println(" points ==>"+py,pz);
   cellWall.beginContour();
    //println("*****************************************************************************");
  for(int i = 0 ; i < holeRes;i++)
  {
   
   float angle = TWO_PI  * i / holeRes;
   float cz =  pz + sin(  angle ) * (holeRad);
   float cy = py + cos(  angle  ) * (holeRad);
   cellWall.vertex( x + 1, cy,cz);
  
  }
  // println("*****************************************************************************");
  cellWall.endContour();
  py = py + incY ;
 }
  
}

 public PVector getV11CoordinatesForFace()
   {
     PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = v1.x - maxRadXFaceWeight ;
       v.y = v1.y;
       v.z = v1.z  ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = v1.x  ;
       v.y = v1.y;
       v.z = v1.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("+o"))
     {
      v.x = v1.x +  maxRadXFaceWeight ;
       v.y = v1.y;
       v.z = v1.z  ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = v1.x  ;
       v.y = v1.y;
       v.z = v1.z +  maxTanZFaceWeight ;
       
     }
     return v;
   }
   
   public PVector getV22CoordinatesForFace()
   {
     PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = v2.x - maxRadXFaceWeight ;
       v.y = v2.y;
       v.z = v2.z  ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = v2.x  ;
       v.y = v2.y;
       v.z = v2.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("+o"))
     {
      v.x = v2.x +  maxRadXFaceWeight ;
       v.y = v2.y;
       v.z = v2.z  ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = v2.x  ;
       v.y = v2.y;
       v.z = v2.z +  maxTanZFaceWeight ;
       
     }
     return v;
   }
   
   public PVector getV33CoordinatesForFace()
   {
   PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = v3.x - maxRadXFaceWeight ;
       v.y = v3.y;
       v.z = v3.z  ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = v3.x  ;
       v.y = v3.y;
       v.z = v3.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("+o"))
     {
      v.x = v3.x +  maxRadXFaceWeight ;
       v.y = v3.y;
       v.z = v3.z  ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = v3.x  ;
       v.y = v3.y;
       v.z = v3.z +  maxTanZFaceWeight ;
       
     }
     return v;
   }
   
    public PVector getV44CoordinatesForFace()
   {
     PVector v = new PVector();
     
     if(faceType.equals("-o"))
     {
       v.x = v4.x - maxRadXFaceWeight ;
       v.y = v4.y;
       v.z = v4.z  ;
     }
     else if(faceType.equals("-e"))
     {
       v.x = v4.x  ;
       v.y = v4.y;
       v.z = v4.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("+o"))
     {
      v.x = v4.x +  maxRadXFaceWeight ;
       v.y = v4.y;
       v.z = v4.z  ;
       
     }
     else if(faceType.equals("+e"))
     {
       v.x = v4.x  ;
       v.y = v4.y;
       v.z = v4.z +  maxTanZFaceWeight ;
       
     }
     return v;
   }
   
}
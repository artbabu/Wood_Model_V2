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
  face = drawFace(face,v1,v2,v3,v4,brown,true);
  faceShape.addChild(face);
  
  face = createShape();
  face = drawFace(face,v11,v22,v33,v44,darkBrown,false); 
  faceShape.addChild(face);
  
  face = createShape();
  face = drawFace(face,v1,v2,v22,v11,brown,false);
  faceShape.addChild(face);
  
  face = createShape();
 face = drawFace(face,v2,v3,v33,v22,brown,false);
 faceShape.addChild(face);
 
 face = createShape();
  face = drawFace(face,v3,v33,v44,v4,brown,false);
  faceShape.addChild(face);
  
  face = createShape();
 face = drawFace(face,v1,v11,v44,v4,brown,false);
 faceShape.addChild(face);
  
}

PShape drawFace(PShape face,PVector c1, PVector c2, PVector c3, PVector c4,color c,boolean isStrokeActive)
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
     face.endShape();
     return face;
}
public void setFaceWeight(Float tanLen,Float radLen,String cellType)
  {
   
    if(cellType.equals("EARLY_WOOD"))
      {
        maxTanZFaceWeight = tanLen / 4 ;
        maxRadXFaceWeight = radLen / 4 ;
      }
     else if(cellType.equals("LATE_WOOD"))
     {
       maxTanZFaceWeight = tanLen / 3 ;
       maxRadXFaceWeight = radLen / 3 ;
     }
     
  }

 public PVector getV11CoordinatesForFace()
   {
     PVector v = new PVector();
     
     if(faceType.equals("+e"))
     {
       v.x = v1.x - maxRadXFaceWeight ;
       v.y = v1.y;
       v.z = v1.z  ;
     }
     else if(faceType.equals("+o"))
     {
       v.x = v1.x  ;
       v.y = v1.y;
       v.z = v1.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("-e"))
     {
      v.x = v1.x +  maxRadXFaceWeight ;
       v.y = v1.y;
       v.z = v1.z  ;
       
     }
     else if(faceType.equals("-o"))
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
     
     if(faceType.equals("+e"))
     {
       v.x = v2.x - maxRadXFaceWeight ;
       v.y = v2.y;
       v.z = v2.z  ;
     }
     else if(faceType.equals("+o"))
     {
       v.x = v2.x  ;
       v.y = v2.y;
       v.z = v2.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("-e"))
     {
      v.x = v2.x +  maxRadXFaceWeight ;
       v.y = v2.y;
       v.z = v2.z  ;
       
     }
     else if(faceType.equals("-o"))
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
     
     if(faceType.equals("+e"))
     {
       v.x = v3.x - maxRadXFaceWeight ;
       v.y = v3.y;
       v.z = v3.z  ;
     }
     else if(faceType.equals("+o"))
     {
       v.x = v3.x  ;
       v.y = v3.y;
       v.z = v3.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("-e"))
     {
      v.x = v3.x +  maxRadXFaceWeight ;
       v.y = v3.y;
       v.z = v3.z  ;
       
     }
     else if(faceType.equals("-o"))
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
     
     if(faceType.equals("+e"))
     {
       v.x = v4.x - maxRadXFaceWeight ;
       v.y = v4.y;
       v.z = v4.z  ;
     }
     else if(faceType.equals("+o"))
     {
       v.x = v4.x  ;
       v.y = v4.y;
       v.z = v4.z - maxTanZFaceWeight ;
       
     }
     else if(faceType.equals("-e"))
     {
      v.x = v4.x +  maxRadXFaceWeight ;
       v.y = v4.y;
       v.z = v4.z  ;
       
     }
     else if(faceType.equals("-o"))
     {
       v.x = v4.x  ;
       v.y = v4.y;
       v.z = v4.z +  maxTanZFaceWeight ;
       
     }
     return v;
   }
   
}
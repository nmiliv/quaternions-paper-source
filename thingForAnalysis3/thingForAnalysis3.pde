Quaternion[] qPoints = new Quaternion[32];
Quaternion rotator = new Quaternion(1, 0, 0, 0);
Quaternion totalRot = new Quaternion(1, 0, 0, 0);
PShape point;
PShape bigPoint;
float radius = 256;
int timer = 0;
int mover = 0;
int timing = 150;
int running = 0;

void setup(){
  for(int i = 0; i < qPoints.length; i++){qPoints[i] = new Quaternion();}
  size(1024, 1024, P3D);
  surface.setTitle("apple");
  setPoints();
  point = createShape(SPHERE, 10);
  bigPoint = createShape(SPHERE, 256);
  bigPoint.setFill(0x00000000);
  bigPoint.setStroke(#FFFFFF);
  rotator.fromAngleVec(-0.02, 0, 0);
}

void draw(){
   background(#000000);
  translate(width/2, height/2, -300);
  //*
  rotateX(radians(-700/5+180));
  rotateZ(radians(-timer/5+180));
  /*/
  rotateX(radians(-mouseY/5+180));
  rotateZ(radians(-mouseX/5+180));
  //*/
  
  strokeWeight(5);
  stroke(#FFFFFF);
  line(-4*radius, 0, 0, 4*radius, 0, 0);
  line(0, -4*radius, 0, 0, 4*radius, 0);
  strokeWeight(1);
  for(int i = (int)(-4*radius); i <= 4*radius; i += radius){
    line(i, -4*radius, 0, i, 4*radius, 0);
    line(-4*radius, i, 0, 4*radius, i, 0);
  }
  strokeWeight(2);
  point.setFill(#4040FF);
  point.setStroke(#4040FF);
  for(int i = 0; i < qPoints.length; i++){
    
    pushMatrix();
    
    translate((float)(radius*(qPoints[i].i/(qPoints[i].w + radius))), 
    (float)(radius*(qPoints[i].j/(qPoints[i].w + radius))), 
    (float)(radius*(qPoints[i].k/(qPoints[i].w + radius))));
    
    if(i == 16){
      point.setFill(#00FF00);
      point.setStroke(#00FF00);
    }else if(i == 30){
      point.setFill(#FFFF00);
      point.setStroke(#FFFF00);
    }
    shape(point);
    point.setFill(#FF0000);
    point.setStroke(#FF0000);
    popMatrix();
    //*
    if(timer % timing <= 100){ // theres an issue with one of these comparisons
      if(mover % 200 <= 100){ // somewhere in the code (one of them shouldn't
        qPoints[i].mult(rotator); // be an or-equals), but I'm too lazy to fix it
      }else{
        qPoints[i].backmult(rotator);
      }
    }
    //*/
  }
  
  rotateX(-totalRot.toEuler(0));
  rotateY(-totalRot.toEuler(1));
  rotateZ(-totalRot.toEuler(2));
  shape(bigPoint);
  
  if(timer % timing <= 100){
    mover+=running;
  }
  if(mover % 100 == 0){
    rotator = rotator.inverse();
    
    //delay(500);
  }
  timer += running;
  //while(true);
}

void setPoints(){
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 8; j++){
      qPoints[8*i+j].i = radius*cos((float)j/8.0*TWO_PI)*cos((float)i/4.0*PI);
      qPoints[8*i+j].j = radius*sin((float)j/8.0*TWO_PI);
      qPoints[8*i+j].k = radius*sin((float)i/4.0*PI)*cos((float)j/8.0*TWO_PI);
    }
  }
}

void keyPressed(){
  running = 1;
}

float[][] points = new float[32][3];
Quaternion[] qPoints = new Quaternion[32];
Quaternion rotator = new Quaternion(1, 0, 0, 0);
Quaternion totalRot = new Quaternion(1, 0, 0, 0);
PShape point;
PShape bigPoint;
float radius = 256;
int timer = 1;
int running = 0;

void setup(){
  for(int i = 0; i < qPoints.length; i++){qPoints[i] = new Quaternion();}
  size(1024, 1024, P3D);
  surface.setTitle("apple");
  setPoints();
  point = createShape(SPHERE, 10);
  bigPoint = createShape(SPHERE, radius);
  bigPoint.setFill(color(0x00FFFFFF));
  bigPoint.setStroke(#FFFFFF);
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
  
  for(int i = 0; i < qPoints.length; i++){
    
    stroke(#FFFF00);
    line(0, 0, -radius, 
    (float)qPoints[i].i, (float)qPoints[i].j, (float)qPoints[i].k);
    line((float)qPoints[i].i, (float)qPoints[i].j, (float)qPoints[i].k, 
    (float)(radius*qPoints[i].i/(qPoints[i].k + radius)), 
    (float)(radius*qPoints[i].j/(qPoints[i].k + radius)), (float)0.0);
    
    pushMatrix();
    translate((float)(radius*((qPoints[i].i)/(qPoints[i].k + radius))), 
    (float)(radius*((qPoints[i].j)/(qPoints[i].k + radius))), 0.0);
    
    point.setFill(#4040FF);
    point.setStroke(#4040FF);
    shape(point);
    popMatrix();
    
    pushMatrix();
    point.setFill(#FF0000);
    point.setStroke(#FF0000);
    translate((float)qPoints[i].i, (float)qPoints[i].j, (float)qPoints[i].k);
    shape(point);
    popMatrix();
    qPoints[i].totalRotate(rotator);
  }
  pushMatrix();
  rotateX(-totalRot.toEuler(0));
  rotateY(-totalRot.toEuler(1));
  rotateZ(-totalRot.toEuler(2));
  shape(bigPoint);
  popMatrix();
  totalRot.mult(rotator);
  timer += (int)running;
  if(timer % 100 == 0){
    rotator.fromAngleVec(radians(1), 
    radians(0), 
    radians(random(0, 360)));
    //rotator.mult(new Quaternion(sqrt(2.0)/2.0, sqrt(2.0)/2.0, 0, 0));
  }
  //shape(point);
}

void setPoints(){
  /*
  for(int i = 0; i < points.length; i++){
    points[i][0] = radius * sin(12*i)*sin(map(i, 0, points.length, 0, PI));
    points[i][1] = radius * cos(12*i)*sin(map(i, 0, points.length, 0, PI));
    points[i][2] = radius * cos(map(i, 0, points.length, 0, PI));
  }
  /*/
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 8; j++){
      points[8*i+j][0] = radius*cos((float)j/8.0*TWO_PI)*cos((float)i/4.0*PI);
      points[8*i+j][1] = radius*sin((float)j/8.0*TWO_PI);
      points[8*i+j][2] = radius*sin((float)i/4.0*PI)*cos((float)j/8.0*TWO_PI);
    }
  }
  //*/
  for(int i = 0; i < 4; i++){
    for(int j = 0; j < 8; j++){
      qPoints[8*i+j].i = radius*cos((float)j/8.0*TWO_PI)*cos((float)i/4.0*PI);
      qPoints[8*i+j].j = radius*sin((float)j/8.0*TWO_PI);
      qPoints[8*i+j].k = radius*sin((float)i/4.0*PI)*cos((float)j/8.0*TWO_PI);
    }
  }
  //*/
}

void keyPressed(){
  running = 1;
}

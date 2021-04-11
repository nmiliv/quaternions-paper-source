float[][] points = new float[12][2];
float radius = 256;
float offset = 0;
int timer = 100;
float direction = 0.005;

void setup(){
  size(1024, 1024);
  surface.setTitle("apple");
  ellipseMode(RADIUS);
  setPoints();
}

void draw(){
  background(#000000);
  stroke(#FFFFFF);
  strokeWeight(2);
  fill(#000000);
  ellipse(width/2, height/2, radius, radius);
  line(0, height/2, width, height/2);
  line(width/2, 0, width/2, height);
  for(int i = 0; i < points.length; i++){
    stroke(#FFFF00);
    line(width/2 - radius, height/2, 
    10*(points[i][0] + radius) - radius + width/2, 10*points[i][1] + height/2);
    
    stroke(#5050FF);
    fill(#4040FF);
    ellipse(width/2, radius*(points[i][1]/(points[i][0] + radius))+height/2, 10, 10);
    
    stroke(#FF2020);
    fill(#FF0000);
    ellipse(points[i][0] + width/2, points[i][1] + height/2, 10, 10);
  }
  offset -= direction * 100.0/(150 - timer);
  setPoints();
  timer--;
  if(timer == 0){
    timer = 100;
    direction = 0.005*(2*(int)random(0.0, 2.0) - 1) + random(-0.002, 0.002);
  }
}

void setPoints(){
  for(int i = 0; i < points.length; i++){
    points[i][0] = radius * cos(TWO_PI*(float)i/points.length + offset);
    points[i][1] = radius * sin(TWO_PI*(float)i/points.length + offset);
  }
}

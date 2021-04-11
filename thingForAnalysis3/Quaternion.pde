class Quaternion{
  public double w;
  public double i;
  public double j;
  public double k;
  
  public Quaternion(double w, double i, double j, double k){
    this.w = w;
    this.i = i;
    this.j = j;
    this.k = k;
  }
  
  public Quaternion(){
    this.w = 0;
    this.i = 0;
    this.j = 0;
    this.k = 0;
  }
  
  public void normalize(float tolerance){
    float size = (float)(w*w + i*i + j*j + k*k);
    if(abs(1.0 - size) >= tolerance){
      size = sqrt(size);
      w /= size;
      i /= size;
      j /= size;
      k /= size;
    }
  }
    
  public void normalize(){
    double tolerance = 0.01;
    float size = (float)(w*w + i*i + j*j + k*k);
    if(abs(1.0 - size) >= tolerance){
      size = sqrt(size);
      w /= size;
      i /= size;
      j /= size;
      k /= size;
    }
  }
    
  public void mult(Quaternion quart){
    Quaternion temp = new Quaternion(this.w, this.i, this.j, this.k);
    this.w = temp.w*quart.w - temp.i*quart.i - temp.j*quart.j - temp.k*quart.k;
    this.i = temp.w*quart.i + temp.i*quart.w + temp.j*quart.k - temp.k*quart.j;
    this.j = temp.w*quart.j - temp.i*quart.k + temp.j*quart.w + temp.k*quart.i;
    this.k = temp.w*quart.k + temp.i*quart.j - temp.j*quart.i + temp.k*quart.w;
  }
  
  public void backmult(Quaternion quart){
    Quaternion temp = new Quaternion(this.w, this.i, this.j, this.k);
    this.w = temp.w*quart.w - temp.i*quart.i - temp.j*quart.j - temp.k*quart.k;
    this.i = temp.w*quart.i + temp.i*quart.w - temp.j*quart.k + temp.k*quart.j;
    this.j = temp.w*quart.j + temp.i*quart.k + temp.j*quart.w - temp.k*quart.i;
    this.k = temp.w*quart.k - temp.i*quart.j + temp.j*quart.i + temp.k*quart.w;
  }
  
  public void totalRotate(Quaternion quart){
    this.mult(quart);
    Quaternion temp = quart.inverse();
    temp.mult(this);
    this.w = temp.w; this.i = temp.i; this.j = temp.j; this.k = temp.k;
  }
  
  public Quaternion inverse(){
    return new Quaternion(this.w, -this.i, -this.j, -this.k);
  }
  
  public Quaternion copy(){
    return new Quaternion(this.w, this.i, this.j, this.k);
  }
  
  public void fromAngleVec(float angle, float heading, float elevation){
    angle *= 0.5;
    this.w = cos(angle);
    this.i = cos(heading) * cos(elevation) * sin(angle);
    this.j = sin(elevation) * sin(angle);
    //this.j = 0;
    this.k = sin(heading) * cos(elevation) * sin(angle);
    
    this.normalize();
  }
  
  public void fromEuler(float x, float y, float z){ //something wrong here
    double cosX = cos(x * 0.5);
    double sinX = sin(x * 0.5);
    double cosY = cos(y * 0.5);
    double sinY = sin(y * 0.5);
    double cosZ = cos(z * 0.5);
    double sinZ = sin(z * 0.5);
    
    this.w = cosX * cosY * cosZ + sinX * sinY * sinZ;
    this.i = sinX * cosY * cosZ - cosX * sinY * sinZ;
    this.j = cosX * sinY * cosZ + sinX * cosY * sinZ;
    this.k = cosX * cosY * sinZ - sinX * sinY * cosZ;
  }
  
  public float toEuler(int angleNum){ //and something wrong here
    switch(angleNum){
      case 0 :
        return atan2((float)(2 * (w * i + j * k)), (float)(1 - 2*(i*i + j*j)));
      case 1 :
        float sinY = (float)(2 * (w * j - i * k));
        if(abs(sinY) >= 1){
          return copysign(HALF_PI, sinY);
        }else{
          return asin(sinY);
        }
      case 2 :
        return atan2((float)(2 * (w * k + i * j)), (float)(1 - 2*(j * j + k * k)));
      default:
        return 0;
    }
  }
  
}

float copysign(float value, float sign){
  if(sign >= 0){
    return abs(value);
  }else{
    return -abs(value);
  }
}

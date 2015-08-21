/**
 * A creature — kindof Jellyfish — with n legs inspired in the plankton.
 * Thanks to Proce55ing, Walker, etc (…of course).
 * Floats it's life away in the Abyss ecosystem.
 */ 

// a new variable to allow random input
float halfWidth;
float halfHeight;
float borderWidth;
float borderHeight;

class HTMPreGelly extends SuperCreature {
 
  int headDetail = 72;       // 360º multiples
  int headCurveDetail = 120; //
  int headCapCCount = int( random(14, 24) );  //
  //int headCapCCount = 14;    //
  int headLoftAngle = 360;   //
  //int legCount = 5; 
  int legCount = int( random(1, 7) ); // maximum 7 (otherwise you know down the viewer)
  //int legMovePower = 300;  //
  float legMovePower = random(100., 500.);

  int sz, lgth, nb;
  float ang;
  float vel, freqY, ampY;
  int count;
  
  float[] capPointAngle = new float[headCapCCount];  //
  float capPointAngleBase = 0;      //
  float capPointStetchBaseSpd = 0;   //
  float headWitherPower;            //
  
  float[] legAngleBase = new float[legCount];    //
  float[] legAngleBaseSpd = new float[legCount]; //
  float[][] legPointAngleBase = new float[legCount][headCapCCount];  //
  
  PVector position = new PVector();  //
  float directionAngle;              //
  int tellCounter;                   //
  float headSize;                    //
  
public HTMPreGelly(){ 
    creatureAuthor  = "Horacio Tome-Marques";
    creatureName    = "PreGelly";
    creatureVersion = "Beta";
    setDate(2015, 7, 14); //Y,M,D
    
    init();  
    position.x = random(width) - halfWidth;
    position.y = random(height) - halfHeight;
  }
  
  // 
  void init(){
    // 
    for (int i = 0; i < legCount; i++) {
      legAngleBaseSpd[i] = random(1) * 2+ 0.2;
    }
     capPointStetchBaseSpd = random(1) + 1;  //
     headSize = random(5) + 5;  //
     headWitherPower = random(1) * 0.1 + 0.01;  //
     directionAngle = random(headLoftAngle);  //
  }
  
    void move() {
    count++;
    pos.x += cos(ang) * vel;
    pos.y = cos(count*freqY) * ampY;
    pos.z += sin(ang) * vel;
    rot.y = -ang;
    applyTransforms();
  }
  
  void draw(){
    pushMatrix();
    
    // 
    translate(position.x, position.y, position.z);
    rotateZ((radians(directionAngle)));
    rotateX((radians(-30)));
   
    behavior();
    drawtheLegs();
    drawtheHead();
    popMatrix();
  }
  
  // Behaviour
  protected void behavior(){
    
    // 
    for (int i = headCapCCount - 1; i > 0; i--) {
      capPointAngle[i] = capPointAngle[i - 1] * 0.999 - (0.1 * i * i);
    }
    capPointAngleBase += capPointStetchBaseSpd;
    capPointAngle[0] = (sin(radians(capPointAngleBase)) + 2) * 15 + 15;
  
    // 
    for (int j = 0; j < legCount; j++) {
      for (int i = headCapCCount - 1; i > 0; i--) {
        legPointAngleBase[j][i] = legPointAngleBase[j][i-1] * 1.2;
      }
      legPointAngleBase[j][0] = sin(radians(legAngleBase[j])) * 3;
      legAngleBase[j] += legAngleBaseSpd[j];
    }
    
    // 
    position.x += cos(radians(directionAngle - 90)) * abs(cos(radians((capPointAngleBase + 50) / 2))) * 0.5;
    position.y += sin(radians(directionAngle - 90)) * abs(cos(radians((capPointAngleBase + 50) / 2))) * 0.5;
    
    // 
    boolean returnFlag = false;
    if(position.x < -borderWidth){
      position.x = -borderWidth;
      returnFlag = true;
    }else if(position.x > borderWidth){
      position.x = borderWidth;
      returnFlag = true;
    }else if(position.y < -borderHeight){
      position.y = -borderHeight;
      returnFlag = true;
    }else if(position.y > borderHeight){
      position.y = borderHeight;
      returnFlag = true;
    }    
    if(returnFlag){
      directionAngle += headLoftAngle / 2;
    }
  }
  
  // Legs/hairs
  protected void drawtheLegs() {
    //noStroke();
    noFill();
    strokeWeight(1);
    stroke(200, 200, 200, 100);
    //fill(128, 128, 128, 12);
    float x = 0, y = 0, z = 0;
    int rCount = headLoftAngle / legCount;
    for (int r = 0; r < headLoftAngle ;r += rCount) {
  
      pushMatrix();
      sphereDetail(2, 2);
      for (int i = 0; i < headCapCCount; i++) {
        float deg = sin((radians((legPointAngleBase[r / rCount][i])))) * legMovePower;
        x = sin(radians(deg)) * 32 * sin(radians(r));
        y = cos(radians(deg)) * 20;
        z = sin(radians(deg)) * 20 * cos(radians(r));
        translate(x, y, z);
        scale(0.95, 0.95, 0.95);
        sphere(6);
      }
      popMatrix();
    }
  }
  
  // Head
  protected void drawtheHead() {
        fill(255,34);
        //noFill();
    strokeWeight(1);
    stroke(200, 200, 200, 100);
    //fill(128, 128, 128, 12);
  
    for (int r = 0; r < headLoftAngle ;r += headDetail) {
  
      float x = 0, y = 0, z = 0;
      float tx = 0, ty = 0, tz = 0;
  
      pushMatrix();
      float p = 1;
      
      // The head itself (mushroom) /
      beginShape(TRIANGLE_STRIP);
      for (int i = 0; i < headCapCCount; i++) {
        p -= headWitherPower;
        float deg = sin((radians((capPointAngle[i])))) * headCurveDetail;
        x += sin(radians(deg)) * headSize * sin(radians(r)) * p;
        y += cos(radians(deg)) * headSize;
        z += sin(radians(deg)) * headSize * cos(radians(r)) * p;
        vertex(x, y, z);
  
        tx += sin(radians(deg)) * headSize * sin(radians(r + headDetail)) * p;
        ty += cos(radians(deg)) * headSize;
        tz += sin(radians(deg)) * headSize * cos(radians(r + headDetail)) * p;
        vertex(tx, ty, tz);
      }
      endShape();
      popMatrix();
    }
  }
}

/**
 * A creature with n tentacles inspired in the plankton.
 * Thanks to Andreas Gysin, Laura Perrenoud, etc (…of course).
 * Floats it's life away in the Abyss ecosystem.
 */
class HTMZoid extends SuperCreature {
  PVector fPos, fAng;
  float cSize;
  int segments;
  int numberT;
  float bLen;
  float aFreq;
  float bOffs;
  float angRange;

  public HTMZoid() {
    creatureAuthor  = "Horacio Tome-Marques";
    creatureName    = "Zoid";
    creatureVersion = "Beta";
    setDate(2014, 12, 22); //Y,M,D

    cSize = random(20, 30);
    fPos = new PVector(random(-0.004, 0.004), random(-0.004, 0.004), random(-0.004, 0.004));
    fAng = new PVector(random(-0.002, 0.002), random(-0.002, 0.002), random(-0.002, 0.002));
    
    segments = int(random(2, 20));
    bLen = random(20, 30);
    aFreq = random(0.01, 0.03);
    bOffs = random(5);
    angRange = random(0.6, 0.7);
    numberT = int(random(6, 12));
  }

  void move() {    
    pos.x += sin(frameCount*fPos.x);
    pos.y += sin(frameCount*fPos.y);
    pos.z += cos(frameCount*fPos.y);

    //rot.x = sin(frameCount*fAng.x) * TWO_PI;
    //rot.y = sin(frameCount*fAng.y) * TWO_PI;
    //rot.z = sin(frameCount*fAng.z) * TWO_PI; 
    
    rot.x = sin(frameCount*fAng.x) / TWO_PI;
    rot.y = sin(frameCount*fAng.y) * HALF_PI;
    rot.z = sin(frameCount*fAng.z) * TWO_PI; 
  }

  void draw() {    
    applyTransforms(); // can be also manipulated by inputing data (osc)  
    // noFill();
    fill(255,64);
    stroke(255, 100);

    // body // can be also manipulated by inputing data (osc)
    strokeWeight(1);
    //sphere(cSize);
    //sphereDetail(3, 2);
    triangle(0, -20, -20, 20, 20, 20);
    rotateY(-PI/2);
    triangle(0, -20, -20, 20, 20, 20);
    rotateY(-PI/4);
    //triangle(0, -20, -20, 20, 20, 20);
    //rotateY(-PI/3);
    //triangle(0, -20, -20, 20, 20, 20);
    //rotateY(-PI/6);



    
    // tentacles // can be also manipulated by inputing data (osc)
    strokeWeight(2);
    stroke(255,64);
    noFill();
    for (int j=0; j<numberT; j++) {
      PVector p = new PVector(bLen, 30); 
      PVector pos = new PVector(cSize/2, 6); 
      //float ang = sin(frameCount*aFreq + j%7 * bOffs) * angRange;
       float ang = sin(frameCount*aFreq + j % 9 * bOffs) * angRange;
      float l = bLen;
      beginShape();
      for (int i=0; i<segments+3; i++) {
        vertex(pos.x, pos.y);
        pos.x += p.x;
        pos.y += p.y;
        p = rotateVec(p, ang);
        p.limit(l);
        l *= 2.93; // can be also manipulated by inputing data (osc)
      }
      endShape();
      //rotateY(HALF_PI);
       rotateY(PI*2/numberT);
    }
  }

  PVector rotateVec(PVector v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return new PVector(v.x*c - v.y*s, v.x*s + v.y*c);
  }    
}

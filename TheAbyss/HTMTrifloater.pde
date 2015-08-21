/**
 * A trifloating fish!;–}
 * Position is calculated with Perlin noise.
 * Hached from AGFloater by Andreas Gysin, (…of course).
 * Floats it's life away in the Abyss ecosystem.
 */
class HTMTrifloater extends SuperCreature {

  PMatrix3D mat;
  float offset;
  float ampBody, ampWing;
  float freqBody, freqWing;
  float wBody, hBody, wWing;
  float noiseScale, noiseOffset;
  float speedMin, speedMax;

  public HTMTrifloater() {
    creatureAuthor  = "Horacio Tome-Marques";
    creatureName    = "TriFloater";
    creatureVersion = "Beta";
    setDate(2014, 12, 29); //Y,M,D

    mat = new PMatrix3D();
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(-0.2, 0.2));

    freqBody = random(0.1, 0.2);
    freqWing = freqBody;
    offset = 1.2 + random(-0.1,0.2);
    float s = 0.9;
    ampBody = random(10, 30)*s;
    ampWing = random(0.6, 1.2)*s;
    wBody = random(20, 40)*s;
    hBody = random(30, 90)*s;
    wWing = random(20, 50)*s;
    speedMin = random(2.5,3.5)*s;
    speedMax = random(4.5,5.5)*s;
    
    noiseScale = 0.012;
    noiseOffset = random(1); 
  }

  void move() {
    mat.rotateY(map(noise(frameCount * noiseScale + noiseOffset), 0, 1, -0.1, 0.1));
    float speed = map(sin(frameCount * freqBody), -1, 1, speedMin, speedMax);   
    mat.translate(0 , 0, speed);
    mat.mult(new PVector(), pos); //update the position vector
  }

  void setPos(PVector p) {
    float[] a = mat.get(null);
    a[3] = p.x;
    a[7] = p.y;
    a[11] = p.z;
    mat.set(a);
  }

  void draw() {
    applyMatrix(mat);
    stroke(255, 65);

    //noStroke();
    fill(255,65);
    rotateX(-HALF_PI);
       // triangle(0, 200, 351, 360, 288, 360); //testing
    scale(min(getEnergy() * 0.1, 1));

    float h1 = sin(frameCount * freqBody) * ampBody;
    float h2 = sin(frameCount * freqWing + offset) * ampWing;

pushMatrix();
    translate(0, 0, h1);
    rectMode(CENTER);
    rect(0, 0, wBody, hBody);
    rotateY(-PI/2);
        triangle(0, 0, -20, 30, 0, 100);
    //triangle(20, 30, -20, 30, 0, 100);
 popMatrix();
 
    rectMode(CORNER);
    pushMatrix();
    translate(-wBody/2, -hBody/2, 0);
    rotateY(PI - h2);
    //rect(0, 0, wWing, hBody);
    triangle(0, 0, 0, 60, wWing, hBody);
    popMatrix();

    pushMatrix();
    translate(wBody/2, -hBody/2, 0);
    rotateY(h2);
    //rect(0, 0, wWing, hBody);
    triangle(0, 0, 0, 60, wWing, hBody);
    popMatrix();
  }
}

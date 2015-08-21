/**
 * A creature with n tentacles inspired in the plankton.
 * Thanks to Andreas Gysin, Maxime Castelli, etc (…of course).
 * Floats it's life away in the Abyss ecosystem.
 */ 

class HMTGelly extends SuperCreature {

  int sz, lgth, nb;
  float ang;
  float vel, freqY, ampY;
  //PVector colorThing;
  PVector hairThings;
  int count;

  public HMTGelly() {
    creatureAuthor  = "Horacio Tome-Marques";
    creatureName    = "ProtoGelly";
    creatureVersion = "Beta";
    setDate(2015, 7, 14); //Y,M,D

    freqY = random(0.01, 0.03);
    ampY = random(30, 90);
    //    colorThing = new PVector();
    //    colorThing.x = random(0.001, 0.004); 
    //    colorThing.y = random(0.001, 0.004); 
    //    colorThing.z = random(0.001, 0.004);

    ang = random(TWO_PI);
    vel = random(1, 2);

    hairThings = new PVector();
    hairThings.x = random(0.01, 0.25);
    hairThings.y = random(0.01, 0.15);
  }

  void move() {
    count++;
    pos.x += cos(ang) * vel;
    pos.y = cos(count*freqY) * ampY;
    pos.z += sin(ang) * vel;
    rot.y = -ang;
    applyTransforms();
  }

  void draw() {

    sz = 25;
    lgth = 300;
    nb = lgth /sz ;

    noFill();
    stroke(255, 60);
    strokeWeight(1);
  //rotateX(mouseY * 0.05);
  rotateY(mouseX * 0.05);
  //rotateY(random(0.01 * 0.02, 1.05 * 0.05));
    //rotateY(PI);

    //Head_Mushroom
    sphereDetail(3);
  //sphereDetail(mouseX / 12);
    for (int i=0; i<3; i++) {
      pushMatrix();
      translate(0 +i*0, -10 +(sin(i+count*0.1)));
//  rotateX(mouseY * 0.05);
//  rotateY(mouseX * 0.05);
      scale(1, i*1.8);
      sphere(12);
      popMatrix();
    }
    //Hair1
    rotateZ(89.1);
    //rotateZ(random(89.9, 90.0));
    translate(0, -0);
    beginShape(TRIANGLE_STRIP);
        stroke(255, 20);
    for (int j=0; j<20;j++) {
      vertex(j*10, sin(j-(count* hairThings.x))*(j), cos(j-(count* hairThings.y))*(j));
      endShape();
    }
    //Hair2
    rotateZ(89.2);
    //rotateY(90.);
    //rotateZ(random(89.9, 90.0));
    translate(0, -0);
    beginShape(TRIANGLE_STRIP);
        stroke(255, 20);
    for (int j=0; j<22;j++) {
      vertex(j*10, sin(j-(count* hairThings.x))*(j), cos(j-(count* hairThings.y))*(j));
      endShape();
    }
    //Hair2
    rotateZ(80.0);
    //rotateZ(random(89.9, 90.0));
    translate(0, -0);
    beginShape(TRIANGLE_STRIP);
        stroke(255, 20);
    for (int j=0; j<13;j++) {
      vertex(j*10, sin(j-(count* hairThings.x))*(j), cos(j-(count* hairThings.y))*(j));
      endShape();
    }
  }
}

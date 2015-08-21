class TAZEEGRepresentation extends SuperCreature {
  //The class is used to represent EEG signals

  // lineSphere variables
  PVector origin; // origin of each lineSphere
  PVector s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14; // sphere center of each lineSphere
  PVector l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11, l12, l13, l14; // minimum(x) sphere drop and maximum(y) length of each lineSphere
  int[] direction = {
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1
  }; //array to set the drawing direction of each lineSphere
  float sphereRadius = 15;
  
  String electrodeName[] = {
    "AF3", "F7", "F3", "FC5", "T7", "P7", "O1", "O2", "P8", "T8", "FC6", "F4", "F8", "AF4"
  };

  //spring motion variables
  float dampen = 0.2;
  float frequency = 25; //per frame
  
  public TAZEEGRepresentation() {
    creatureAuthor  = "Tiago Ângelo";
    creatureName    = "EEG Representation";
    creatureVersion = "0.1";
    setDate(2014, 10, 30); //Y,M,D

    origin = new PVector(0, 0, 0);
    
    // AF3 - id 0
    l1 = new PVector(100, 400);
    s1 = new PVector(origin.x, -l1.y, origin.z);
    // F7 - id 1
    l2 = new PVector(100, 400);
    s2 = new PVector(origin.x, -l2.y, origin.z);  
    // F3 - id 2
    l3 = new PVector(100, 400);
    s3 = new PVector(origin.x, -l3.y, origin.z);
    // FC5 - id 3
    l4 = new PVector(100, 400);
    s4 = new PVector(origin.x, -l4.y, origin.z);
    // T7 - id 4 
    l5 = new PVector(100, 400);
    s5 = new PVector(origin.x, -l5.y, origin.z);
    // P7 - id 5
    l6 = new PVector(100, 400);
    s6 = new PVector(origin.x, -l6.y, origin.z);
    // O1 - id 6
    l7 = new PVector(100, 400);
    s7 = new PVector(origin.x, -l7.y, origin.z);
    // O2 - id 7
    l8 = new PVector(100, 400);
    s8 = new PVector(origin.x, -l8.y, origin.z);
    // P8 - id 8
    l9 = new PVector(100, 400);
    s9 = new PVector(origin.x, -l9.y, origin.z);
    // T8 - id 9 
    l10 = new PVector(100, 400);
    s10 = new PVector(origin.x, -l10.y, origin.z);
    // FC6 - id 10 
    l11 = new PVector(100, 400);
    s11 = new PVector(origin.x, -l11.y, origin.z);
    // F4 - id 11 
    l12 = new PVector(100, 400);
    s12 = new PVector(origin.x, -l12.y, origin.z);
    // F8 - id 12
    l13 = new PVector(100, 400);
    s13 = new PVector(origin.x, -l13.y, origin.z);
    // AF4 - id 13
    l14 = new PVector(100, 400);
    s14 = new PVector(origin.x, -l14.y, origin.z);
  }

  void move() {
    
    this.energy = 100.0; // never dies
    //println("energy = "+this.getEnergy());
  }

  void draw() {
    translate(0, 250, 0);
    // AF3 - id 0
    lineSphere(s1, l1, 2, -15, 45, 0); // AF3
    // F7 - id 1
    lineSphere(s3, l3, 2, -45, 30, 1); // F7 
    // F3 - id 2
    lineSphere(s5, l5, 2, -20, 25, 2); // F3 
    // FC5 - id 3
    lineSphere(s7, l7, 2, -33, 10, 3); // FC5
    // T7 - id 4
    lineSphere(s9, l9, 2, -45, 0, 4); // T7
    // P7 - id 5
    lineSphere(s11, l11, 2, -30, -20, 5); // P7
    // O1 - id 6
    lineSphere(s13, l13, 2, -15, -40, 6); // O1
    // O2 - id 7
    lineSphere(s14, l14, 5, 15, -40, 7); // 02
    // P8 - id 8
    lineSphere(s12, l12, 5, 30, -20, 8); // P8
    // T8 - id 9
    lineSphere(s10, l10, 5, 45, 0, 9); // T8
    // FC6 - id 10
    lineSphere(s8, l8, 5, 33, 10, 10); // FC6
    // F4 - id 11
    lineSphere(s6, l6, 5, 20, 25, 11); // F4
    // F8 - id 12
    lineSphere(s4, l4, 5, 45, 30, 12); // F8
    //AF4 - id 13
    lineSphere(s2, l2, 5, 15, 45, 13); // AF4
  }

  void lineSphere(PVector sphereCenter, PVector len, float speed, float xAngle, float zAngle, int d) {
    pushMatrix();

    //translations
    rotateX(radians(xAngle));
    rotate(radians(zAngle));

    //draw line
    strokeWeight(1);
    stroke(255, 127);
    
    lights();
    fill(255, 127);
    
    line(origin.x, origin.y, origin.z, sphereCenter.x, sphereCenter.y, sphereCenter.z);

    //draw sphere
    translate(sphereCenter.x, sphereCenter.y, sphereCenter.z);
    noStroke();
    
    //sphereDetail((int)(4*sphereRadius));
    sphereDetail(2);
    sphere(sphereRadius);
    if (showElectrodeLabel) { 
      text(electrodeName[d], sphereRadius*2, sphereRadius*2);
    }
    popMatrix();

    //move
    //println(sphereCenter.y);
    /*if (sphereCenter.y >= origin.y-len.x) { direction[d] *= -1;}
     if (sphereCenter.y < -len.y) { direction[d] *= -1;}
     sphereCenter.y += speed * direction[d];*/

    //move (simple spring motion)  
    sphereCenter.y += sin((frameCount)/frequency % TWO_PI) * force[d];
    force[d] = abs(force[d] - dampen/frequency);
    //println(force);
  }
  //OSC listener
  /*void oscEvent(OscMessage theOscMessage) {
    if (theOscMessage.checkAddrPattern("/electrodes")) {
      for (int i = 0; i < force.length; i++) {
        print(theOscMessage.get(i).floatValue()+" ");
        force[i] = theOscMessage.get(i).floatValue();
      }
      println();
    }
  }*/
  
}


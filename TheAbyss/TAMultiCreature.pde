class TAMultiCreature extends SuperCreature {
  
  // Common creature variables
  PMatrix3D mat = new PMatrix3D();;
  ArrayList<PVector >points  = new ArrayList <PVector>();
  ArrayList<Node> nodes = new ArrayList<Node>();
  ArrayList<Spring> springs = new ArrayList<Spring>();
  ArrayList<Missile> missiles = new ArrayList<Missile>();
  //boolean behaviour = true; 
  PVector position = new PVector(0, 0, 0); 
  PVector prevPosition = new PVector(0, 0, 0); 
  PVector offset = new PVector(0.1, 10.45, 0); 
  PVector rotation = new PVector(1, 1, 1); 
  PVector speed = new PVector(1, 1, 1);
  PVector resize = new PVector(1, 1, 1);
  PVector frequency = new PVector (1, 1, 1);
  PVector noise = new PVector(1, 1, 1);
  PVector size1 = new PVector(1, 1, 1), size2 = new PVector(1, 1, 1), size3 = new PVector(1, 1, 1);
  PVector body1 = new PVector(1, 1, 1), body2 = new PVector(1, 1, 1), body3 = new PVector(1, 1, 1);
  PVector vectorA = new PVector(1, 1, 1), vectorB = new PVector(1, 1, 1), vectorC = new PVector(1, 1, 1);
 
  //int initLike = 5, moveLike = 5, drawLike = 6;
 
  public TAMultiCreature() {
    creatureAuthor  = "Tiago Ângelo";
    creatureName    = "TAMultiCreature";
    creatureVersion = "0.2";
    setDate(2014, 10, 26); //Y,M,D
    
    init();
    println("=====================");
    println("initLike = "+initLike);
    println("moveLike = "+moveLike);
    println("drawLike = "+drawLike);
    println("=====================");
  
  }
  
// TAMultiCreature functions 
void init(){
  switch(initLike){
  case 0: 
    initLikeAGBoxFish();
    break;
  case 1: 
    initLikeAGCubus();
    break;
  case 2: 
    initLikeAGFloater();
    break; 
  case 3: 
    initLikeAGRadio();
    break;
  case 4: 
    initLikeAGSnakeFish();
    break;
  case 5: 
    initLikeAGWorm();
    break;
  case 6: 
    initLikeEPSeaFly();
    break;  
  case 7:
    initLikeFFBreather();
    break;
  case 8: 
    initLikeLPHubert();
    break;
  case 9: 
    initLikeMCManta();
    break;
  case 10: 
    initLikeMFCreatureZero();
    break;
  case 11: 
    initLikeOTFather();
    break;
  case 12: 
    initLikePXPSonar();
    break;
  default:
    println("TAMultiCreature variables should be correctly initialized (0~12)");
    break;
  }
}

void move(){
  switch(moveLike){
  case 0: 
    moveLikeAGBoxFish();
    break;
  case 1: 
    moveLikeAGCubus();
    break; 
  case 2: 
    moveLikeAGFloater();
    break;
  case 3: 
    moveLikeAGRadio();
    break;
  case 4: 
    moveLikeAGSnakeFish();
    break;
  case 5: 
    moveLikeAGWorm();
    break;
  case 6: 
    moveLikeEPSeaFly();
    break;  
  case 7:
    moveLikeFFBreather();
    break;
  case 8: 
    moveLikeLPHubert();
    break;
  case 9: 
    moveLikeMCManta();
    break;
  case 10: 
    moveLikeMFCreatureZero();
    break;
  case 11: 
    moveLikeOTFather();
    break;
  case 12: 
    moveLikePXPSonar();
    break;
  default:
    println("TAMultiCreature variables have to be correctly initialized (0~12)");
    break;
  }
}

void draw(){
  switch(drawLike){
  case 0: 
    drawLikeAGBoxFish();
    break;
  case 1: 
    drawLikeAGCubus();
    break;
  case 2: 
    drawLikeAGFloater();
    break; 
  case 3: 
    drawLikeAGRadio();
    break;
  case 4: 
    drawLikeAGSnakeFish();
    break;
  case 5: 
    drawLikeAGWorm();
    break;
  case 6: 
    drawLikeEPSeaFly();
    break;  
  case 7:
    drawLikeFFBreather();
    break;
  case 8: 
    drawLikeLPHubert();
    break;
  case 9: 
    drawLikeMCManta();
    break;
  case 10: 
    drawLikeMFCreatureZero();
    break;
  case 11: 
    drawLikeOTFather();
    break;
  case 12: 
    drawLikePXPSonar();
    break;
  default:
    println("TAMultiCreature variables have to be correctly initialized (0~12)");
    break;
  }
}

/*AGBoxFish-like functions******************************************************************************************/
  void initLikeAGBoxFish(){
    mat = new PMatrix3D();
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(-0.1, 0.1));

    size2 = new PVector(random(10, 30), random(10, 30));
    size3 = new PVector(random(5, 50), random(5, 20));
    size1 = new PVector(random(20, 80), random(20, 80), random(15, 40));
    body1.x = random(0.1, 0.3);
    body1.z = random(0.6, 1.0);
    body1.y = random(0.8, 0.9);
    rotation.x = random(0.6, 1.0);
    speed.y = body1.x;//random(0.05, 0.1);
    speed.z = random(0.02, 0.05);
    speed.x = speed.y * 10;
    body2.x = random(1, 3);
  }
  void moveLikeAGBoxFish(){
    float s = sin(frameCount * speed.y);
    mat.rotateY(s * speed.z + (noise(pos.z * 0.01, frameCount * 0.01) -0.5) * 0.1);
    mat.rotateZ(s * speed.z * 0.3);
    mat.translate(-speed.x, 0, 0);
    mat.mult(new PVector(), pos);
  }
  void drawLikeAGBoxFish(){
    applyMatrix(mat);
    pushMatrix();
    sphereDetail(5);
    scale(min(getEnergy() * 0.1, 1)); //it's possible to animate a dying creature...
    translate(size1.x/4, 0, 0);
    float f = sin(frameCount * body1.x) * body1.z;  
    float r = sin(frameCount * body1.y) * rotation.x;
    //float h = sin(frameCount * body1.x * 0.5 + body1.z);
    //float a = map(h, -1, 1, 20, 100);  

    //noStroke();
    //fill(255,0,0 a);
    //float hr = size1.z * 0.15 + h * size1.z * 0.03;
    //sphere(hr/2);
    //sphere(hr);

    stroke(255);
    noFill();
    box(size1.x, size1.y, size1.z);

    pushMatrix();
    translate(-size1.x/2, size1.y/2, size1.z/2);
    rotateZ(HALF_PI);
    rotateY(f - 1);
    rect(0, 0, size3.x, size3.y);
    popMatrix();

    pushMatrix();
    translate(-size1.x/2, size1.y/2, -size1.z/2);
    rotateZ(HALF_PI);
    rotateY(-f + 1);
    rect(0, 0, size3.x, size3.y);
    popMatrix();

    pushMatrix();
    translate(size1.x/2, size1.y/2, size1.z/2);
    rotateY(r);
    rect(0, 0, size2.x, size2.y);
    popMatrix();

    pushMatrix();
    translate(size1.x/2, size1.y/2, -size1.z/2);
    rotateY(-r);
    rect(0, 0, size2.x, size2.y);
    popMatrix();

    noStroke();
    fill(255);
    pushMatrix();
    translate(-size1.x/2 + body2.x, size1.y/3, -size1.z/2);
    sphere(body2.x);
    translate(0, 0, size1.z);
    sphere(body2.x);
    popMatrix();

    popMatrix();
  }
/*AGCubus-like functions******************************************************************************************/
  void initLikeAGCubus(){
    size1.x = random(6, 30);
    speed = new PVector(random(-0.002, 0.002), random(-0.002, 0.002), random(-0.002, 0.002));
    rotation = new PVector(random(-0.005, 0.005), random(-0.005, 0.005), random(-0.005, 0.005));
    
    size2.x = int(random(5,9));
    size1.y = random(4, 10);
    frequency.x = random(0.01, 0.1);
    size2.y = random(5);
    size1.z = random(0.3, 0.6);
  }
  void moveLikeAGCubus(){
    pos.x += sin(frameCount*speed.x);
    pos.y += sin(frameCount*speed.y);
    pos.z += cos(frameCount*speed.y);

    rot.x = sin(frameCount*rotation.x) * TWO_PI;
    rot.y = sin(frameCount*rotation.y) * TWO_PI;
    rot.z = sin(frameCount*rotation.z) * TWO_PI; 
  }
  void drawLikeAGCubus(){
    applyTransforms(); //shortcut   
    noFill();
    stroke(255);

    // the body
    strokeWeight(1);
    box(size1.x); 
    
    //the four tentacles
    strokeWeight(2);
    for (int j=0; j<4; j++) {
      PVector p = new PVector(size1.y, 0); 
      PVector pos = new PVector(size1.x/2, 0); 
      float ang = sin(frameCount*frequency.x + j%2 * size2.y) * size1.z;
      float l = size1.y;
      beginShape();
      for (int i=0; i<size2.x+1; i++) {
        vertex(pos.x, pos.y);
        pos.x += p.x;
        pos.y += p.y;
        p = rotateVecCubus(p, ang);
        p.limit(l);
        l *= 0.93; //scale a bit, this factor could also be randomized.
      }
      endShape();
      rotateY(HALF_PI);
    }
  }
  PVector rotateVecCubus(PVector v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return new PVector(v.x*c - v.y*s, v.x*s + v.y*c);
  }    
/*AGFloater-like functions******************************************************************************************/
  void initLikeAGFloater(){
    mat = new PMatrix3D();
    mat.rotateY(random(TWO_PI));
    mat.rotateZ(random(-0.2, 0.2));

    frequency.x = random(0.1, 0.2);
    frequency.y = frequency.x;
    size2.z = 1.2 + random(-0.1,0.2);
    float s = 0.9;
    size2.x = random(10, 30)*s;
    size2.y = random(0.6, 1.2)*s;
    size1.x = random(20, 40)*s;
    size1.y = random(30, 90)*s;
    size1.z = random(20, 50)*s;
    speed.x = random(2.5,3.5)*s;
    speed.y = random(4.5,5.5)*s;
    
    noise.x = 0.012;
    noise.y = random(1); 
  }
  void moveLikeAGFloater(){
    mat.rotateY(map(noise(frameCount * noise.x + noise.y), 0, 1, -0.1, 0.1));
    float theSpeed = map(sin(frameCount * frequency.x), -1, 1, speed.x, speed.y);   
    mat.translate(0 , 0, theSpeed);
    mat.mult(new PVector(), pos); //update the position vector
  }
  void drawLikeAGFloater(){
    applyMatrix(mat);
    //stroke(255);
    noStroke();
    fill(255);
    rotateX(-HALF_PI);
    scale(min(getEnergy() * 0.1, 1));

    float h1 = sin(frameCount * frequency.x) * size2.x;
    float h2 = sin(frameCount * frequency.y + size2.z) * size2.y;

    translate(0, 0, h1);
    rectMode(CENTER);
    rect(0, 0, size1.x, size1.y);

    rectMode(CORNER);
    pushMatrix();
    translate(-size1.x/2, -size1.y/2, 0);
    rotateY(PI - h2);
    rect(0, 0, size1.z, size1.y);
    popMatrix();

    pushMatrix();
    translate(size1.x/2, -size1.y/2, 0);
    rotateY(h2);
    rect(0, 0, size1.z, size1.y);
    popMatrix();
  }
/*AGRadio-like functions******************************************************************************************/
  void initLikeAGRadio(){
    speed = new PVector( random(-1, 1), random(-1, 1), random(-1, 1) );
    rotation = new PVector( random(-0.01, 0.01), random(-0.01, 0.01), random(-0.01, 0.01) );
    size2.y = round(random(20, 100));
    size1.x = ceil(random(3, 12));
    size1.y = random(0.02, 0.06);
    size1.z = random(30, 60);
    size2.x = random(0.2, 0.4);
  }
  void moveLikeAGRadio(){
    pos.add(speed);  
    rot.add(rotation);  
    applyTransforms();   
  }
  void drawLikeAGRadio(){
    stroke(255);
    noFill();
    noStroke();
    hint(DISABLE_DEPTH_TEST); 
    float arc = TWO_PI / size2.y;    
    float f = frameCount * size1.y;
    float a = arc * size1.x;
    beginShape(QUAD_STRIP);
    for (int i=0; i<size2.y+1; i++) { 
      int j = i % parseInt(size2.y);
      float len = (sin(f + a * j)) * 0.2;
      float c = cos(arc * j); 
      float s = sin(arc * j);
      float x = c * (size1.z + len * size1.z);
      float y = s * (size1.z + len * size1.z);
      float z = len * size1.z;
      fill(255, i % 2 * 255  ); 
      vertex(x*size2.x, y*size2.x, z);
      fill(255, 0); 
      vertex(x, y, 0);
    }
    endShape();
    hint(ENABLE_DEPTH_TEST);
  }
/*AGSnakeFish-like functions******************************************************************************************/
  void initLikeAGSnakeFish(){
    size1 = new PVector(random(20, 60), random(10, 20));
    mat = new PMatrix3D();
    size2.x = int(random(50, 200));
    speed.x = random(0.005, 0.01);
    frequency.x    = random(0.005, 0.01);
    frequency.y    = random(0.05, 0.15);
    rotation.x     = random(0.05, 0.15);
    rotation.y     = random(0.05, 0.15);

    resize.z   = random(TWO_PI);
    resize.x   = random(TWO_PI);
    resize.y   = random(TWO_PI);    
    
    points    = new ArrayList<PVector>();
    speed.y = random(8,15);
  }
  void moveLikeAGSnakeFish(){
    float theSpeed = map(sin(frameCount * speed.x + resize.z), -1, 1, 2, speed.y);   
    mat.translate(0, 0, theSpeed);
    mat.rotateX(map(sin(frameCount * frequency.x + resize.x), -1, 1, -rotation.x, rotation.x));   
    mat.rotateY(map(sin(frameCount * frequency.y + resize.y), -1, 1, -rotation.y, rotation.y));
    mat.mult(new PVector(), pos); //we are nice and manually update the pos vector...
  }
  void drawLikeAGSnakeFish(){
    size1.mult(constrain(getEnergy() * 0.95,0,1));

    PVector p1 = new PVector(); 
    PVector p2 = new PVector();
    mat.mult(new PVector(-size1.x/2, 0, 0), p1);
    mat.mult(new PVector( size1.x/2, 0, 0), p2);
    points.add(p1);
    points.add(p2);

    noFill();
    if (points.size() > size2.x) {
      points.remove(0);
      points.remove(0);
    }
    
    stroke(255);
    
    beginShape();  
    for (int i=0; i<points.size(); i+=2) {
      PVector v1 = points.get(i);
      //stroke(255, min(i, 255));
      vertex(v1.x, v1.y, v1.z);
    }
    endShape();

    beginShape();  
    for (int i=1; i<points.size(); i+=2) {
      PVector v = points.get(i);
      //stroke(255, min(i, 255));
      vertex(v.x, v.y, v.z);
    }
    endShape();


    applyMatrix(mat);
    rotateX(HALF_PI);  
    stroke(255);
    rect(-size1.x/2, 0, size1.x, size1.y);
  }
/*AGWorm-like functions******************************************************************************************/
  void initLikeAGWorm(){
    int num = int(random(7,22));
    float len = random(2, 15);
    float damp = random(0.85, 0.95);
    float k = random(0.15,0.3);
    size1.x = random(1.5, 2.5);   
    speed.x = random(50,150);
    speed.y = random(0.005, 0.02);
    noise.x = random(0.01, 0.3);
    size1.y = random(0.05, 0.2);
    size1.z = random(0.08, 1.1);

    nodes = new ArrayList<Node>();

    springs = new ArrayList<Spring>();
    for (int i=0; i<num; i++) {
      PVector p = PVector.add(pos, new PVector(random(-1,1),random(-1,1),random(-1,1)));
      Node n = new Node(p, damp);
      nodes.add(n);
    }
    
    for (int i=0; i<num-1; i++) {
      Spring s = new Spring(nodes.get(i), nodes.get(i+1), len, k);
      springs.add(s);
    }
    
    resize = new PVector();
  }
  void moveLikeAGWorm(){
    if (random(1) < noise.x) {
      resize.add(new PVector(random(-speed.x,speed.x),random(-speed.x,speed.x),random(-speed.x,speed.x)));
    }
    pos.x += (resize.x - pos.x) * speed.y;
    pos.y += (resize.y - pos.y) * speed.y;
    pos.z += (resize.z - pos.z) * speed.y;
    nodes.get(0).setPos(pos);
    for (Spring s : springs) s.step();
    for (Node n : nodes) n.step();
  }
  void drawLikeAGWorm(){
    noFill();
    stroke(255);
    for (Spring s : springs) {
      line(s.a.x, s.a.y, s.a.z, s.b.x, s.b.y, s.b.z);
    }

    int i=0;
    noStroke();
    sphereDetail(3);
    fill(255);  
    float baseFreq = frameCount * size1.y;
    for (Node n : nodes) {
      float d = map( sin(baseFreq - i*size1.z), -1, 1, size1.x, size1.x * 2);
      pushMatrix();
      translate(n.x, n.y, n.z);
      //if ((i + frameCount/5) % 4 == 0) d *= 0.5;
      sphere(d);      
      popMatrix();
      i++;
    }
  }
  class Node extends PVector {

    float damp;
    PVector vel;

    Node(PVector v, float damp) {
      super(v.x, v.y, v.z);
      this.damp = damp;
      vel = new PVector();
    }

    void step() {
      add(vel);
      vel.mult(damp);
    }

    void applyForce(PVector f) {
      vel.add(f);
    }

    void setPos(PVector p) {
      this.x = p.x;
      this.y = p.y;
      this.z = p.z;
      vel = new PVector();
    }
  }
  
  class Spring {
    float len;
    float scaler;
    Node a, b;

    Spring(Node a, Node b, float len, float scaler) {
      this.a = a;
      this.b = b;
      this.len = len;
      this.scaler = scaler;
    }

    void step() {

      PVector v = PVector.sub(b, a);
      float m = (v.mag() - len) / 2 * scaler;
      v.normalize();

      v.mult(m);    
      a.applyForce(v);

      v.mult(-1);    
      b.applyForce(v);
    }
  }
/*EPSeaFly-like functions******************************************************************************************/
  void initLikeEPSeaFly(){
    speed = new PVector();
    speed.x = random(-0.002, 0.002); 
    speed.y = random(-0.002, 0.002); 
    speed.z = random(-0.002, 0.002);

    rotation = new PVector();
    rotation.x = random(-0.005, 0.005); 
    rotation.y = random(-0.005, 0.005); 
    rotation.z = random(-0.005, 0.005);
  }
  void moveLikeEPSeaFly(){
    vectorA.x++;
    pos.x += sin(vectorA.x*speed.x);
    pos.y += sin(vectorA.x*speed.y);
    pos.z += cos(vectorA.x*speed.y);

    rot.x = sin(vectorA.x*rotation.x) * TWO_PI;
    rot.y = sin(vectorA.x*rotation.y) * TWO_PI;
    rot.z = sin(vectorA.x*rotation.z) * TWO_PI;
    
    applyTransforms();
  }
  void drawLikeEPSeaFly(){
    stroke(255);
    noFill();  
    float dimR = 20;
    float dimF = 10;  

    scale(0.2);
    translate(vectorA.x * 0.018, vectorA.x * 0.008); 
    rotateX(vectorA.x * 0.008);

    PVector dim = new PVector(100, 60, 30);
    fill(255);
    sphereDetail(3); 
    sphere(25);

    float aF = sin(vectorA.x * 0.15) * 0.8;  
    float aR = sin(vectorA.x * 0.25) * 0.8;

    pushMatrix();                            
    translate(-dim.x/2, dim.y/2, dim.z/2);
    rotateZ(aF/2 + 1.2);
    rotateY(aF - 1);
    fill(255,150);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    noFill();
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    popMatrix();

    pushMatrix();                          
    translate(-dim.x/2, dim.y/2, -dim.z/2);
    rotateZ(aF/2 + 1.2);
    rotateY(-aF + 1);
    fill(255,150);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    noFill();
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    popMatrix();

    pushMatrix();                          
    translate(dim.x/2, dim.y/2, dim.z/2);
    rotateY(aR);
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    fill(255,150);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    popMatrix();

    pushMatrix();                  
    translate(dim.x/2, dim.y/2, -dim.z/2);
    rotateY(-aR);
    quad(0, 0, 86, 20, 69, 63, 30, 76);
    noFill();
    quad(0, 0, 96, 23, 79, 73, 40, 86);
    popMatrix();
  }
/*FFBreather-like functions******************************************************************************************/
  void initLikeFFBreather(){
    vectorA.x = (int)random(3,11);
    if(vectorA.x%2 != 0)
    {
      vectorA.x++;
    }
    //println("creatureSize = " + vectorA.x);
    vectorA.z = 3*vectorA.x;
    //println("realCreatureSize = " + vectorA.z);
    vectorA.y = (int)random(10,100);
    noise.x = TWO_PI/vectorA.z;

    pos = new PVector(random(0,width),random(0,height));
    prevPosition = pos;

    resize.x = 0;
    resize.z = random(0.001,0.1);
    frequency.x = random(0.001,0.01);
    frequency.y = random(0.0001,0.001);
    offset.x = random(0.001,0.1);
    offset.y = random(10,100);
    position.x = random(0.00001,0.01);
    position.y = random(0.00001, 0.01);

    speed = PVector.random3D();
    rotation = PVector.random3D();
    rotation.mult(random(0.01, 0.03));
    float s = random(0.5, 1);
    sca.set(s,s,s);
    // math the shit out of it
    for(int i = 0;i < vectorA.z;i++)
    {
      points.add(new PVector(cos(position.z)*vectorA.y,sin(position.z)*vectorA.y) );
      position.z += noise.x;
    }
    //println(points);
  }
  void moveLikeFFBreather(){
    frequency.z = noise(frequency.x);
    frequency.x += frequency.y;

    resize.y = map(cos(resize.x),-1,1,frequency.z,1);
    resize.x = resize.x + resize.z;

    pos.add(speed);  
    rot.add(rotation);  
    applyTransforms();
  }
  void drawLikeFFBreather(){
    stroke(255,255,255,95);
    noFill();

    for(int i = 0; i < points.size()-1;i+=2)
    {
      size2 = points.get(i);
      size3 =  points.get(i+1);

      if( i+2 < points.size() )
      {
        body1 = points.get(i+2);
      } 
      else {
        body1 = points.get(0);
      }

      size1 = PVector.sub(body2,size3);
      body3 = PVector.add(PVector.mult(size1,resize.y),size3);

      beginShape(); 
      vertex(size2.x,size2.y,0);
      vertex(body3.x,body3.y,15+frequency.z*75);
      vertex(body1.x,body1.y,0);
      endShape(CLOSE);
    }
  }
/*LPHubert-like functions******************************************************************************************/
  void initLikeLPHubert(){
    //////////////Mouvement alétoire
    speed = new PVector();
    speed.x = random(-0.002, 0.002); 
    speed.y = random(-0.002, 0.002); 
    speed.z = random(-0.002, 0.002);

    rotation = new PVector();
    rotation.x = random(-0.005, 0.005); 
    rotation.y = random(-0.005, 0.005); 
    rotation.z = random(-0.005, 0.005);
    /////////////////

    ///////////////Créature random
    vectorA.y = 10;
    size1.x = random(6, 30);
    size1.y = random(5, 15);
    frequency.x = random(0.01, 0.02);
    size2.z = random(5);
    size1.z = random(0.3, 0.6);
    size2.y = int(random(3, 20));
    size2.x = int(random(3, 7));
    vectorB.z = 5;
    vectorB.y = int(random(1, 3));
    vectorB.x = (random(0.3, 1.52));
    sca.x = vectorB.x;
    sca.y = vectorB.x;
    sca.z = vectorB.x;
  }
  void moveLikeLPHubert(){
    vectorA.x++;
    ////////////////
    pos.x += sin(vectorA.x*speed.x);
    pos.y += sin(vectorA.x*speed.y);
    pos.z += sin(vectorA.x*speed.z);

    rot.x = sin(vectorA.x*rotation.x) * TWO_PI;
    rot.y = sin(vectorA.x*rotation.y) * TWO_PI;
    rot.z = sin(vectorA.x*rotation.z) * TWO_PI;

    //    SuperCreature x = getNearest("Hubert");
    //    if (x != null) {
    //      float dis = dist(x.pos.x, x.pos.y, x.pos.z, pos.x, pos.y, pos.z);
    //      if (dis < 320 && !isAngry) {
    //        isAngry = true;
    //
    //        for (int i=0; i<random(3, 6); i++) {
    //          missiles.add(new Missile(pos, x));
    //        }
    //      } 
    //      else {
    //        isAngry = false;
    //      }
    //    }
    applyTransforms();
    //    launchMissile();
  }
  void drawLikeLPHubert(){
    strokeWeight(1);
    noFill();
    stroke(255, 150);
    float val2 = sin(vectorA.x*frequency.x*3)*2;
    
    float a1 = sin(vectorA.x*frequency.x + size2.z) * size1.z;
    float a2 = sin(vectorA.x*frequency.x) * size1.z;

    for (int j=0; j<size2.y; j++) {

      PVector p = new PVector(size1.y, 0); 
      PVector pos = new PVector(size1.x/6, 0); 
      float ang = (j % 2 == 0) ? a1 : a2;
      float l = size1.y;

      for (int i=0; i<size2.x; i++) {
        if (i<size2.x-2) {
          pushMatrix();
          translate(pos.x + p.x, pos.y + p.y, 0);
          box(3+val2);
          popMatrix();
        }

        line(pos.x, pos.y, pos.x + p.x, pos.y + p.y);
        pos.x += p.x;
        pos.y += p.y;
        p = rotateVecHubert(p, ang+(val2 * 0.1));
        p.limit(l);
        l *= 0.99;
        //l *= 0.93;
      }
      rotateY(PI*2/size2.y);
    }
  }
  PVector rotateVecHubert(PVector v, float angle) {
    float c = cos(angle);
    float s = sin(angle);
    return new PVector(v.x*c - v.y*s, v.x*s + v.y*c);
  }

  void launchMissile () {
    for (int i=missiles.size()-1; i>=0; i--) {
      Missile d = (Missile)missiles.get(i);
      d.draw();
      if (d.dis <= 23) {
        if (d.target.sca.x <= 0) {
          d.target.kill();
        } 
        else {
          d.target.sca.sub(new PVector(.01, .01, .01));
        } 
        missiles.remove(i);
      }
    }
  }

  class Missile {
    //
    SuperCreature target;
    PVector pos, tar, vec;
    float a1, a2;
    float dis;
    float speed;
    //
    Missile(PVector _p, SuperCreature _target) {
      target = _target;
      pos = _p.get();
      tar = _target.pos;
      vec = PVector.sub(tar, pos);
      vec.normalize();

      speed = random(2, 7);

      vec.mult(speed);
    }
    //
    void draw() {

      vec = PVector.sub(tar, pos);
      vec.normalize();
      vec.mult(speed);

      dis = dist(tar.x, tar.y, tar.z, pos.x, pos.y, pos.z);

      pos.add(vec);

      pushStyle();
      pushMatrix();
      translate(pos.x, pos.y, pos.z);
      stroke(255, 0, 0);
      point(0, 0, 0);
      popMatrix();
      popStyle();
    }
  }
/*MCManta-like functions******************************************************************************************/
  void initLikeMCManta(){
    frequency.x = random(0.01, 0.03);
    speed.y = random(30, 90);
    //    colorF = new PVector();
    //    colorF.x = random(0.001, 0.004); 
    //    colorF.y = random(0.001, 0.004); 
    //    colorF.z = random(0.001, 0.004);

    rotation.x = random(TWO_PI);
    speed.x = random(1, 2);

    size2 = new PVector();
    size2.x = random(0.01, 0.15);
    size2.y = random(0.01, 0.15);
  }
  void moveLikeMCManta(){
    vectorA.x++;
    pos.x += cos(rotation.x) * speed.x;
    pos.y = cos(vectorA.x*frequency.x) * speed.y;
    pos.z += sin(rotation.x) * speed.x;
    rot.y = -rotation.x;
    applyTransforms();
  }
  void drawLikeMCManta(){
    size1.x = 25;
    size1.y = 300;
    size1.z = size1.y /size1.x ;

    noFill();
    stroke(255);
    rotateY(PI);

    //TETE
    sphereDetail(2);
    for (int i=0; i<2; i++) {
      pushMatrix();
      translate(40 +i*15, 0 +(sin(i+vectorA.x*0.1)));
      scale(2, i*0.8);
      sphere(15);
      popMatrix();
    }

    //AILE 1
    pushMatrix();
    rotateX(0.6*sin(vectorA.x * size2.x) + radians(90));
    beginShape(TRIANGLE_STRIP);
    for (int l1=0; l1<10; l1++) {
      vertex(pow(l1, 2), l1*10, sin(vectorA.x*size2.y)*5);
      vertex(75, 25, cos(vectorA.x*size2.x)*10);
    }
    vertex(120, 0);
    endShape(CLOSE);  
    popMatrix();

    //AILE 2
    pushMatrix();
    rotateX(-0.6*sin(vectorA.x * size2.x) - radians(90));
    beginShape(TRIANGLE_STRIP);
    vertex(0, 0);
    for (int l2=0; l2<10; l2++) {
      vertex(pow(l2, 2), l2*10, sin(vectorA.x*size2.y)*5);
      vertex(75, 25, -cos(vectorA.x*size2.x)*10);
    }
    vertex(120, 0);
    endShape(CLOSE);
    popMatrix();

    //QUEUE
    translate(80, 0);
    beginShape(TRIANGLE_STRIP); 
    for (int j=0; j<15;j++) {
      vertex(j*10, sin(j-(vectorA.x* size2.x))*(j), cos(j-(vectorA.x* size2.y))*(j));
    }
    endShape();
  }
/*MFCreatureZero-like functions******************************************************************************************/
  void initLikeMFCreatureZero(){
    size1.z = int(random(2, 5));
    size1.y = size1.z + int(random(1, 4));
    frequency.x = random(0.02, 0.06);
    
    resize = new PVector();

    int num = int(random(5, 30));
    float len = random(2, 10);
    size1.x = random(4, 20);   
    noise.x = random(0.01, 0.4);


    /**
     for (int i=0; i<num; i++) {
     Node n = new Node(pos.x + random(-10, 10), pos.y + random(-10, 10), 0.9);
     nodes.add(n);
     }
     
     for (int i=0; i<num-1; i++) {
     Spring s = new Spring(nodes.get(i), nodes.get(i+1), len, 0.1);
     springs.add(s);
     }
     **/
  }
  void moveLikeMFCreatureZero(){
    vectorA.x++;
    if (random(1) < noise.x) {
      PVector rnd = PVector.random3D();
      rnd.mult(30);
      resize.add(rnd);
    }

    pos.x += (resize.x - pos.x) * 0.02;
    pos.y += (resize.y - pos.y) * 0.02;
    pos.z += (resize.z - pos.z) * 0.02;
  }
  void drawLikeMFCreatureZero(){
    hint(DISABLE_DEPTH_TEST); 
    stroke(255, 95);
    strokeWeight(2);
    noFill();
    translate(pos.x, pos.y, pos.z);
    float rad =  sin(vectorA.x*frequency.x);
    rotateY(rad);
    rotateX(rad);
    rotateZ(rad);

    int r = (int)size1.x;
    int numberOfSteps = 150;
    float angleSize = size1.y * PI / numberOfSteps;
    beginShape();
    for (int i = 1; i < numberOfSteps; i++) {
      float pc0 = cos(size1.y * (i - 1) * angleSize);
      float pc1 = cos(size1.y * (i) * angleSize); 

      vertex(
      r*(3+pc0) * cos(size1.z * (i - 1) * angleSize), 
      r*(3+pc0) * sin(size1.z * (i - 1) * angleSize), 
      r*sin(size1.y * (i - 1) * angleSize)
      );
      vertex(
      r*  (3+pc1) * cos(size1.z * (i) * angleSize), 
      r*  (3+pc1) * sin(size1.z * (i) * angleSize), 
      r*  sin(size1.y * (i) * angleSize)
      );      
    }
    endShape(CLOSE);
    hint(ENABLE_DEPTH_TEST);
  }
/*OTFather-like functions******************************************************************************************/
  void initLikeOTFather(){
    size1.x = floor(random(10, 20));
    size1.y = 1;
    size1.z = floor(random(2, 6));
    size2.y = random(0.2, 0.5);
    size2.x = random(20, 40);

    vectorA.y = random(-0.005, 0.005);
    vectorA.z = random(-0.005, 0.005);    


    speed = PVector.random3D();
    rotation = PVector.random3D();
    rotation.mult(random(0.01, 0.03));
    noise =PVector.random3D();
    noise.mult(random(0.005, 0.03));
    float s = random(0.5, 1);
    sca.set(s,s,s);
  }
  void moveLikeOTFather(){
    vectorA.x++;
    pos.add(speed);  
    rot.add(rotation);  
    applyTransforms();
  }
  void drawLikeOTFather(){
    sphereDetail(8);

    //TESTA
    fill(255,100);
    stroke(255);
    sphere(size2.x);

    //ANTENNE
    stroke(255);

    //float ly = sin(frameCount * 0.01) * 30;
    //float lz = -sin(frameCount * 0.01) * 30;
    float ly = random(size2.x/2, sin(vectorA.x * 0.01) * size2.x);
    float lz = random(size2.x, size2.x + (size2.x/1.5));


    line(0, 0, 0, -size2.x*2, 10, 30);
    line(0, 0, 0, -size2.x*2, 10, -30);

    //PINNE  
    rotateY(-(size1.z-1) * size2.y / 2);
    //rotateY(-(size1.z-1) * size2.y / (size2.y - TWO_PI));
    for (int k=0; k<size1.z; k++) {

      float s = (cos(TWO_PI / (size1.z-1) * k));
      s = map(s, 1, -1, 0.9, 1);
      // println(k + "   " + s);
      pushMatrix();
      scale(s);


      for (int j=0; j<size1.y; j++) {
        pushMatrix();
        float a = (noise(vectorA.x*noise.x + j+k+1)-0.4)*0.782; 
        float b = (noise(vectorA.x*noise.y + j+k+1)-0.5)*0.582; 
        float c = (noise(vectorA.x*noise.z + j+k+1)-0.6)*0.682;

        for (int i=0; i<size1.x; i++) {
          rotateZ(a);
          rotateY(b);
          rotateX(c);
          translate(size2.x*0.9, 0, 0);
          scale(0.85, 0.85, 0.85);
          box(size2.x, size2.x/2, size2.x); 
          //ellipse(size2.x/2, size2.x, size2.x, size2.x);
        }


        popMatrix();


        //rotateY(TWO_PI/size1.y);
      }
      popMatrix();
      rotateY(size2.y);
    }
  }
/*PXPSonar-like functions******************************************************************************************/
  void initLikePXPSonar(){
    size1.y = 2;
    frequency.x = 300;
    frequency.y = 5;
    
    rotation = new PVector();
    rotation.x = random(-0.0005, 0.0005);
    rotation.y = random(-0.001, 0.001);
    rotation.z = random(-0.0015, 0.0015);

    speed = new PVector();
    speed.x = random(-0.002, 0.002); 
    speed.y = random(-0.002, 0.002); 
    speed.z = random(-0.002, 0.002);

    /*freqMulSca = new PVector();
     freqMulSca.x = random(-0.005, 0.005);
     freqMulSca.y = random(-0.005, 0.005);
     freqMulSca.z = random(-0.005, 0.005);*/
  }
  void moveLikePXPSonar(){
    rot.x = sin(frameCount*rotation.x) * TWO_PI;
    rot.y = sin(frameCount*rotation.y) * TWO_PI;
    rot.z = sin(frameCount*rotation.z) * TWO_PI;

    pos.x += sin(frameCount*speed.x);
    pos.y += sin(frameCount*speed.y);
    pos.z += cos(frameCount*speed.z);

    applyTransforms();
  }
  void drawLikePXPSonar(){
    size1.x++;
    vectorA.x++;
    float changeWH;
    float changeAL;
    float changeSca = map(sin(vectorA.x*0.15), -1,1, 1, 1.5);
    
    noFill();
    for (int i = 0; i < size1.y; i++) { 
      changeAL = (frequency.x-size1.x*frequency.y)*(sin((PI/size1.y)*i));
      stroke(255, 255, 255, changeAL*2);
      changeWH = exp(sqrt(size1.x*0.75))+i;
      ellipse (0, 0, changeWH, changeWH);
    }
    if (size1.x > frequency.x) {
      size1.x = 0;
    }

    rotateX(vectorA.x*0.011);
    rotateX(vectorA.x*0.012);
    rotateZ(vectorA.x*0.013);

    stroke (255, 80);    
    sphereDetail(6);
    sphere(30);    
    scale(changeSca, changeSca, changeSca);
    stroke (255);
    sphereDetail(1);
    sphere(10);
  }
}  

    

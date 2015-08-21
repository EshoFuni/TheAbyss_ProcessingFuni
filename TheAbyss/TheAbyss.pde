/**
 * The Abyss
 * 2010-15
 * 
 * sligthly altered by Tiago Ângelo, aka p1nh0, and Horácio, aka HTM
 * for the "EshoFuni" project of Horácio Tomé-Marques and friends (João, Tiago, etc)
 * many thanks to Andreas Gysin and all the other creature creators
 * 2014, 2015
 */
  
import oscP5.*; // importar biblioteca oscP5 para comunicação com o MaxMSP
import netP5.*; 
OscP5 oscP5;
NetAddress myRemoteLocation; 
float force[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
float pcamX = 0, camX = 0, camZ = 0;
boolean showElectrodeLabel = true;
//TAMultiCreature variables
int initLike = 1, moveLike = 1, drawLike = 1;
// Independet AGSnakeFish Creature
AGSnakeFish ag; 
PVector agVector = new PVector(0, 0, 0);
OscMessage theOscMessage;
int addCreat = -1;
String killCreat = " ";

CreatureManager creatureManager;
//boolean useBackdrop = true;
boolean useBackdrop = false;

void setup() {
  noCursor();
  //size(displayWidth, displayHeight, P3D);
  size(1024, 800, P3D);  
  smooth(128);
  frameRate(60);
    // a new variable to allow random input - testing Horácio
    halfWidth = width / 2;
    halfHeight = height / 2;
    borderWidth = width / 3 * 2;
    borderHeight = height / 3 * 2;
  creatureManager = new CreatureManager(this);
  creatureManager.previewCreature = null; // "ignore" previewCreature
  
  //Tiago's init
  oscP5 = new OscP5(this, 8000); // instanciar oscP5 c/ porta de com.
  myRemoteLocation = new NetAddress("127.0.0.1",8000);
  ag = new AGSnakeFish();
  
  //println("each frame lasts "+ frameTime+" milliseconds");

  // creatureManager.toggleManagerInfo(); // turn info off
  
  //initShaders();
  hint(DISABLE_DEPTH_TEST);
} 

void draw() { 
  noCursor();

  //if (keyPressed && key == ' ' && frameCount % 4 == 0) {
    //creatureManager.addCurrentCreature();
    
    if(addCreat > 0 && frameCount % 4 == 0) {
        creatureManager.setCurrentCreature(addCreat);
        creatureManager.addCurrentCreature();
        creatureManager.previewCreature = null; //hide preview creature
        addCreat = -1;
      }
    
    /*if(killCreat != " " && frameCount % 4 == 0){
     creatureManager.killCreatureByName(killCreat);
     killCreat = " ";
    }*/
  //}

  background(0);
  if (useBackdrop) drawBackdrop();
  creatureManager.loop();
  
  
   //AGSnakeFish
   
   pushMatrix();
   translate(width/2, height/2, 10);
   agVector = ag.getPosition();
   agVector.x = agVector.x % (width);
   agVector.y = agVector.y % (height  );
   agVector.z = agVector.z % 4000;
   ag.setPos(agVector); 
   
   ag.move();
   ag.draw();
   
   
   //ag.setPosition(); 
   //ag.pos.x = ag.pos.x % 20;
   //ag.pos.y = ag.pos.y % 20;
   popMatrix();
   
}

// ORIGINAL CAMERA FUNCTION
/*void mouseDragged() {
  CreatureCamera cam = creatureManager.getCamera();
  float ang = cam.getAngle() + (pmouseX - mouseX) * 0.006;
  float rad = map(mouseY, 0, height, 300, 7000);
  cam.setAngle(ang);
  cam.setRadius(rad);
}*/


void mousePressed() {
  creatureManager.getCamera().setCameraMode(CreatureCamera.DEFAULT_CAM);
 
}

void keyReleased() {
  if (key == ' ')            creatureManager.addCurrentCreature(); //added again only to test
  else if (keyCode == RIGHT) creatureManager.selectNextCreature(); //if, if first (don't forget)
  else if (keyCode == LEFT)  creatureManager.selectPrevCreature();
  else if (keyCode == UP)    creatureManager.nextCameraCreature();
  else if (keyCode == DOWN)  creatureManager.prevCameraCreature();  
  else if (key == 'b')       useBackdrop = !useBackdrop;
  else if (key == 'o')       creatureManager.toggleAbyssOrigin();
  else if (key == 'h')       creatureManager.toggleManagerInfo();
  else if (key == 'i')       creatureManager.toggleCreatureInfo();
  else if (key == 'a')       creatureManager.toggleCreatureAxis();
  else if (key == 'r')       creatureManager.addRandomCreature();
  else if (key == 'x')       creatureManager.killAll();
  else if (key == 's')       capture();  
  else if (key == 'c')       {
    CreatureCamera cam = creatureManager.getCamera();  
    cam.setCameraMode(CreatureCamera.AUTOROTATE_CAM);
    cam.setRadius(3000);
  }
  else if (key == 'l') { 
    if(showElectrodeLabel == true){ showElectrodeLabel = false; }
    else{ showElectrodeLabel = true;} 
  }
}

void drawBackdrop() {
  // TODO: solve with a shader...
  pushMatrix();
  noStroke();
  translate(width/2, height/2);
  rotateZ(sin(frameCount*0.001)*TWO_PI);

  float h = dist(0, 0, width, height);
  float b1 = map(sin(frameCount*0.013), -1, 1, 0.2, 1);
  float b2 = map(sin(frameCount*0.017), -1, 1, 0.2, 1);    
  float b3 = map(sin(frameCount*0.019), -1, 1, 0.2, 1);
  float r = 0;
  float g = 30;
  float b = 70;

  beginShape(QUAD_STRIP);
  fill(r, b1*g, b1*b); 
  vertex(-h, -h);
  fill(r, b1*g, b1*b); 
  vertex( h, -h);
  fill(r, b2*g, b2*b); 
  vertex(-h, 0);
  fill(r, b2*g, b2*b); 
  vertex( h, 0);
  fill(r, b3*g, b3*b); 
  vertex(-h, h);
  fill(r, b3*g, b3*b); 
  vertex( h, h);
  endShape();
  popMatrix();
}

void capture() {
  save("snaps/" + System.currentTimeMillis() + ".png");
}

void oscEvent(OscMessage oscInput) {
  theOscMessage = oscInput;
  thread("oscFunctions");  
} 

void oscFunctions(){
 // DRIVE ELECTRODES
    if (theOscMessage.checkAddrPattern("/electrodes")) {
      for (int i = 0; i < force.length; i++) {
        //print(theOscMessage.get(i).floatValue()+" ");
        force[i] = theOscMessage.get(i).floatValue();
      }
      //println();
    }
    
    // SET CAMERA PARAMETERS
    if (theOscMessage.checkAddrPattern("/camZ")){
      camZ = theOscMessage.get(0).floatValue();
      //println("camControl = "+camControl);
    }
    if (theOscMessage.checkAddrPattern("/camX")){
      pcamX = camX;
      camX = theOscMessage.get(0).floatValue();
      //println("camControl = "+camControl);
    }
    if (theOscMessage.checkAddrPattern("/camX") || theOscMessage.checkAddrPattern("/camZ")){
      CreatureCamera cam = creatureManager.getCamera();
      float ang = cam.getAngle() + (pcamX - camX) * 0.006;
      float rad = map(camZ, 0, height, 300, 7000);
      cam.setAngle(ang);
      cam.setRadius(rad);
    }
    
    // ADD CREATURE
    /*if (theOscMessage.checkAddrPattern("/add")){
      creatureManager.currentCreature = theOscMessage.get(0).intValue();
      creatureManager.addCurrentCreature();
      creatureManager.previewCreature = null; //hide preview creature
    }*/
    if (theOscMessage.checkAddrPattern("/add")){
      addCreat = theOscMessage.get(0).intValue();
      
      
      //creatureManager.setCurrentCreature(theOscMessage.get(0).intValue());
      //creatureManager.addCurrentCreature();
      //creatureManager.previewCreature = null; //hide preview creature
    }
    
    // KILL CREATURE BY NAME
    if (theOscMessage.checkAddrPattern("/kill")){
      creatureManager.killCreatureByName(theOscMessage.get(0).stringValue());
      //println(theOscMessage.get(0).intValue());
      //killCreat = theOscMessage.get(0).stringValue();
    }
    // SET TAMultiCreature PARAMETERS
    if (theOscMessage.checkAddrPattern("/init")){
      initLike = theOscMessage.get(0).intValue();
    }
    if (theOscMessage.checkAddrPattern("/move")){
      moveLike = theOscMessage.get(0).intValue();
    }
    if (theOscMessage.checkAddrPattern("/draw")){
      drawLike = theOscMessage.get(0).intValue();
    }
  
    // OTFather TENTACOLI COMPLEXITY
    if (theOscMessage.checkAddrPattern("/father+")) { // add tentacoli to all OTFather creatures
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "Father"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          if(((OTFather) s).numPinne < 13){ ((OTFather) s).numPinne++;}
        } 
      }
    }
    if (theOscMessage.checkAddrPattern("/father-")) { // remove tentacoli from all OTFather creatures
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "Father"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          if( ((OTFather) s).numPinne > 1 ) { ((OTFather) s).numPinne--; }  
        } 
      }
    }
    
    if (theOscMessage.checkAddrPattern("/father_detail")) { // remove tentacoli from all OTFather creatures
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "Father"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          
          if(((OTFather) s).detail < 33) {((OTFather) s).detail+= theOscMessage.get(0).intValue();}
        } 
      }
    }
    
    // LPHubert TENTACOLI COMPLEXITY
    if (theOscMessage.checkAddrPattern("/hubert+")) { // add tentacoli to all OTFather creatures
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "Hubert"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          ((LPHubert) s).numberT++;
        } 
      }
    }
    if (theOscMessage.checkAddrPattern("/hubert-")) { // remove tentacoli from all OTFather creatures
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "Hubert"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          if( ((LPHubert) s).numberT > 3 && ((LPHubert) s).numberT < 25) { ((LPHubert) s).numberT--; }  
        } 
      }
    }
    
    if (theOscMessage.checkAddrPattern("/hubert")) { // remove tentacoli from all OTFather creatures
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "Hubert"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          
          if( ((LPHubert) s).bLen < 251){ ((LPHubert) s).bLen += theOscMessage.get(0).intValue(); }
        } 
      }
    }
    
    // PXPSonar TEMPO CONTROL
    if (theOscMessage.checkAddrPattern("/sonar")) { 
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "Sonar"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          ((PXPSonar) s).time = 0; // trigger Sonar
        } 
      }
    }
    
    // Worm COMPLEXITY
    if (theOscMessage.checkAddrPattern("/worm+")) { // add tentacoli to all OTFather creatures
      for(int i = 0; i < creatureManager.getCreatures().size(); i++ ){
        if(creatureManager.getCreatures().get(i).creatureName == "El Worm"){
          SuperCreature s = creatureManager.getCreatures().get(i);
          ((AGWorm) s).setComplexity();
        } 
      }
    } 
}

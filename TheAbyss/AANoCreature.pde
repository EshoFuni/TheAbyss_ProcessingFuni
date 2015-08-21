/**
 * A simple box-like fish.
 * Just swims around following it's heartbeat.
 */
class AANoCreature extends SuperCreature {
  
  public AANoCreature() {
    creatureAuthor  = "Tiago Ângelo ";
    creatureName    = "NoCreature";
    creatureVersion = "v1";
    setDate(2014, 11, 14); //Y,M,D
    
    energy = 0.01;
  }

  void move() {
  }
  
  void draw() {
  }
}


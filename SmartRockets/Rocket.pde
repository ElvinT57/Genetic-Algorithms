class Rocket {
  PVector loc;
  PVector vel;
  PVector acc;
  float fitness = 0;
  DNA dna;
  int geneCounter = 0;
  float theta = 0; //the angle the rocket is facing

  Rocket(){
    loc = new PVector(origin.x, origin.y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    dna = new DNA();
  }
  
  Rocket(DNA childDNA){
    loc = new PVector(origin.x, origin.y);
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    dna = childDNA;
  }
  
  float getFitness(){
    return fitness;
  }
  
  DNA getDNA(){
    return dna;  
  }
  
  void applyForce(PVector f) {
    acc.add(f);
  }

  void update() {
    vel.add(acc);
    loc.add(vel);
    acc.mult(0);  //reset acceleration
    theta = atan2(vel.y, vel.x);
  }

  /**
   * Fitness function that will define our success
   * considering our goal
   */
  void fitness() {
    float d = dist(loc.x, loc.y, target.x, target.y);
    fitness = pow(1/d, 2);
  }

  /**
   * Iterates through our array of genes(PVectors) and
   * applies them as a force.
   */
  void run() {
    applyForce(dna.genes[geneCounter]);
    geneCounter++;
    update();
    display();
  }
  
  void display() {

    //save coordinate matrix
    pushMatrix();
    rectMode(CENTER);
    translate(loc.x, loc.y);
    rotate(theta);
    strokeWeight(1);
    stroke(0);
    fill(175);
    triangle(0, 5, 12, 0, 0, -5);
    //restore
    popMatrix();
  }
}

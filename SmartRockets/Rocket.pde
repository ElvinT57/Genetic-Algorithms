class Rocket {
  PVector loc;
  PVector vel;
  PVector acc;
  PVector origin;  //where the rockets will start
  float fitness = 0;
  DNA dna;
  int geneCounter = 0;
  float theta = 0; //the angle the rocket is facing

  Rocket(PVector origin){
    loc = origin;
    this.origin = origin;
    vel = new PVector(0,0);
    acc = new PVector(0,0);
    dna = new DNA();
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
    float d = PVector.dist(loc, target);
    fitness = 1/d;  // the inverse propotional to distance
  }

  Rocket crossover(Rocket partner) {
    Rocket child = new Rocket(this.origin);

    //selecting from midpoint
    int midpoint = int(random(dna.len()));

    for (int i = 0; i < dna.len(); i++) {
      if ( i > midpoint ) child.dna.getGenes()[i] = dna.getGenes()[i];
      else child.dna.getGenes()[i] = partner.dna.getGenes()[i];
    }

    return child;
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
    fill(175);
    triangle(0, 5, 15, 0, 0, -5);
    //restore
    popMatrix();
  }
}

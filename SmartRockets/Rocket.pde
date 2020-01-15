class Rocket {
  PVector loc;
  PVector vel;
  PVector acc;
  float fitness = 0;
  DNA dna;
  int geneCounter = 0;
  float theta = 0; //the angle the rocket is facing
  boolean stopped = false;  // var for checking if we collided with an obstacle
  float r = 4;
  Rocket() {
    loc = new PVector(origin.x, origin.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    dna = new DNA();
  }

  Rocket(DNA childDNA) {
    loc = new PVector(origin.x, origin.y);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    dna = childDNA;
  }

  float getFitness() {
    return fitness;
  }

  DNA getDNA() {
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

    // if the rocket hits an obstacle
    // reduce its fitness as a penalty
    if (stopped) fitness *= 0.1;
  }

  /**
   * Iterates through our array of genes(PVectors) and
   * applies them as a force.
   */
  void run() {
    if (!stopped) {
      applyForce(dna.genes[geneCounter]);
      geneCounter++;
      update();
      collided();
    }
    display();
  }

  void display() {
    float theta = vel.heading2D() + PI/2;
    fill(200, 100);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(theta);
    fill(175);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();

    popMatrix();
  }

  void collided() {
    for (Obstacle obs : obstacles) {
      if (obs.contains(loc))
        stopped = true;
    }
  }
}

PVector target;
PVector origin;
int lifetime;
int lifeCounter;
Population population;
PVector[] bestRoute;
int POP_SIZE = 100;
float MUTATION_RATE = 0.01;
ArrayList<Obstacle> obstacles;


//other instance variables
float px, py;

void setup() {
  size(640, 480);
  lifetime = 400;
  lifeCounter = 0;

  //set target and start location
  target = new PVector(width/2, 30);
  origin = new PVector(width/2, (height - 20));

  population = new Population(MUTATION_RATE, POP_SIZE);
  obstacles = new ArrayList<Obstacle>();
}

void draw() {
  background(255);
  drawBestRoute();

  if (lifeCounter < lifetime) {
    population.live();
    lifeCounter++;
  } else {
    lifeCounter = 0;
    population.fitness();
    // record the best route after calculating the best fitness
    bestRoute = population.getBestRoute();
    // continue process
    population.selection();
    population.reproduction();
  }


  //display target
  fill(0, 200, 100);
  stroke(0);
  strokeWeight(1);
  ellipse(target.x, target.y, 20, 20);

  // display obstacles
  for (Obstacle o : obstacles)
    o.display();

  // Display some info
  fill(0);
  text("Generation #: " + population.getGenerations(), 10, 18);
  text("Cycles left: " + (lifetime-lifeCounter), 10, 36);
  text("Population: " + POP_SIZE, 10, 54);
  text("Mutation Rate: " + MUTATION_RATE, 10, 72);
}

void drawBestRoute() {
  if (bestRoute == null)
    return;
  //draw the route
  PVector curr = new PVector(origin.x, origin.y);
  PVector vel = new PVector(0, 0);
  noFill();
  stroke(255, 0, 0, 50);
  strokeWeight(3);
  beginShape();
  vertex(curr.x, curr.y);
  for (int i = 0; i < bestRoute.length; i++) {
    vel.add(bestRoute[i]);
    curr.add(vel);
    vertex(curr.x, curr.y);
  }
  endShape();
}

// adds an obstacle
void mouseReleased() {
  if (mouseButton == LEFT) 
    obstacles.add(new Obstacle(new PVector(px, py), (mouseX - px), (mouseY - py)));
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    target.x = mouseX;
    target.y = mouseY;
  } else {
    px = mouseX;
    py = mouseY;
  }
}
void mouseDragged() {
  if (mouseButton == LEFT) {
  fill(255, 0, 0);
  rectMode(CORNER);
  rect(px, py, (mouseX - px), (mouseY - py));
  }
}

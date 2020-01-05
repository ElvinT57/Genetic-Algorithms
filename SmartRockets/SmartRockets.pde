PVector target;
int lifetime;
int lifeCounter;
Population population;

void setup(){
  size(640, 480);
  lifetime = 300;
  lifeCounter = 0;
  float mutationRate = 0.01;
  
  population = new Population(mutationRate, 50, new PVector(width/2, (height - 20)));
  
  //set target
  target = new PVector(width/2, 30);
}

void draw(){
  background(255);
  
  if(lifeCounter < lifetime){
     population.live();
     lifeCounter++;
  } else {
     lifeCounter = 0;
     population.fitness();
     population.selection();
     population.reproduction();
  }
  
  //display target
  ellipse(target.x, target.y, 10, 10);
}

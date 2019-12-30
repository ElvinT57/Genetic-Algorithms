String target = "to be or not to be"; //what string we are trying to match

//stats
float bestFitness = 0;  //best fitness so far
int bestIndex = 0; //index of the element with best index
int numIterations = 0;


DNA[] population;
int populationSize = 100;

float mutationRate = 0.01;
ArrayList<DNA> matingPool = new ArrayList<DNA>();

void setup() {
  size(550,350);
  background(255);
  
  population = new DNA[populationSize];
  
  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA();
  }
}

void draw() {
  background(255);
  
  for (int i = 0; i < population.length; i++){
    population[i].fitness();
    if(population[i].fitness > bestFitness){
       bestFitness = population[i].fitness;
       bestIndex = i;
    }
  }
      
  //build mating pool
  for (int i = 0; i < population.length; i++) {
    int n = int(population[i].fitness * 100);
    for (int j = 0; j < n; j++) {
      matingPool.add(population[i]);
    }
  }

  //Next, reproduction
  DNA parentA;
  DNA parentB;

  for (int i = 0; i < population.length; i++) {
    do {
      //retrieve random indices for parent A and B
      int a = int(random(matingPool.size()));
      int b = int(random(matingPool.size()));

      //retrieve parents from mating pool
      parentA = matingPool.get(a);
      parentB = matingPool.get(b);
    } while (parentA != parentB);

    DNA child = parentA.crossover(parentB);

    child.mutate();
    
    population[i] = child;
  }
  
  numIterations++;
  showStats();
  matingPool.clear();  //make sure we clear the matingpool, no polygomy.
  
  if(bestFitness == 1){
     background(0,255,0);
     fill(255,255,0);
     text("MATCH FOUND!!", 10, 225);
  }
}

void showStats(){
  fill(0);
  textSize(24);
  
  text("Best Result So far: ", 10, 25);
  text(population[bestIndex].getPhrase(), 250, 25);
  
  text("Best fitness so far: ", 10, 75);
  text(bestFitness, 250, 75);
  
  text("Number of iterations: ", 10, 125);
  text(numIterations, 275, 125);
  
  text("Mutation rate: ", 10, 175);
  text(mutationRate, 250, 175);
  
  
}

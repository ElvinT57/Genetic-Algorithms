class Population {
  float mutationRate;
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;
  int bestFitnessIndex;

  Population(float mutationRate, int size){
    this.mutationRate = mutationRate;  
    population = new Rocket[size];
    generations = 0;
    matingPool = new ArrayList<Rocket>();
    
    // intialize each rocket
    for( int i = 0; i < population.length; i++){
       population[i] = new Rocket(); 
    }
  }
  
  void fitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness();
    }
  }
  
  int getGenerations(){
     return generations; 
  }
  
  // Find highest fintess for the population
  float getMaxFitness() {
    float record = 0;
    for (int i = 0; i < population.length; i++) {
       if(population[i].getFitness() > record) {
         record = population[i].getFitness();
         bestFitnessIndex = i;
       }
    }
    return record;
  }

  PVector[] getBestRoute(){
    return population[bestFitnessIndex].getDNA().getGenes();
  }
  
  void selection() {
    // clear our mating pool for the next generation
    matingPool.clear();
    
    // retireve the max fitness of our population
    float maxFitness = getMaxFitness();
    
    for (int i = 0; i < population.length; i++) {
      // normalize each member's fitness to calculate the number
      // of times it will be added to the mating pool
      float normalFitness = map(population[i].getFitness(), 0, maxFitness, 0, 1);
      int n = int(normalFitness * 100);
      for (int j = 0; j < n; j++) {
        matingPool.add(population[i]);
      }
    }
  }

  void reproduction() {
    Rocket parentA;
    Rocket parentB;

    for (int i = 0; i < population.length; i++) {
      do {
        //retrieve random indices for parent A and B
        int a = int(random(matingPool.size()));
        int b = int(random(matingPool.size()));

        //retrieve parents from mating pool
        parentA = matingPool.get(a);
        parentB = matingPool.get(b);
      } while (parentA != parentB);

      DNA child = parentA.dna.crossover(parentB.dna);

      child.mutate(mutationRate);

      population[i] = new Rocket(child);
    }
    generations++;
  }
  
  void live(){
     for(int i = 0; i < population.length; i++){
        population[i].run(); 
     }
  }
}

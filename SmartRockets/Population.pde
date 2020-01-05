class Population {
  float mutationRate;
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;

  Population(float mutationRate, int size, PVector origin){
    this.mutationRate = mutationRate;  
    population = new Rocket[size];
    generations = 0;
    matingPool = new ArrayList<Rocket>();
    
    // intialize each rocket
    for( int i = 0; i < population.length; i++){
       population[i] = new Rocket(origin); 
    }
  }
  
  void fitness() {
    for (int i = 0; i < population.length; i++) {
      population[i].fitness();
    }
  }

  void selection() {
    for (int i = 0; i < population.length; i++) {
      int n = int(population[i].fitness * 1000);
      println(n);
      println(population[i].fitness);
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

      Rocket child = parentA.crossover(parentB);

      child.dna.mutate(mutationRate);

      population[i] = child;
    }
    matingPool.clear();
  }
  
  void live(){
     for(int i = 0; i < population.length; i++){
        population[i].run(); 
     }
  }
}

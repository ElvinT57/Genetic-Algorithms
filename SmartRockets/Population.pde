class Population {
  float mutationRate;
  Rocket[] population;
  ArrayList<Rocket> matingPool;
  int generations;
  int bestFitnessIndex = 0;
  float bestFitness = 0;

  Population(float mutationRate, int size) {
    this.mutationRate = mutationRate;  
    population = new Rocket[size];
    generations = 0;
    matingPool = new ArrayList<Rocket>();

    // intialize each rocket
    for ( int i = 0; i < population.length; i++) {
      population[i] = new Rocket();
    }
  }

  void fitness() {
    for (int i = 0; i < population.length; i++) {
      // if the member collided, ignore and continue
      if (population[i].stopped)
        continue;

      population[i].fitness();
      if (population[i].getFitness() > bestFitness) {
        bestFitness = population[i].getFitness();
        bestFitnessIndex = i;
      }
    }
  }

  int getGenerations() {
    return generations;
  }

  PVector[] getBestRoute() {
    if (bestFitnessIndex == -1)
      return null;
    else
      return population[bestFitnessIndex].getDNA().getGenes();
  }

  void selection() {
    // clear our mating pool for the next generation
    matingPool.clear();

    // retireve the max fitness of our population
    float maxFitness = bestFitness;

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
    // if all members could not perform, restart population
    if (matingPool.isEmpty()) {
      restartPopulation();
      return;
    }

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

  void live() {
    for (int i = 0; i < population.length; i++) {
      population[i].run();
    }
  }

  void restartPopulation() {
    // intialize each rocket
    for ( int i = 0; i < population.length; i++) {
      population[i] = new Rocket();
    }
    // reset best fitness index
    bestFitness = -1;
  }
}

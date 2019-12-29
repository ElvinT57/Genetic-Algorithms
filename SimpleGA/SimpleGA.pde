DNA[] population = new DNA[100];
String target = "to be or not to be";
float mutationRate = 0.01;
ArrayList<DNA> matingPool = new ArrayList<DNA>();

void setup() {
  for (int i = 0; i < population.length; i++) {
    population[i] = new DNA();
  }
}

void draw() {
  for (int i = 0; i < population.length; i++){
    population[i].fitness();
    if(population[i].fitness >= .25)
      println(population[i].getPhrase());
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
  
}

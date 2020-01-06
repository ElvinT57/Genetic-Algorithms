class DNA {
  PVector[] genes;  //our genetypes
  float maxforce = 0.1;  // how strong we can thrust

  DNA() {
    genes = new PVector[lifetime];

    for (int i = 0; i < genes.length; i++) {
      genes[i] = PVector.random2D();  //get a random vector from an angle
      //limit our vector by scaling it
      genes[i].mult(random(0, maxforce));
    }
  }

  DNA(PVector[] newgenes) {
    // We could make a copy if necessary
    // genes = (PVector []) newgenes.clone();
    genes = newgenes;
  }


  int len() {
    return genes.length;
  }

  PVector[] getGenes() {
    return genes;
  }

  DNA crossover(DNA partner) {
    PVector[] child = new PVector[genes.length];
    // Pick a midpoint
    int crossover = int(random(genes.length));
    // Take "half" from one and "half" from the other
    for (int i = 0; i < genes.length; i++) {
      if (i > crossover) child[i] = genes[i];
      else               child[i] = partner.genes[i];
    }    
    DNA newgenes = new DNA(child);
    return newgenes;
  }

  void mutate(float mutationRate) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = PVector.random2D();
        genes[i].mult(random(0, maxforce));
      }
    }
  }
}

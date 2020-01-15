class Population {
  Drawing[] drawings;
  PImage targetImg;  // our desired image
  float bestFitness = 0;
  int bestIndex = 0; //assume to be the first one
  float mutationRate = 0;
  ArrayList<Integer> matingPool;


  Population(String imgName, int popSize, float mutationRate) {
    targetImg = loadImage(imgName);
    drawings = new Drawing[popSize];
    this.mutationRate = mutationRate;
    matingPool = new ArrayList<Integer>();

    for (int i = 0; i < popSize; i++)
      drawings[i] = new Drawing();
  }

  void fitness() {
    //load our image's pixels
    targetImg.loadPixels();

    //adjacency array for each fitness belonging
    // to each drawing
    float [] fitnessScores = new float[drawings.length];

    for (int i = 0; i < fitnessScores.length; i++)
      fitnessScores[i] = 0;

    //compare with the drawings
    for (int i = 0; i < targetImg.pixels.length; i++) {
      for (int j = 0; j < drawings.length; j++) {
        fitnessScores[j] += comparePixel(targetImg.pixels[i], drawings[j].getPixel(i));
      }
    }

    //normalize scores
    for (int i = 0; i < fitnessScores.length; i++) {
      fitnessScores[i] /= (width * height);
      drawings[i].fitness = fitnessScores[i];
    }

    // check the lowest differences
    for (int i = 0; i < fitnessScores.length; i++) {
      if (fitnessScores[i] < fitnessScores[bestIndex]) {
        bestFitness = fitnessScores[i];
        bestIndex = i;
      }
    }
  }

  void selection() {
    for (int i = 0; i < drawings.length; i++) {
      // calculate how many of this drawing should be in the mating pool
      int n = int(map(drawings[i].fitness, 300, 0, 0, 110));
      for (int j = 0; j < n; j++) {
        matingPool.add(i);
      }
    }
  }

  void reproduction() {
    //Next, reproduction
    DNA parentA;
    DNA parentB;

    for (int i = 0; i < drawings.length; i++) {
      do {
        //retrieve random indices for parent A and B
        int a = int(random(matingPool.size()));
        int b = int(random(matingPool.size()));

        //retrieve parents from mating pool
        parentA = drawings[matingPool.get(a).intValue()].getDNA();
        parentB = drawings[matingPool.get(b).intValue()].getDNA();
      } while (parentA != parentB);

      DNA child = parentA.crossover(parentB);

      child.mutate(mutationRate);

      drawings[i] = new Drawing(child);
    }
    matingPool.clear();
  }

  /*
    * compares the red, blue, green and alpha
   * of targetted pixel and the guessed pixel.
   * Returns the score of the pixel. The lower,
   * the score, the better the fitness.
   */
  float comparePixel(color pix1, color pix2) {
    return abs((red(pix1) - red(pix2)) +
      (green(pix1) - green(pix2)) +
      (blue(pix1) - blue(pix2)));
  }

  void display() {
    loadPixels();
    Drawing d = drawings[bestIndex];
    for (int i = 0; i < (width * height); i++)
      pixels[i] = d.getPixel(i);
    updatePixels();
  }
}

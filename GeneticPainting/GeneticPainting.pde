Population pop;

String FILE_NAME = "dali.jpg";
int NUM_DRAWINGS = 30;

void setup(){
   size(375, 415);
   
   pop = new Population(FILE_NAME, NUM_DRAWINGS, 0.25);
}

void draw(){
  pop.fitness();
  if(pop.bestFitness < 100){
    pop.display();
  }
  pop.selection();
  pop.reproduction();
  println(pop.bestFitness);
}

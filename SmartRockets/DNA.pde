class DNA {
   PVector[] genes;  //our genetypes
   float maxforce = 0.1;  // how strong we can thrust
   
   DNA(){
     genes = new PVector[lifetime];
     
      for(int i = 0; i < genes.length; i++){
         genes[i] = PVector.random2D();  //get a random vector from an angle
         //limit our vector by scaling it
         genes[i].mult(random(0, maxforce));
      }
   }
   
   int len(){
     return genes.length;
   }
   
   PVector[] getGenes(){
     return genes;  
   }
   
   void mutate(float mutationRate) {
    for (int i = 0; i < genes.length; i++) {
      if (random(1) < mutationRate) {
        genes[i] = PVector.random2D();;
      }
    }
  }
}

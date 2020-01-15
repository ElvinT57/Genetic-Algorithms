class DNA {
  color [] genes;

  DNA() {
    int len = (width * height);
    genes = new color[len];
    
    // initialize our genes
    for(int x = 0; x < len; x++)
        genes[x] = color(random(255), random(255), random(255));
  }
  
  color [] getGenes(){
     return genes;
  }
  
  DNA crossover(DNA partner){
     DNA child = new DNA();
     
     //selecting from midpoint
     int midpoint = int(random(genes.length));
     
     for(int i = 0; i < genes.length; i++){
       if( i > midpoint ) child.genes[i] = genes[i];
       else child.genes[i] = partner.genes[i];
     }
     
     return child;
   }
   
  void mutate(float mutationRate){
      for(int i = 0; i < genes.length; i++){
        if(random(1) < mutationRate){
          genes[i] = color(random(255), random(255), random(255));
        }
     }
  }
}

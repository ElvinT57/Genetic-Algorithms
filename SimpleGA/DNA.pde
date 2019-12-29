class DNA{
   char[] genes = new char[18];
   float fitness;
   
   DNA(){
      for(int i = 0; i < genes.length; i++){
         genes[i] = (char)random(32, 128);
      }
   }
   
   void fitness(){
      int score = 0;
      for(int i =0; i < genes.length; i++){
         if(genes[i] == target.charAt(i)){
             score++;
         }
      }
      fitness = float(score)/target.length();
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
   
   void mutate(){
     for(int i = 0; i < genes.length; i++){
        if(random(1) < mutationRate){
          genes[i] = (char)random(32, 128);
        }
     }
   }
   
   String getPhrase(){
      return new String(genes); 
   }
}

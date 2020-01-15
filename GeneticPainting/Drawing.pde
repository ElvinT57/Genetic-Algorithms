class Drawing {
  DNA dna;
  float fitness = 0;
  
  Drawing() {
    dna = new DNA();
  }
  
  Drawing(DNA offspring){
     dna = offspring; 
  }

  void display() {
    color [] pxs = dna.getGenes();
    
    loadPixels();
    for (int i = 0; i < (width * height); i++) {
      pixels[i] = pxs[i];
    }
    updatePixels();
  }
  
  color getPixel(int i){
     return dna.genes[i]; 
  }
  
  DNA getDNA(){
     return dna; 
  }
}

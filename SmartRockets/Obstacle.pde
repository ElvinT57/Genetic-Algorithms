class Obstacle {
   PVector loc;
   float w, h;
   
   Obstacle(PVector loc, float w, float h){
      this.loc = loc;
      this.w = w;
      this.h = h;
   }
   
   boolean contains(PVector v){
      if(v.x > loc.x && v.x < loc.x + w && v.y > loc.y && v.y < loc.y + h)
        return true;
      else
        return false;
   }
   
   void display(){
      fill(200);
      stroke(0);
      rectMode(CORNER);
      rect(loc.x, loc.y, w, h);
   }
}

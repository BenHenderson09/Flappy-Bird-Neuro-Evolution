class Pipe{
  PImage sprite;
  
  PVector pos;
  float len;
  float wid = 70;
  
  void spawn(){
    fill(0,255,0);
    stroke(0);
    image(sprite,pos.x, pos.y, wid, len);
  }
  
  void setSprite(String path){
    sprite = loadImage(path);
  }
}

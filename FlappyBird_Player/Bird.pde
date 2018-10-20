class Bird{
  PImage sprite;
  
  PVector pos;
  PVector size;
  float gravity = 0.5;
  float jumpPower = 0.3;
  float speed = 0;
  
  boolean dead = false;
  
  Bird(){
    sprite = loadImage("bird.png");
    pos = new PVector(width/7,height/2);
    size = new PVector(sprite.height/7, sprite.width/7);
  }
  
  void update(){
    render();
    if (!dead){
      applyGravity();
    }
  }
  
  void render(){
    image(sprite,pos.x,pos.y, size.x, size.y);
  }
  
  void applyGravity(){
    speed += gravity;
    pos.y += speed;
    if (pos.y > height - sprite.height/7-10) {
      dead = true;
    }
  }
  
  void jump(){
    speed = 0;
    speed -= jumpPower*30;
    pos.y -= speed;
  }
}

class Bird{
  PImage sprite;
  GameController gc;
  Network nn = new Network(new int[]{5,5,1});
  
  PVector pos;
  PVector size;
  float gravity = 0.5;
  float jumpPower = 0.3;
  float speed;
  
  boolean dead = false;
  boolean best = false;
  float fitness;
  
  Bird(){
     sprite = loadImage("bird.png");
     pos = new PVector(width/7,height/2);
     size = new PVector(sprite.height/7, sprite.width/7);
  }
  
  void setController(GameController gc){
     this.gc = gc;
  }
  
  void update(){
    if (!dead){
      
      render();
      applyGravity();
      calculateFitness();
      
      if (speed > 0){
        action();
      }
    }
  }
   
  void render(){
    image(sprite,pos.x,pos.y, size.x, size.y);
    textSize(18);
    text(fitness, pos.x, pos.y+10); 
  }
  
  void action(){
    // (BirdY, NearestPipeX, TopPipeY, BottomPipeY, pipeWidth)
    if (predict() > 0){
        jump();
    }
  }
  
  double predict(){
    // (BirdY, NearestPipeX, TopPipeY, BottomPipeY, pipeWidth)
    return nn.feedForward(new double[]{pos.y,
    gc.pipes.topPipes[gc.pipes.currentPipe].pos.x,
    gc.pipes.topPipes[gc.pipes.currentPipe].pos.y+gc.pipes.topPipes[gc.pipes.currentPipe].len,
    gc.pipes.bottomPipes[gc.pipes.currentPipe].pos.y,
    gc.pipes.topPipes[gc.pipes.currentPipe].pos.x})[0];
  }
  
  void applyGravity(){
    speed += gravity;
    pos.y += speed;
    
    if (pos.y > height - sprite.height/7-10) {
      dead = true;
    }
    
    if (pos.y < 0){
      dead = true;
    }
  }
  
  void jump(){
    speed = 0;
    speed -= jumpPower*30;
    pos.y -= speed;
  }
  
  Bird generateChild(){
    Bird child = new Bird();
    child.nn = nn.clone();
    return child;
  }
  
  void calculateFitness(){
    float gapCentre = (gc.pipes.bottomPipes[gc.pipes.currentPipe].pos.y - gc.pipes.topPipes[gc.pipes.currentPipe].pos.y+gc.pipes.topPipes[gc.pipes.currentPipe].len)/2;
    float gapDist = dist(pos.x,pos.y,gc.pipes.bottomPipes[gc.pipes.currentPipe].pos.x, gapCentre);
    fitness += 1/(gapDist*gapDist);
  }
}

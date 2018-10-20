class PipeController{
  GameController gc;
  
  int numberOfPipes;
  Pipe[] bottomPipes;
  Pipe[] topPipes;
  
  float columnPos = width/2; // What x position to put the pipes in
  int currentPipe; // The pipe the bird is facing

  PipeController(int numberOfPipes){
    this.numberOfPipes = numberOfPipes;
  }

  void setController(GameController gc){
    this.gc = gc;
  }

  void generatePipes(){
    bottomPipes = new Pipe[numberOfPipes];
    topPipes = new Pipe[numberOfPipes];
    
    // Initialize top pipe positions
    for (int i = 0; i < topPipes.length; i++){
      topPipes[i] = new Pipe();
      topPipes[i].len = random(100,height-300);
      topPipes[i].pos = new PVector(columnPos, 0);
      topPipes[i].setSprite("topPipe.png");
      columnPos += 400;
    }
    columnPos = width/2; // Reset column position
    
    // Initialize bottom pipe positions
    for (int i = 0; i < bottomPipes.length; i++){
      bottomPipes[i] = new Pipe();
      bottomPipes[i].len = height-topPipes[i].len-200;
      bottomPipes[i].pos = new PVector(columnPos, height-bottomPipes[i].len);
      bottomPipes[i].setSprite("bottomPipe.png");
      columnPos += 400;
    }
  }
  
  void showPipes(){
    // Show all top pipes
    for (int i = 0; i < topPipes.length; i++){
      topPipes[i].spawn();
    }
    
    // Show all bottom pipes
    for (int i = 0; i < topPipes.length; i++){
      bottomPipes[i].spawn();
    }
  }
  
  void movePipes(){
    for (int i = 0; i < numberOfPipes; i++){
      topPipes[i].pos.x -= 3.5;
      bottomPipes[i].pos.x -= 3.5;
    }
  }
  
  void updatePipes(){
    if (collision(bird)){
      bird.dead = true;
      delay(500);
      gc.reset(); // Reset the game
    }
    else{
      movePipes();
    }
    
    if (bird.pos.x > bottomPipes[currentPipe].pos.x){
      gc.score++;
      currentPipe++;
    }
    
    showPipes();
  }
  
  boolean collision(Bird bird){
    // Top pipe collision
    for (int i = 0; i < topPipes.length; i++){
      if (bird.pos.x+bird.size.x > topPipes[i].pos.x && bird.pos.x < topPipes[i].pos.x+topPipes[i].wid){ // If inside x boundaries
          if (bird.pos.y > topPipes[i].pos.y && bird.pos.y+15 < topPipes[i].pos.y+topPipes[i].len){
          return true;
        }
      }
    }
    
    // Bottom pipe collision
    for (int i = 0; i < bottomPipes.length; i++){
      if (bird.pos.x+bird.size.x > bottomPipes[i].pos.x && bird.pos.x < bottomPipes[i].pos.x+bottomPipes[i].wid){ // If inside x boundaries
          if (bird.pos.y+bird.size.y-20 > bottomPipes[i].pos.y && bird.pos.y < bottomPipes[i].pos.y+bottomPipes[i].len){
          return true;
        }
      }
    }
    
    return false;
  }
}

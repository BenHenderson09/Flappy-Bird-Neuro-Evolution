class GameController{
  Bird bird;
  PipeController pipes;
  
  int score = 0;
  int bestScore = 0;
  
  GameController(Bird bird, PipeController pipes){
    this.bird = bird;
    this.pipes = pipes;
  }
  
  void reset(){
    
    if (score > bestScore){
      bestScore = score;
    }
    score = 0;
    
    // Reset the bird
    bird.pos = new PVector(width/7,height/2);
    bird.size = new PVector(bird.sprite.height/7, bird.sprite.width/7);
    bird.speed = 0;
    bird.dead = false;
    
    // Reset the pipes
    pipes.columnPos = width/2;
    pipes.currentPipe = 0;
    pipes.generatePipes();
  }
  
  void showScore(){
    textSize(32);
    fill(255,255,255);
    text("Score: " + score, 40, 60); 
    text("Best Score: " + bestScore, 40, 100); 
  }
}

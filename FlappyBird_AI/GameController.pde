class GameController{
  Population pop;
  PipeController pipes;
  
  int score;
  int bestScore;
  int birds;
  int generation = 1;
  
  GameController(Population pop, PipeController pipes){
    this.pop = pop;
    this.pipes = pipes;
    
    birds = pop.size;
  }
  
  void reset(){   
    if (score > bestScore){
      bestScore = score;
    }
    
    score = 0;
    generation++;
    
    // Perform genetic algorithm functions
    pop.evolve();
    
    // Reset the pipes
    pipes.columnPos = width/2;
    pipes.currentPipe = 0;
    pipes.generatePipes();
  }
  
  void showInfo(){
    textSize(29);
    fill(255,255,255);
    text("Score: " + score, 40, 60); 
    text("Best: " + bestScore, 40, 100); 
    text("Population: " + birds, 40, 140);
    text("Alive: " + aliveBirds(), 40, 180);
    text("Generation: " + generation, 40, 220); 
  }
  
  int aliveBirds(){
    int alive = 0;
    
    for(int i = 0; i < pop.birds.length; i++){
      if (!pop.birds[i].dead){
        alive++;
      }
    }
    
    return alive;
  }
}

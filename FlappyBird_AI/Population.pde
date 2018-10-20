class Population{
  int size;
  boolean extinct;
  GameController gc;
  
  Bird[] birds;
  Bird bestBird;
  int distanceSum = 0;
    
  
  Population(int size){
    this.size = size;
    birds = new Bird[size];
    bestBird = new Bird();
    generateBirds();
  }
  
  void update(){
    
    // Check for extinction
    if (allDead()){
      extinct = true;
    }
    
    if (!extinct){
      for (int i = 0; i < birds.length; i++){
        birds[i].update();
      }
    }else{
      extinct = false;
      gc.reset();
    }
  }
  
  void setController(GameController gc){
    this.gc = gc;
    for (int i = 0; i < birds.length; i++){
      birds[i].setController(gc);
    }
  }
  
  void generateBirds(){
    for (int i = 0; i < birds.length; i++){
      birds[i] = new Bird();
    }
  }
  
  boolean allDead(){
    for (int i = 0; i < birds.length; i++){
      if (!birds[i].dead){
        return false;
      }
    }
    return true;
  }
  
  // ----- Genetic functions -----
  void evolve(){
    killBadBirds();
    nextGeneration();
    mutate();
    setController(gc);
  }
  
  void nextGeneration(){
    Bird[] nextGen = new Bird[birds.length];
    setBestBird();
    nextGen[0] = bestBird.generateChild(); 
    
    for (int i = 1; i < birds.length; i++){
      nextGen[i] = selectParent();
    }
    
    birds = nextGen.clone();
    birds[0].best = true;
  }
  
    Bird selectParent(){
      float fitnessSum = 0;
      float fitnessLimit = 0;
      float fitnessGauge = 0;
      
      for (int i = 0; i < birds.length; i++){
        fitnessSum += birds[i].fitness;
      }
      
      fitnessLimit = random(fitnessSum);
      
      for (int i = 0; i < birds.length; i++){
        fitnessGauge += birds[i].fitness;
        
        if (fitnessGauge >= fitnessLimit){
            return birds[i].generateChild();
        }
      }
      return null; // Shouldn't get here
  }
  
  void setBestBird(){
    Bird fittestBird = new Bird();
    
    for (int i = 0; i < birds.length; i++){
      if (birds[i].fitness > fittestBird.fitness){
        fittestBird = birds[i];
      }  
    }
    
    if (fittestBird.fitness > bestBird.fitness){
      bestBird = fittestBird;
    }
  }
  
  void killBadBirds(){
    float fitnessSum = 0;
    float averageFitness = 0;
    
    for (int i = 0; i < birds.length; i++){
      fitnessSum += birds[i].fitness;
    }
    
    averageFitness = fitnessSum / birds.length;
    
    for (int i = 0; i < birds.length; i++){
      if (birds[i].fitness < averageFitness/1.5){
        birds[i] = new Bird();
      }
    }
  }
  
  void mutate(){
    float mutationRate = 0.1;
    
    for (int i = 1; i < birds.length; i++){
      birds[i].nn.mutate(mutationRate);
    }
  }
}

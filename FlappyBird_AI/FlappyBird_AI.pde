// Game params
PVector WINDOW_SIZE = new PVector(1500,800);
color BG = color(87, 199, 200);
int FPS  = 20;
int PIPES = 100;

// Game objects
GameController gameController;
PipeController pipeController;
Population population;

void settings(){
  size(int(WINDOW_SIZE.x), int(WINDOW_SIZE.y));
}

void setup(){
  frameRate = FPS;
  
  population = new Population(100);
  pipeController = new PipeController(PIPES);
  gameController = new GameController(population, pipeController);
  
  pipeController.setController(gameController);
  population.setController(gameController);
  pipeController.generatePipes();
}


void draw(){
  background(BG);
  
  if (gameController.pipes.currentPipe != PIPES){
    population.update();
    pipeController.updatePipes();
    gameController.showInfo();
  }else{
    gameController.reset();
  }
}

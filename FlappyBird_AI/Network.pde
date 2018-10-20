class Network{
  
  int[] structure;
  Layer[] layers;
  
  Network(int[] structure){
    this.structure = structure;
    this.layers = new Layer[structure.length-1];
    
    InitializeLayers();
  }
  
  void InitializeLayers(){
    for (int i = 0; i < layers.length; i++){
      layers[i] = new Layer(structure[i], structure[i+1]);
    }
  }
  
  double[] feedForward(double[] inputs){
    layers[0].feedForward(inputs);
    for (int i = 1; i < layers.length; i++){
      layers[i].feedForward(layers[i-1].outputs);
    }
   
    return layers[layers.length-1].outputs;
  }
  
  // ---- Genetic Functions ----
  
  void mutate(float mutationRate){
    for (int i = 0; i < layers.length; i++){
        layers[i].changeWeights(mutationRate);
     }
   }
  
  Network clone(){
    Network clone = new Network(structure);
    
    for (int i = 0; i < layers.length; i++){
      for (int j = 0; j < layers[i].weights.length; j++){
        for (int k = 0; k < layers[i].weights[j].length; k++){
          clone.layers[i].weights[j][k] = layers[i].weights[j][k];
        }
      }
    }
    
    return clone;
  }
}

class Layer{
  double[][] weights;
  double[] inputs;
  double[] outputs;
  
  int numberOfOutputs;
  int numberOfInputs;
  
  double tanh (double x){
     return Math.tanh(x);
  }
  
  Layer(int numberOfInputs, int numberOfOutputs){
    this.numberOfInputs = numberOfInputs;
    this.numberOfOutputs = numberOfOutputs;
    outputs = new double[numberOfOutputs];
    initializeWeights();
  }
  
  void initializeWeights(){
    weights = new double[numberOfOutputs][numberOfInputs];
    for (int i = 0; i < numberOfOutputs; i++){
      for (int j = 0; j < numberOfInputs; j++){
        weights[i][j] = random(-1,1);
      }
    }
  }
  
  void changeWeights(float rate){
    for (int i = 0; i < weights.length; i++){
      for (int j = 0; j < weights[i].length; j++){
        if (random(1) <= rate){
          weights[i][j] = random(-1,1);
        }
      }
    }
  }
  
  void feedForward(double[] inputs){
    this.inputs = inputs;
    for (int i = 0; i < outputs.length; i++){
      outputs[i] = 0;
      for (int j = 0; j < inputs.length; j++){
        outputs[i] += weights[i][j] * inputs[j];
      }
      outputs[i] = tanh(outputs[i]);
    }
  }
}

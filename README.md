# Neuro Evolution with FlappyBird
This program is a implementation of the popular FlappyBird mobile game, but played by an ai. It uses a NeuroEvolution algorithm,
a combination of neural networks and a genetic algorithm.

### Program Details
- Made from scratch with Processing, no machine learning libraries
- Variable population size, mutation rate and number of pipes
- Includes a version made for users to play, (FlappyBird_Player)

### Brief NeuroEvolution explanation
NeuroEvolution is made up of two main algorithms, Artificial Neural Networks (ANN) and Genetic Algorithms(GA). The neural networks are
inspired by the structure of the human brain, they can take in the inputs of the bird's position, the pipe width, etc and form 
an output. With this output between -1 and 1, a decision can be made about the bird's next action, so if the output is greater than zero
the bird will jump.

If you are familiar with the functionality of neural networks you may be wondering how we will backpropagate the network without a data
set. This is where genetic algorithms come in. They will produce a population of many birds with random weights in their neural networks
and then make the population play the game. When all of the birds die, the genetic algorithm will perform a variety of genetic functions
that are similar to how evolution in biology is theorized. It will firstly kill all of the "idiot" birds, these are the ones that perform
badly. It will then use a selection algorithm to find the fittest birds to form the next generation, using these selected "parents" to give the next generation "genetics". These genetics are the weights inside the parent's neural network.

This, however, does not work very well. The "children" are simply copying their parents exactly, there is no natural change in genetics.
This is where mutation comes in. Firstly a mutation rate, or probability, is defined. This mutation rate is the probability that a weight
in the child's neural network will be changed. Then the program loops through each weight in the netwok and changes a percentage of weights. This performs the mutation needed for the bird's to stumble upon new ways to improve their score, this is the main function
of a genetic algorithm.
# Genetic Algorithm

This task requires to propose a model for the TSP optimal solution of 100 cities based on GA. The core idea of GA is to let the fittest chromosomes survive and try to breed and pass forward the better offsprings. After a large generation iteration, it has a great chance to obtain the approximate optimal solution. For this 100-city-TSP, the possible routes of the exhaustive search can be as large as 100!, which is approximately <a href="https://www.codecogs.com/eqnedit.php?latex=9.3326&space;\times&space;10^{157}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?9.3326&space;\times&space;10^{157}" title="9.3326 \times 10^{157}" /></a>. Nevertheless, as a result, we can use GA to find the optimal shortest distance as 96.4273 in 205 seconds and only iterate 19757 generations, as shown in Figure 3. This result demonstrates the excellence of GA in solving the problems that could take huge search spaces.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118296923-1452b180-b510-11eb-977f-01653dbde125.png" height="280dp" /></p>

It is noteworthy that the fitness score of the most-fit individual in the last generation changes every time the model is being triggered. The reason is that chromosomes are generated randomly. Besides, positions of crossover and mutations are changed randomly. In this way, we can analogue the natural selection process, but this also increases the uncertainties in each generation. Therefore, it is a little probability for the fitness scores to remain the same after several more runs. Despite the fluctuations in the final best fitness scores, for this specific problem, GA guarantees that the final error residuals lie between a tolerant interval of [-2,2].

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118297098-4cf28b00-b510-11eb-98dc-1cb0ebdc1807.png" height="280dp" /></p>

To give the reader a more intuitive understanding of how our model works, the workflow of GA is shown in Figure 4. In this task, our algorithm optimisation can be grouped into five steps: parent selection, ordered crossover, offspring mutation, population replacement and stopping criteria. All of these steps have been illustrated in the workflow.

## Parent Selection

In this part, we implement selection procedures in both fitness proportionate and ordinal selections. For the former, we implement roulette wheel and stochastic universal selections. For the latter, we implement linear rank and tournament selections.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118297302-89be8200-b510-11eb-92f4-7aa7567a9cfa.png" height="280dp" /></p>

In addition, we compare performances of different selection procedures in several conditions, as shown in Figure 5. Figure 5a shows how the number of populations affects the final optimal distance. For all four procedures, there is a tendency for performance improvement by the increasing number of populations. More population means a more great chance of weak chromosomes is being chosen, contributing to better offsprings.

Figure 5b shows how the number of iterations affects the final optimal distance. Interesting facts are found during experiments:

First, linear rank selection leads to a slower convergence and performs worst overall. This selection strategy is used to avoid the best chromosome fitness being 90% of all the roulette wheel while other chromosomes will have no chances to be selected. In fact, this case does not appear in this TSP. Therefore, linear rank selection has no advantages over the others but instead exposes its disadvantage of slow convergence.

Second, with the number of iterations, stochastic universal selection overtakes tournament selection by obtaining the best fitness score in the last generation. This shows the advantages and disadvantages of both selection strategies: tournament selection is more efficient than stochastic universal selection as it converges fast. Nonetheless, it is easier to get stuck in the optimal local shortest distance since weak chromosomes have a smaller probability of being selected in a tournament, especially when the population is large. Stochastic universal selection is the complete opposite. It converges a little bit of slow and always reserves chances for weak chromosomes.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118297486-cbe7c380-b510-11eb-96cb-223145ee51e5.png" height="280dp" /></p>

Figure 6 shows the shortest distance of the most-fit individual in the last generation as required in task 2 and Figure 7 shows the best performance of tournament selection in the experiment.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118297591-f3d72700-b510-11eb-98da-fcde4b54f2b9.png" height="280dp" /></p>

In practices, tournament selection outperforms in most cases. In spite of the fact that it may not gain the globally optimal distance, I still prefer this selection over others as the parent selection strategy of my model given by its resource efficiency and high return on investment (ROI).

## Ordered Crossover

In this part, we implement an order-based crossover algorithm. In addition, we set the probability of crossover as 80\% and the probability of mutation as 20% since this proportion has the best performance. The source code is listed as follows:

```MATLAB
[L, W]     = size(Parent);
order_rand = randperm(L);
f          = zeros(L, W);
temp       = zeros(1, W);
lp         = W - 1;

for i = 2 : 2 : L
prob_rand  = rand;
parent1    = Parent(order_rand(i - 1), :);
parent2    = Parent(order_rand(i), :);

if (prob_rand <= prob_crossover)
sp                = randi([1, lp - 1]);
ep                = randi([sp, lp]);
% offspring 1
temp(sp: ep)      = parent1(sp : ep);
element_rest      = parent2(ismember(parent2(1 : end - 1), temp(sp : ep)) == 0);
temp(ep + 1 : lp) = element_rest(1 : (lp - ep));
temp(1 : sp - 1)  = element_rest((lp - ep + 1) : end);
temp(end)         = temp(1);
f(i - 1, :)       = temp;
% offspring 2
% Same procedure
else
f(i - 1, :)       = parent1;
f(i, :)           = parent2;
end

end
```

The code in this part is easy and self-explanation, but it is important to note that crossover may change the start city of the route. Thus, a safer approach is to update the end city as the start city after finishing the crossover procedure.

## Offspring Mutation

In this part, we use all three mutation operators (swap, flip and slide) in our model and experiment on the best probability of each operator under roulette wheel selection.

As illustrated in Table 1, *sp* stands for swap, *fp* stands for flip and *sd* stands for slide. Based on our experiences, flip increase the unnecessary distance of the route for this specific problem. Given that, we deliberately decrease the weights for the flip. Among six different weights comparison, we apply the weights strategy for swap probability of 30%, flip probability of 20% and slide probability of 50% into our model as it performs the best.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118297992-752eb980-b511-11eb-9017-7669d0faa8d3.png" height="180dp" /></p>

## Population Replacement

After creating a new population by crossover and mutation, the best chromosome has a high probability of being lost. Given that, in this part, we use elitism selection in our model.

Thereafter, we conduct an experiment on nine different proportions test with an iteration range from 1000 to 10000, as shown in Figure 8.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118298136-a9a27580-b511-11eb-8326-7b049e00d028.png" height="280dp" /></p>

The reader can intuitively find that the more proportion of the best parents in each generation, the more probabilities of being trapped in the locally optimal shortest distance. Based on experiment results, we choose 10% as the proportion of best parents since it leads to a reasonable converge speed against the possibility of overfitting.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118298222-c76fda80-b511-11eb-8ebb-0a8517c55697.png" height="280dp" /></p>

Furthermore, there is a technique that can be useful in this problem. It is called route reverse, as illustrated in Figure 9. After crossover and mutation, the routes of the cities are more likely to be inextricably intertwined. Figure 9a shows the route list of [1, 4, 2, 3, 5] where the paths of [1, 4] and [2, 5] can be further optimized. Figure 9b shows that we randomly reverse the routes in paths to minimize such unnecessary distance cost once the population replacement finishes.

## Stopping Criteria

For end conditions, we form four rules in our model:

**Rule 1**: If the number of iterations exceeds the given maximum number of iterations, our model will stop running.

**Rule 2**: If 90\% of the chromosomes in the population have the same fitness value, our model will stop running.

**Rule 3**: If the average fitness value in the population remains fixed for several iterations, our model will stop running.

**Rule 4** (Additional): If the shortest distance in the population remains fixed for several iterations, our model will stop running.

In our experiments, the first three rules did not work even the model has converged to the optimal solution according to the distance-generation correlation plot. The performance of each selection under our end conditions are listed in Table 2.

<p align="center"><img src="https://user-images.githubusercontent.com/37981444/118298460-1289ed80-b512-11eb-875b-ed79a4a4f2fc.png" height="180dp" /></p>
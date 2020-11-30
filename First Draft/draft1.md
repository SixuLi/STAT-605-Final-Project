### Statistical Models

Lasso logistic regression is selected as the statistical model to apply on our document matrix. Since lasso procedure encourages simple and sparse models, we have reduced dimensions in the previous data preprocessing procedure. 

### Logistic Regression

Logistic Regression is one of the few algorithms that is used for the task of Classification of data. Since we are interested in mining which words have strong relationships to the five star rating and which ones highly correlate to the negative reviews, and in regression analysis, the logistic regression  model is a form of binary regression and fits well in our purpose. In this project, logistic regression is estimating the parameters of a logistic model. Consider a generalized linear model function parameterized by $\theta$, 
$$
h_\theta(X)=\frac{1}{1+e^{-\theta^TX}}=Pr(Y=1|X;\theta)
$$
We are assuming that all the observations in the samples are independently Bernoulli distributed.

### Lasso

Although we reduced our data dimension according to eliminate the sparsity, it is still not enough for our regression analysis due to the complexity of the natural language especially the meaning and the diversities of the variables. Lasso regression is a type of linear regression that uses shrinkage, which stands for least absolute shrinkage and selection operators. We decide to use the Lasso linear model function parameterization for our logistic regression. Lasso regression performs L1 regularization, which adds a penalty equal to the absolute value of the magnitude of coefficients. This kind of penalty fits well in our circumstances. Because this type of regularization can result in sparse model and the coefficients can be eliminated from the model. Larger penalties like L2 regularization (e.g. Ridge regression) can not result in elimination of coefficients or sparse models. By Lasso regression, we substantially reduced the number of variables.
$$
\hat{\beta}^\lambda = argmin_{\beta \in \mathbb{R}^p} ||y-X\beta||_2^2+\lambda||\beta||_1 \\
\hat{S}^\lambda = \{k:\hat{\beta}_k^\lambda \neq 0\}
$$
where $X \in\mathbb{R} ^{n*p} $ is the design matrix, $y \in \mathbb{R}^n$ is a vector of outputs, and $\lambda$ is a regularization parameter that controls the size of the selection set.

By implemented methods above with our training dataset provided by previous step, we fit our models and build our findings.

### Findings

We finally found several word collocations associated with positive/negative review. Here is a image illustrating our findings. 

- story told, excellent job, along way, dog soldiers, fall love, highly recommend, well worth are associated with positive reviews
- needless say, two hours, sounds like, pretty bad, get wrong, waste money, bad movie, car chase, really wanted, seemed like, way much, new version, save money one worst are associated with negative reviews.

![Top 30 positive and negative words](C:\Users\KOU\School\STAT-605-Final-Project\Image\Top 30 positive and negative words.png)

We found that some words are seemed positive by ourselves but they are associated with negative reviews, which is interesting. And we also found some collocations do not make any sense. It may due to the process of using our corpus.

### Conclusion

To draw our conclusion, in this project, a textual dataset with about 35 million reviews from Amazon  with a time span from June 1995 to March 2013 is analyzed. By cleaning the data and reducing the dimension, performing the DTM procedure, we obtained our word matrix as our explanatory matrix. We built two-word collocation as our variables and performing the lasso logistic regression, finally build our result: the words collection associated with positive/negative reviews. We found that some words are representing adverse attitude compared to our expectation. Further analyses need to be taken.
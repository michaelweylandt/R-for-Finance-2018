data{
    int<lower=0> N; // Number of observations
    int<lower=0,upper=1> y[N]; // observed 0/1 variables
}
parameters{
    real<lower=0,upper=1> p; // unknown p
}
model{
    p ~ beta(1, 1); // weak prior
    y ~ bernoulli(p); // vectorized across elements of y
}

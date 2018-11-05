12.5. The Jackson lab publishes numerous datasets to do with genetics and phenotypes
of mice. At https://phenome.jax.org/projects/Crusio1, you can find a
dataset giving the strain of a mouse, its gender, and various observations (click
on the “Downloads” button). These observations are of body properties like
mass, behavior, and various properties of the mouse’s brain.

(a) We will predict the gender of a mouse from the body properties and the
behavior. The variables you want are columns 4 through 41 of the dataset
(or bw to visit time d3 d5; you shouldn’t use the id of the mouse). Read
the description; I’ve omitted the later behavioral measurements because
there are many N/A’s. Drop rows with N/A’s (there are relatively few).
How accurately can you predict gender using these measurements, using
a logistic regression and the lasso? For this exercise, you really should
use glmnet in R. Produce a plot of the classification error of the model
against the regularization variable (cv.glmnet – look at the type.measure
argument – and plot will do this for you). Compare the prediction of this
model with the baseline of predicting the most common gender for all
mice.

(b) We will predict the strain of a mouse from the body properties and the
behavior. The variables you want are columns 4 through 41 of the dataset
(or bw to visit time d3 d5; you shouldn’t use the id of the mouse). Read
the description; I’ve omitted the later behavioral measurements because
there are many N/A’s. Drop rows with N/A’s (there are relatively few).
This exercise is considerably more elaborate than the previous, because
multinomial logistic regression does not like classes with few examples.
You should drop strains with fewer than 10 rows. How accurately can
you predict strain using these measurements, using multinomial logistic
regression and the lasso? For this exercise, you really should use glmnet
in R. Produce a plot of the classification error of the model against the
regularization variable (cv.glmnet – look at the type.measure argument
– and plot will do this for you). Compare the prediction of this model
with the baseline of predicting a strain at random.

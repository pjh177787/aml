12.4. At http://genomics-pubs.princeton.edu/oncology/affydata/index.html, you will
find a dataset giving the expression of 2000 genes in tumor and normal colon
tissues. Build a logistic regression of the label (normal vs tumor) against the
expression levels for those genes. There are a total of 62 tissue samples, so
this is a wide regression. For this exercise, you really should use glmnet in R.
Produce a plot of the classification error of the model against the regularization
variable (cv.glmnet – look at the type.measure argument – and plot will
do this for you). Compare the prediction of this model with the baseline of
predicting the most common class.

The matrix I2000 contains the expression of the 2000 genes with highest minimal intensity across the 62 tissues. The genes are placed in order of descending minimal intensity. Each entry in I2000 is a gene intensity derived from the ~20 feature pairs that correspond to the gene on the chip, derived using the filtering process described in the ‘materials and methods’ section. The data is otherwise unprocessed (for example it has not been normalized by the mean intensity of each experiment).

The file ‘names’ contains the EST number and description of each of the 2000 genes, in an order that corresponds to the order in I2000. Note that some ESTs are repeated which means that they are tiled a number of times on the chip, with different choices of feature sequences. The descriptions UMGAP, HSAC07 and I correspond to control RNAs spiked with each experiment.

The identity of the 62 tissues is given in file tissues. The numbers correspond to patients, a positive sign to a normal tissue, and a negative sign to a tumor tissue.

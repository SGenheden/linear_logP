# Simple model and comparisons with physical models

This folder contains a simple linear statistics model that was used in my docent lecture "Simulate life!", which is also presented at the [Combine Engineering Journal](https://statsletters.com).

This folder also contains simulation data from two studies of water/octanol partition coefficients: ["Predicting partition coefficients with a simple all-atom/coarse-grained hybrid model"](http://pubs.acs.org/doi/abs/10.1021/acs.jctc.5b00963) and ["Solvation free energies and partition coefficients with the coarse-grained and hybrid all-atom/coarse-grained MARTINI models"
](https://link.springer.com/article/10.1007/s10822-017-0059-9)

The raw simulations data is contained in a number of files:

* elba.dat – Elba water/octanol logP
* elba_water.dat – Elba water free energies
* martini_cg.dat – CG Martini water/octanol logP
* martini_hybrid.dat – Hybrid AA/CG Martini water/octanol logP
* martini_water.dat – Hybrid AA/CG Martini water free energies
* linear.dat – the results of a simple OLS model on the molecules

In each of these files, the first column is the experimental free energy and the second column is the predicted free energy.

The R studio notebook to create the simple OLS model is available in `model.Rmd`

## Sympathy for data

This folder contains flows for the software [Sympathy for data](https://www.sympathyfordata.com/):

* sy_model.syx - the main flow that creates and evaluates the model
* read_data.syx - a sub-flow that reads in a table from an Excel spreadsheet
* select_xy.syx - a sub-flow that computes features and selects the X and Y matrices for the model
* remove_overlap.syx - an experimental flow that produces the `training_filtered.xlsx` spreadsheet

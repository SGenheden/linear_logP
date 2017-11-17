# Comparisons with physical models

This folder contains simulation data from two studies of water/octanol partition coefficients: ["Predicting partition coefficients with a simple all-atom/coarse-grained hybrid model"](http://pubs.acs.org/doi/abs/10.1021/acs.jctc.5b00963) and ["Solvation free energies and partition coefficients with the coarse-grained and hybrid all-atom/coarse-grained MARTINI models"
](https://link.springer.com/article/10.1007/s10822-017-0059-9)

It is mainly used to compare with the linear statistics model.

The raw simulations data is contained in a number of files:

* elba.dat – Elba water/octanol logP
* elba_water.dat – Elba water free energies
* martini_cg.dat – CG Martini water/octanol logP
* martini_hybrid.dat – Hybrid AA/CG Martini water/octanol logP
* martini_water.dat – Hybrid AA/CG Martini water free energies

In each of these files, the first column is the experimental free energy and the second column is the predicted free energy.

* minnesota.xlsx – SMILEs and molecular properties for each of molecules in the Martini study (the Elba study contains a few more)
* linear.dat – the results of a simple OLS model on the molecules in minnesota.xlsx

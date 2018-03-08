# On the use of linear models to predict partition coefficients

Simple and extensive linear models to predict water/octanol partition coefficients for small molecules.

## Models

There are two models in two subfolders:

* `model` - the extensive modelling efforts in the MSG500 course (autumn 2017)

* `phys` - simple model presented at my docent lecture and at the [Combine Engineering Journal](https://statsletters.com)

## Experimental data

The experimental *training* data was collected from the SI from the following article:
[Automated Parametrization of the Coarse-Grained Martini Force Field for Small Organic Molecules](http://pubs.acs.org/doi/suppl/10.1021/acs.jctc.5b00056). The **Table S1** was manually copied to the file `training.xlsx`

The experimental *test* data was collected from the Minnesota database and copied to the file `testing.xlsx`. This is a subset used in the paper ["Solvation free energies and partition coefficients with the coarse-grained and hybrid all-atom/coarse-grained MARTINI models".
](https://link.springer.com/article/10.1007/s10822-017-0059-9)

## Collecting molecular properties

The properties of the molecules were collected using the [Indigo](http://lifescience.opensource.epam.com/indigo/) package

```
python props/collect_props.py training.xlsx
```

## Overlap of experimental data sets

The indices of the molecules in the *training* data that is also in the *test* data was created by

```
python props/compare_smi.py training.xlsx testing.xlsx
```

and the indices are available in `overlap.dat`

The experimental training data *without* this overlap is available in `training_filtered.xlsx`.

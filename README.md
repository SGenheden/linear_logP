# A linear model of water/octanol partition coefficient

Project in the MSG500 course, autumn 2017

## Experimental data

The experimental data was collected from the SI from the following article:

[Automated Parametrization of the Coarse-Grained Martini Force Field for Small Organic Molecules](http://pubs.acs.org/doi/suppl/10.1021/acs.jctc.5b00056)

The **Table S1** was manually copied to the file `data.xlsx`

## Collecting molecular properties

The properties of the molecules were collected using the [Indigo](http://lifescience.opensource.epam.com/indigo/) package

```
python props/collect_props.py data.xlsx
```

"""
Find the overlap between two datasets, i.e. between the full dataset
and the Minnesota.
Will write out the overlapping indices to overlap.dat
"""
from __future__ import division, print_function, absolute_import

import sys

import openpyxl as xl
from indigo import Indigo
ind = Indigo()

def _extract_smiles(filename) :
    wb = xl.load_workbook(filename = filename)
    ws = wb['data']
    i = 2
    smiles = []
    while True :
        smi = ws.cell(row=i, column=2).value
        if smi is None :
            break
        smiles.append(smi)
        i += 1
    return smiles

smiles1 = _extract_smiles(sys.argv[1])
smiles2 = _extract_smiles(sys.argv[2])

indices = []
for i, smi1 in enumerate(smiles1, 1) :
    mol1 = ind.loadMolecule(smi1)
    found = False
    for smi2 in smiles2 :
        mol2 = ind.loadMolecule(smi2)
        if ind.exactMatch(mol1, mol2) is not None :
            found = True
            indices.append(i)
            print("Match %d %s %s"%(i, smi1, smi2))
            break

with open("overlap.dat",'w') as f :
    f.write("\n".join("%d"%i for i in indices))

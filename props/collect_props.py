"""
Collect molecular properties in an Excel sheet.
Calculates the properties with the Indigo package
"""
from __future__ import division, print_function, absolute_import

import sys

import openpyxl as xl
from indigo import Indigo
ind = Indigo()

# Electronegativity on the Allen scale
electronegativity = {1:2.3 , 2:4.16 , 3:0.912 , 4:1.576 , 5:2.051 , 6:2.544 ,
                    7:3.066 , 8:3.61 , 9:4.193 , 10:4.787 , 11:0.869 , 12:1.293 ,
                    13:1.613 , 14:1.916 , 15:2.253 , 16:2.589 , 17:2.869 , 18:3.242 ,
                    19:0.734 , 20:1.034 , 21:1.19 , 22:1.38 , 23:1.53 , 24:1.65 ,
                    25:1.75 , 26:1.8 , 27:1.84 , 28:1.88 , 29:1.85 , 30:1.59 ,
                    31:1.756 , 32:1.994 , 33:2.211 , 34:2.424 , 35:2.685 , 36:2.966 ,
                    37:0.706 , 38:0.963 , 39:1.12 , 40:1.32 , 41:1.41 , 42:1.47 ,
                    43:1.51 , 44:1.54 , 45:1.56 , 46:1.58 , 47:1.87 , 48:1.52 ,
                    49:1.656 , 50:1.824 , 51:1.984 , 52:2.158 , 53:2.359 , 54:2.582 ,
                    55:0.659 , 56:0.881 , 71:1.09 , 72:1.16 , 73:1.34 , 74:1.47 ,
                    75:1.6 , 76:1.65 , 77:1.68 , 78:1.72 , 79:1.92 , 80:1.76 ,
                    81:1.789 , 82:1.854 , 83:2.01 , 84:2.19 , 85:2.39 , 86:2.6 , 87:0.67 , 88:0.89}

def hbond_donors(mol) :

    q = ind.loadSmarts("[!$([#6,H0,-,-2,-3])]")
    try :
        return ind.substructureMatcher(mol).countMatches(q)
    except :
        return 0

def hbond_acceptors(mol) :

    q = ind.loadSmarts("[#6,#7;R0]=[#8]")
    try :
        return ind.substructureMatcher(mol).countMatches(q)
    except :
        return 0

def carbon_count(mol) :

    n = 0
    for atom in mol.iterateAtoms() :
        if atom.atomicNumber() == 6 :
            n +=1
    return n

def polar_count(mol) :

    carbon_en = electronegativity[6]
    n = 0
    for atom in mol.iterateAtoms() :
        try :
            if electronegativity[atom.atomicNumber()] > carbon_en :
                n +=1
        except :
            raise Exception("Unknown electronegativity=%d"%(atom.atomicNumber()))
    return n

wb = xl.load_workbook(filename = sys.argv[1])
ws = wb['data']

ws["E1"] = "Weight"
ws["F1"] = "Heavies"
ws["G1"] = "Carbons"
ws["H1"] = "Polar"
ws["I1"] = "Rings"
ws["J1"] = "HDonors"
ws["K1"] = "HAcceptors"

i = 2
while True :
    smi = ws.cell(row=i, column=2).value
    if smi is None :
        break
    mol = ind.loadMolecule(smi)
    ws.cell(row=i, column=5).value = mol.molecularWeight()
    ws.cell(row=i, column=6).value = mol.countHeavyAtoms()
    ws.cell(row=i, column=7).value = carbon_count(mol)
    ws.cell(row=i, column=8).value = polar_count(mol)
    ws.cell(row=i, column=9).value = mol.countSSSR()
    ws.cell(row=i, column=10).value = hbond_donors(mol)
    ws.cell(row=i, column=11).value = hbond_acceptors(mol)
    i += 1

wb.save(sys.argv[1])

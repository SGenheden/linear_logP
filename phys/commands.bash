#python compare_smi.py ../data.xlsx minnesota.xlsx 

python $SCRIPTS/Plot/plot_xy.py -f linear.dat -l linear -o linear.png --correlation --xlabel="Experiment [kcal/mol]" --ylabel="Modell [kcal/mol]"  --scatter --nostyle

python $SCRIPTS/Plot/plot_xy.py -f elba.dat -l linear -o elba.png --correlation --xlabel="Experiment [kcal/mol]" --ylabel="Modell [kcal/mol]"  --scatter --nostyle
python $SCRIPTS/Plot/plot_xy.py -f linear.dat elba.dat -l Statistik Elba  -o linear-elba.png --correlation --xlabel="Experiment [kcal/mol]" --ylabel="Modell [kcal/mol]"  --scatter --nostyle

python $SCRIPTS/Plot/plot_xy.py -f martini_hybrid.dat -l martini_hybrid -o martini_hybrid.png --correlation --xlabel="Experiment [kcal/mol]" --ylabel="Modell [kcal/mol]"  --scatter --nostyle
python $SCRIPTS/Plot/plot_xy.py -f martini_cg.dat -l martini_cg -o martini_cg.png --correlation --xlabel="Experiment [kcal/mol]" --ylabel="Modell [kcal/mol]"  --scatter --nostyle
python $SCRIPTS/Plot/plot_xy.py -f elba.dat martini_hybrid.dat martini_cg.dat  -l Elba Martini2 Martini1  -o martini_elba.png --correlation --xlabel="Experiment [kcal/mol]" --ylabel="Modell [kcal/mol]"  --scatter --nostyle

python $SCRIPTS/Plot/plot_xy.py -f elba_water.dat martini_water.dat  -l Elba Martini2 -o martini_elba_water.png --correlation --xlabel="Experiment [kcal/mol]" --ylabel="Modell [kcal/mol]"  --scatter --nostyle

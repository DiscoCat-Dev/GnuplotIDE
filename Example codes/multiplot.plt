#Multiplot in png/static mode must be initialized with
#reset. Otherwise, it execution will run only once and 
#only first plot will be written.

reset

set multiplot layout 2,2 title "GnuplotIDE - Multiplot Test"

set title "Sine"
set grid
plot sin(x) with lines lw 2 title "sin(x)"

set title "Cosine"
set grid
plot cos(x) with lines lw 2 title "cos(x)"

set title "Sine + Cosine"
set grid
plot sin(x) with lines lw 2 title "sin(x)", cos(x) with lines lw 2 title "cos(x)"

set title "Parabola"
set grid
plot x**2 with lines lw 2 title "x²"

unset multiplot



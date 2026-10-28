

set title "Logarithmic Spiral" font "DejaVu Sans,16"

set parametric

set trange [0:8*pi]
set samples 1000

set size ratio -1

set grid
set xlabel "X"
set ylabel "Y"

a = 0.12
b = 0.18

plot \
    a*exp(b*t)*cos(t), \
    a*exp(b*t)*sin(t) \
    with lines linewidth 3 title "r = a exp(bθ)"


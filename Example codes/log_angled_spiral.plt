

set title "Harmonic Logarithmic Spiral" font "DejaVu Sans,16"

set parametric
set trange [0:14*pi]
set samples 2000

set size ratio -1
set grid

a = 0.05
b = 0.10

plot \
    a*exp(b*t)*(1 + 0.18*sin(8*t))*cos(t), \
    a*exp(b*t)*(1 + 0.18*sin(8*t))*sin(t) \
    with lines linewidth 2 title "Harmonic logarithmic spiral"


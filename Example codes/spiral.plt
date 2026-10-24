set title "3D Spiral"
set xlabel "X"
set ylabel "Y"
set zlabel "Z"

set grid
set ticslevel 0
set view 60, 35

set parametric
set urange [0:12*pi]
set samples 500

splot (1+u/20)*cos(u), (1+u/20)*sin(u), u/4 \
    with lines lw 2 title "Expanding 3D Spiral"

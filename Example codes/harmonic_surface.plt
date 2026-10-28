
set title "Harmonic Spiral Surface" font "DejaVu Sans,16"

set xlabel "X"
set ylabel "Y"
set zlabel "Z"

set parametric

set urange [0:8*pi]
set vrange [-1.5:1.5]

set samples 180
set isosamples 45

set hidden3d
set pm3d depthorder

set view 65, 35

set xrange [-3:3]
set yrange [-3:3]
set zrange [-1.5:1.5]

splot \
    (1.2 + 0.25*cos(6*u) + v)*cos(u), \
    (1.2 + 0.25*cos(6*u) + v)*sin(u), \
    0.12*u + 0.35*sin(6*u) + v*0.35 \
    with pm3d notitle


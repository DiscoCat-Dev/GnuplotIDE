

set title "Parametric Torus" font "DejaVu Sans,16"

set xlabel "X"
set ylabel "Y"
set zlabel "Z"

set parametric
set urange [0:2*pi]
set vrange [0:2*pi]

set samples 100
set isosamples 50

set hidden3d
set view 65, 35

set xrange [-3:3]
set yrange [-3:3]
set zrange [-1.5:1.5]

set palette rgb 33,13,10

splot \
    (2 + cos(v))*cos(u), \
    (2 + cos(v))*sin(u), \
    sin(v) \
    with pm3d notitle


set title "Harmonic Spiral" font "DejaVu Sans,16"

set parametric
set urange [0:12*pi]
set vrange [-1:1]

set samples 240
set isosamples 35

set hidden3d
set pm3d depthorder
set view 65, 30

splot \
    (1.0 + 0.55*sin(3*u) + v)*cos(u), \
    (1.0 + 0.55*sin(3*u) + v)*sin(u), \
    0.08*u + 0.35*cos(5*u) + 0.25*v \
    with pm3d notitle


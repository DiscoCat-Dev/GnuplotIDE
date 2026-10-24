

set title "A Simple 3D Surface" font "DejaVu Sans,16"

set xlabel "X"
set ylabel "Y"
set zlabel "Z"

set xrange [-5:5]
set yrange [-5:5]

set samples 50
set isosamples 50

set palette rgbformulae 33,13,10
set pm3d
unset key

f(x,y) = sin(sqrt(x*x + y*y))

splot f(x,y) with pm3d
                          


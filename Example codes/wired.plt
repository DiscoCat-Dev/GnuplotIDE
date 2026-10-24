
set title "GnuplotIDE Test"
set xlabel "X"
set ylabel "Y"
set zlabel "Z"

set xrange [-5:5]
set yrange [-5:5]

splot sin(x) * cos(y)


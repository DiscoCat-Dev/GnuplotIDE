
set title "Nautilus — Parametric Shell"
set xlabel "X"
set ylabel "Y"
set zlabel "Z"

set parametric
set urange [0:2*pi]
set vrange [0:8*pi]
set samples 100, 240
set isosamples 40, 80

set hidden3d
set border 0
unset key
unset colorbox
set ticslevel 0
set view 65, 35
set xyplane 0

set palette defined (0 "#10102f", 0.25 "#315c9b", \
                     0.5 "#36b9b0", 0.75 "#f3d58a", 1 "#fff1cf")

splot (0.15+0.035*v)*cos(v)*cos(u), \
      (0.15+0.035*v)*cos(v)*sin(u), \
      (0.15+0.035*v)*sin(v)+0.045*v \
      with pm3d



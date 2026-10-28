

set title "Ocean Waves" textcolor rgb "#263746" font ",14"
set xlabel "X"
set ylabel "Y"
set zlabel "Height"

set xrange [-5:5]
set yrange [-5:5]
set zrange [-1:1]

set samples 100
set isosamples 100

set palette defined (0 "#174a7e", 0.5 "#45b8ac", 1 "#f6d365")
set pm3d
unset key
set border lc rgb "#8295a5"
set tics textcolor rgb "#465968"
set view 55, 35, 1, 1

f(x,y) = sin(sqrt(x*x + y*y))

splot f(x,y) with pm3d



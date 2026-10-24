

set title "Aurora — Fields of Light" textcolor rgb "#e8f4ff" font ",15"
set xlabel "X" textcolor rgb "#b8cce0"
set ylabel "Y" textcolor rgb "#b8cce0"
set zlabel "Intensity" textcolor rgb "#b8cce0"

set xrange [-4:4]
set yrange [-4:4]
set zrange [-0.5:2.5]

set samples 120
set isosamples 120

set palette defined ( \
    0.00 "#10143b", \
    0.20 "#293f8f", \
    0.40 "#287d9a", \
    0.60 "#42c6a5", \
    0.80 "#c0e86b", \
    1.00 "#fff1a8")

set pm3d
unset key
set border lc rgb "#53677f"
set tics textcolor rgb "#b8cce0"
set grid lc rgb "#263752"
set view 58, 32, 1, 1

set xyplane at -0.5

f(x,y) = 2*exp(-0.18*(x*x+y*y))*cos(1.5*sqrt(x*x+y*y)) \
         + 0.35*sin(2*x)*cos(2*y)

splot f(x,y) with pm3d



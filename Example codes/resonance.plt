

set title "Resonance — A Three-Dimensional Surface" textcolor rgb "#e8edf5" font ",16"
set xlabel "X" textcolor rgb "#cbd5e1"
set ylabel "Y" textcolor rgb "#cbd5e1"
set zlabel "Z" textcolor rgb "#cbd5e1"

set xrange [-8:8]
set yrange [-8:8]
set zrange [-1.2:1.2]

set samples 150
set isosamples 150

set hidden3d
set pm3d depthorder
set palette defined ( \
    0 "#081d58", \
    0.2 "#225ea8", \
    0.4 "#41b6c4", \
    0.6 "#a1dab4", \
    0.8 "#ffffb2", \
    1 "#f03b20")

set style line 1 lc rgb "#ffffff" lw 0.25
set border lc rgb "#64748b" lw 1
set tics textcolor rgb "#cbd5e1"
set grid lc rgb "#334155"
set xyplane at -1.2

set view 58, 35, 1.0, 1.0
set colorbox vertical
set colorbox user origin 0.91, 0.18 size 0.025, 0.65
set style line 10 lc rgb "#64748b" lw 1
set colorbox border 10
set cbtics textcolor rgb "#cbd5e1"

set object 1 rectangle from screen 0,0 to screen 1,1 behind \
    fc rgb "#0b1120" fillstyle solid 1.0 noborder

unset key
unset surface
set pm3d at s

sinc(x) = (x == 0 ? 1 : sin(x)/x)
f(x,y) = sinc(sqrt(x*x + y*y))*cos(0.7*sqrt(x*x + y*y))

splot f(x,y) with pm3d



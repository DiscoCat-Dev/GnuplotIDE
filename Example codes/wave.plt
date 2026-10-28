


set terminal gif animate delay 5 loop 0
set output "wave.gif"

set xrange [-5:5]
set yrange [-5:5]
set zrange [-1:1]

set samples 50
set isosamples 50
set palette rgbformulae 33,13,10
set pm3d
unset key

set title "Animated 3D Wave"

do for [i=0:60] {
    phase = i * 0.1
    f(x,y) = sin(sqrt(x*x + y*y) - phase)
    splot f(x,y) with pm3d
}

unset output



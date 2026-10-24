set title "Isosamples example"

set xrange [-5:5]
set yrange [-5:5]
set samples 30
set isosamples 30
splot sin(sqrt(x*x+y*y))


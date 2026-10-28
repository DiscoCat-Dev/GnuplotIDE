set title "Logarithmic Functions"
set xlabel "x"
set ylabel "log(x)"
set grid
set key top left

set xrange [0.1:20]

plot \
    log(x)       with lines lw 2 title "ln(x)", \
    log10(x)     with lines lw 2 title "log10(x)", \
    log(x)/log(2) with lines lw 2 title "log2(x)"

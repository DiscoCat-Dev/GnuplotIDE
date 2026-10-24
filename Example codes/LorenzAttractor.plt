
set title "Lorenz Attractor"

set xlabel "X"
set ylabel "Y"
set zlabel "Z"

set xrange [-25:25]
set yrange [-35:35]
set zrange [0:55]

set view 60, 30
set ticslevel 0

unset key

sigma = 10.0
rho   = 28.0
beta  = 8.0/3.0
dt    = 0.005

x = 1.0
y = 1.0
z = 1.0

set print $Lorenz

do for [i=1:20000] {
    print x, y, z

    dx = sigma * (y - x)
    dy = x * (rho - z) - y
    dz = x * y - beta * z

    x = x + dt * dx
    y = y + dt * dy
    z = z + dt * dz
}

set print

splot $Lorenz using 1:2:3 with lines lw 1

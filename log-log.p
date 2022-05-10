set term pngcairo dashed size 900, 500
set output "output.png"

set xlabel 'Gegenereerd gebouwdrukverschil (Pa)'

# Horizontal ylabel.
set lmargin 17
set ylabel "Volumestroom\n door de\n gebouwschil\n (l/s)" offset -3,1 rotate by 0

set grid

set logscale x
# set xtics 1,100,3000 # 4*10,2
set for [i=0:5] xtics (1*(10**i), 2*(10**i), 4*(10**i), 6*(10**i), 8*(10**i))
set xrange [4:100]

set logscale y
set ytics (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
set yrange [9.9:100]

# Fit log function on column 1 and 2 in data.dat.
fl(x) = a + b * x
fit fl(x) 'data.dat' u (log($1)):(log($2)) via a,b

# Fit second log function on column 3 and 4 in data.dat.
fsl(x) = c + d * x
fit fsl(x) 'data.dat' u (log($3)):(log($4)) via c,d

# Put legend left top.
set key left top
# Legend in box.
set key box width 2 height 2 opaque

# pt 5 is square.
# pt 7 is circle.
plot \
    'data.dat' u 1:2 title 'Onderdruk' with points lc rgb "red" pt 5, \
    exp(fl(log(x))) title 'Onderdruk' dt 2 lc rgb "black", \
    'data.dat' u 3:4 title 'Overdruk' with points lc rgb "red" pt 7, \
    exp(fsl(log(x))) title 'Overdruk' dt 1 lc rgb "black"


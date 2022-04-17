set terminal png size 800, 500
set output 'output.png'

set xlabel 'Gegenereerd gebouwdrukverschil (Pa)'
set ylabel 'Volumestroom door de gebouwschil (l/s)'

set grid

set logscale x
set xtics (4, 5, 6, 7, 8, 9, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
set xrange [4:100]

set logscale y
set ytics (10, 20, 30, 40, 50, 60, 70, 80, 90, 100)
set yrange [9.9:100]

fl(x) = a + b * x
fit fl(x) 'data.dat' u (log($1)):(log($2)) via a,b

plot \
    'data.dat' u 1:2 title 'Onderdruk' with points lc rgb "red", \
    exp(fl(log(x))) t 'log approx'


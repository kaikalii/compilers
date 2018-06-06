# for file in examples/*.c; do
#     echo ====$file====
#     ./scc < "$file" > "${file%.c}.s"
#     gcc -o -w "${file%.c}" "$file"
#     ./"${file%.c}" > "${file%.c}.txt"
#     diff "${file%.c}.txt" "${file%.c}.out"
# done

echo ====hello.c====
./scc < examples/hello.c > examples/hello.s
gcc examples/hello.s -o examples/hello
examples/hello > examples/hello.txt
diff examples/hello.txt examples/hello.out

echo ====global.c====
./scc < examples/global.c > examples/global.s
gcc examples/global.s -o examples/global
examples/global > examples/global.txt
diff examples/global.txt examples/global.out

echo ====int.c====
./scc < examples/int.c > examples/int.s
gcc examples/int.s -o examples/int
examples/int > examples/int.txt
diff examples/int.txt examples/int.out

echo ====mixed.c====
./scc < examples/mixed.c > examples/mixed.s
gcc examples/mixed.s -o examples/mixed
examples/mixed > examples/mixed.txt
diff examples/mixed.txt examples/mixed.out

echo ====qsort.c====
./scc < examples/qsort.c > examples/qsort.s
gcc examples/qsort.s -o examples/qsort
examples/qsort > examples/qsort.txt
diff examples/qsort.txt examples/qsort.out

echo ====tree.c====
./scc < examples/tree.c > examples/tree.s
gcc examples/tree.s -o examples/tree
examples/tree > examples/tree.txt
diff examples/tree.txt examples/tree.out

echo ====fib.c====
./scc < examples/fib.c > examples/fib.s
gcc examples/fib.s -o examples/fib
examples/fib > examples/fib.txt
diff examples/fib.txt examples/fib.out

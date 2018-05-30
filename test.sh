# for file in examples/*.c; do
#     echo ====$file====
#     ./scc < "$file" > /dev/null 2> "${file%.c}.txt"
#     diff "${file%.c}.txt" "${file%.c}.err"
# done

echo ====array.c====
./scc < examples/array.c > examples/array.s
gcc examples/array.s examples/array-lib.c -o examples/array
examples/array > examples/array.txt
diff examples/array.txt examples/array.out

echo ====global.c====
./scc < examples/global.c > examples/global.s
gcc examples/global.s examples/global-lib.c -o examples/global
examples/global > examples/global.txt
diff examples/global.txt examples/global.out

echo ====local.c====
./scc < examples/local.c > examples/local.s
gcc examples/local.s examples/local-lib.c -o examples/local
examples/local > examples/local.txt
diff examples/local.txt examples/local.out

echo ====towers.c====
./scc < examples/towers.c > examples/towers.s
gcc examples/towers.s examples/towers-lib.c -o examples/towers
examples/towers > examples/towers.txt
diff examples/towers.txt examples/towers.out

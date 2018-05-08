for file in examples/*.c; do
    echo ====$file====
    ./scc < "$file" > /dev/null 2> "${file%.c}.txt"
    diff "${file%.c}.txt" "${file%.c}.err"
done

for file in tests/*.c; do
    echo ====$file====
    ./scc < "$file" > "${file%.c}.txt"
    diff "${file%.c}.txt" "${file%.c}.out"
done

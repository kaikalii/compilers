for file in tests/*.c; do
    ./scc < "$file" > "${file%.c}.txt"
    diff "${file%.c}.txt" "${file%.c}.out"
done

for file in examples/*.c; do
    echo ====$file====
    ./scc < "$file" > "${file%.c}.s"
    gcc -w "$file" -o "${file%.c}" 
    ./"${file%.c}" < "${file%.c}.in" > "${file%.c}.txt"
    diff "${file%.c}.txt" "${file%.c}.out"
done

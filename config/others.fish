# link to ~/.config/fish/conf.d/others.fish

# 模拟wc -l, 但这里统计的是逻辑行数
function wcl
    if test (count $argv) -eq 0
        awk 'END { print NR }'
        return
    end

    set -l total 0

    for file in $argv
        if not test -f "$file"
            echo "wcl: $file: No such file or not a regular file" >&2
            continue
        end

        set -l lines (awk 'END { print NR }' "$file")
        echo "$lines $file"
        set total (math "$total + $lines")
    end

    if test (count $argv) -gt 1
        echo "$total total"
    end
end

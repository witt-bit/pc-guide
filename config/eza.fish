# link to ~/.config/fish/conf.d/eza.fish

# 模拟ls
alias els "eza --icons --group-directories-first"

# 模拟ls -a
alias elsa "eza -a --icons --group-directories-first"

# 模拟ls -l
alias elsl "eza -l \
  --icons \
  --git \
  --group-directories-first \
  --time-style=relative"

# 模拟ls -al
alias elsla "eza -la \
  --icons \
  --git \
  --group-directories-first \
  --time-style=relative"

# 模拟ls -R , 但默认只显示两层
function elt
    set -l level 2

    for arg in $argv
        if string match -q -- '--level=*' $arg
            set level ""
        end
    end

    if test -n "$level"
        set argv $argv --level=$level
    end

    eza --tree --icons --group-directories-first $argv
end
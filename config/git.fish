# link to ~/.config/fish/conf.d/git.fish


# git 冲突解决后，快速提交并推送
function git-resolve-commit-push
    argparse 'n/no-push' -- $argv
    or return 1

    set -l message "Resolve conflicts."

    if test (count $argv) -gt 0
        set message (string join " " $argv)
    end

    # 检查是否还有冲突文件
    if git diff --name-only --diff-filter=U | grep -q .
        echo "❌ Still have unresolved conflicts."
        return 1
    end

    git commit -m "$message"
    or return 1

    if not set -q _flag_no_push
        git push
    else
        echo "✅ Commit created, push skipped."
    end
end

alias grcp "git-resolve-commit-push"
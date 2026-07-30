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

# 创建 git worktree
function git-worktree-create
    if test (count $argv) -lt 1
        echo "Usage: git-worktree-create <branch> [worktree_dir]"
        return 1
    end

    set -l branch $argv[1]

    # 获取仓库根目录
    set -l repo_root (git rev-parse --show-toplevel 2>/dev/null)
    or begin
        echo "❌ Not inside a git repository."
        return 1
    end

    set -l project_name (basename "$repo_root")
    set -l parent_dir (path dirname "$repo_root")

    # worktree 根目录
    set -l worktree_root
    if test (count $argv) -ge 2
        set worktree_root $argv[2]
    else
        set worktree_root "$parent_dir/worktrees"
        mkdir -p "$worktree_root"
    end

    # 分支名转目录名
    set -l branch_dir (string replace -a "/" "_" "$branch")
    set -l target "$worktree_root/$project_name-$branch_dir"

    if test -e "$target"
        echo "❌ Worktree already exists:"
        echo "   $target"
        return 1
    end

    # 获取默认远程
    set -l remote (git config --get branch.(git branch --show-current).remote)

    if test -z "$remote"
        set remote (git remote | head -n1)
    end

    if git show-ref --verify --quiet "refs/heads/$branch"
        echo "Moving worktree '$branch' -> $target ..."

        # 本地已有
        git worktree add "$target" "$branch"
    else if git ls-remote --exit-code --heads $remote "$branch" >/dev/null 2>&1

        echo "Linking worktree '$branch' -> $target ..."

        # 远程存在，先取这一条分支
        git fetch --quiet $remote "$branch"
        or return 1

        git worktree add \
            --track \
            -b "$branch" \
            "$target" \
            "$remote/$branch"
    else
        echo "Creating worktree '$branch' -> $target ..."

        # 全新分支
        git worktree add -b "$branch" "$target"
    end
    or return 1

    # 复制 IDEA 配置
    if test -d "$repo_root/.idea"
        cp -R "$repo_root/.idea" "$target/"
    end

    echo "✅ Worktree created."

    # 当前工作区没有修改
    if test -z (git status --porcelain)
        return 0
    end

    echo
    read -P "Found uncommitted changes. Move to '$branch'? [y/N] " answer

    switch (string lower "$answer")
        case y yes
            set -l stash_message "auto create worktree '$branch' at "(date "+%F %T")

            git stash push -u -m "$stash_message"
            or return 1

            set -l stash_ref (
                git stash list |
                string match -r "stash@\{\d+\}:.*$stash_message" |
                head -n1 |
                string replace -r ":.*" ""
            )

            if test -z "$stash_ref"
                echo "❌ Failed to locate stash."
                return 1
            end

            git -C "$target" stash apply "$stash_ref"
            and git stash drop "$stash_ref"

            echo "✅ Changes moved to the new worktree."

        case '*'
            return 0
    end
end


alias grcp "git-resolve-commit-push"
alias gra "git commit --amend --reset-author --no-edit"
alias gwc "git-worktree-create"
alias grhf "git reset --hard FETCH_HEAD"

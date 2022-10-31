# 常用shell命令

> Author:Witt
>
> Date：2022-10-31

## 一、批量操作

### 1.批量执行`git`命令(与`find`命令组合版)

```bash
find ./ -name ".git" -type d | sed 's#/\.git$##' | xargs -I {} git -C {} pull
```


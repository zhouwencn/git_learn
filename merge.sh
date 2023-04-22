#!/bin/bash

# 解析命令行参数，获取当前分支的名称
current_branch="$1"

# 拉取远程分支的最新代码
git pull origin "$current_branch"

# 切换到 master 分支，拉取最新代码
git checkout master
git pull origin master

# 切换回当前分支，合并 master 分支
git checkout "$current_branch"
git merge master

# 如果合并过程中发生冲突，暂停并提示用户解决冲突
if [[ $(git status --porcelain | grep "^U" | wc -l) -gt 0 ]]; then
  echo "合并过程中发生冲突，请手动解决冲突后继续。"
  exit 1
fi

# 提交变更，推送到远程仓库
git push origin "$current_branch"

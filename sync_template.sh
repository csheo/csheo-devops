#!/bin/bash
#template_repository_url is optional, you must provide it at first run
#run this script with the following command: ./sync_template.sh $template_repository_url?

template_repository_url=$1

# Check if template remote already exists
git remote get-url template > /dev/null 2>&1
if [ $? -ne 0 ]; then
  if [ -n "$template_repository_url" ]; then
    git remote add template "$template_repository_url"
  fi
fi

git fetch template main

# Check if sync branch exists
git show-ref --quiet refs/heads/sync
if [ $? -eq 0 ]; then
  git checkout sync
else
  git checkout -b sync
fi

git merge template/main
git push origin sync

#!/bin/sh
echo '👍 INSTALLING THE GEM BUNDLE'
bundle install
bundle list | grep "jekyll ("
echo '👍 BUILDING THE SITE'
echo "Jekyll env = ${JEKYLL_ENV}"
bundle exec jekyll build
echo '👍 PUSHING IT BACK TO GITHUB-PAGES'
cd _site
remote_repo="https://x-access-token:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git" && \
remote_branch="gh-pages2" && \
git init && \
git config user.name "${GITHUB_ACTOR}" && \
git config user.email "${GITHUB_ACTOR}@users.noreply.github.com" && \
git add . && \
echo -n 'Files and directories to commit:' && ls -l | wc -l && \
git commit -m "Automated deployment triggered by ${GITHUB_SHA}" && \
git push $remote_repo $remote_branch --force && \
rm -fr .git && \
cd ../
echo '👍 GREAT SUCCESS!'
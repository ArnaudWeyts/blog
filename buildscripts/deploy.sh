#!/bin/bash -e
# deploy script for a jekyll blog
# heavily based on: https://gist.github.com/domenic/ec8b0fc8ab45f39403dd

SOURCE_BRANCH="master"
TARGET_BRANCH="gh-pages"
GH_REF="github.com/ArnaudWeyts/blog"

function doCompile {
  jekyll build
}

# Pull requests and commits to other branches shouldn't try to deploy, just build to verify
if [ "$TRAVIS_PULL_REQUEST" != "false" -o "$TRAVIS_BRANCH" != "$SOURCE_BRANCH" ]; then
    echo "Skipping deploy; just doing a build."
    doCompile
    exit 0
fi

# Save some useful information
REPO=`git config remote.origin.url`
SHA=`git rev-parse --verify HEAD`

# Clone the existing gh-pages for this repo into _site/
# Create a new empty branch if gh-pages doesn't exist yet (should only happen on first deploy)
git clone $REPO _site
cd _site
git checkout $TARGET_BRANCH || git checkout --orphan $TARGET_BRANCH
cd ..

# Clean out existing contents
# commented out because jekyll build cleans up the directory itself
# rm -rf _site/**/* || exit 0

# Run our compile script
doCompile

# Now let's go have some fun with the cloned repo
cd _site
git config user.name "Block-Bot"
git config user.email "bot@weyts.xyz"

# Add new files
git add .

# If there are no changes to the compiled _site (e.g. this is a README update) then just bail.
if [[ -z `git diff --cached --exit-code` ]]; then
    echo "No changes to the output on this push; exiting."
    exit 0
fi

# Commit the "changes", i.e. the new version.
git commit -m "Deployed to GitHub Pages using Travis-CI: ${SHA}"

# Now that we're all set up, we can push with the token
git push -f "https://${GH_TOKEN}@${GH_REF}" ${TARGET_BRANCH} > /dev/null 2>&1
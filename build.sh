#!/bin/bash

# only proceed script when started by pull request (PR)
if [ $TRAVIS_PULL_REQUEST == "false" ]; then
  echo "this is PR, exiting"
  exit 0
fi

# enable error reporting to the console
set -e

pwd
ls -al

rm -fr _site

# build site with jekyll, by default to `_site' folder
jekyll build

# cleanup
rm -rf ../cmip6dr.github.io.master

#clone `master' branch of the repository using encrypted GH_TOKEN for authentification
git clone https://${GH_TOKEN}@github.com/cmip6dr/cmip6dr.github.io.git ../cmip6dr.github.io.master

# copy generated HTML site to `master' branch
cp -fR _site/Documents/adoc/*.html ../cmip6dr.github.io.master/Documents

## NOTE these documents will be over-written if other versions exist in the pull request.

ls -lt ../cmip6dr.github.io.master/Documents
ls -lt Documents

# commit and push generated content to `master' branch
# since repository was cloned in write mode with token auth - we can push there
cd ../cmip6dr.github.io.master
git config user.email "martin.juckes@stfc.ac.uk"
git config user.name "Martin Juckes"
git add -A .
git commit -a -m "Travis #$TRAVIS_BUILD_NUMBER"
git push --quiet origin master > /dev/null 2>&1

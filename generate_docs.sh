#!/bin/bash

echo -e "Executing docs"

if [ "$TRAVIS_PULL_REQUEST" == "false" ] && [ "$TRAVIS_BRANCH" == "master" ]; then
    echo -e "Generating Jazzy output \n"
    
    cd tests
    
    jazzy --objc --clean --umbrella-header NSMutableNumber.h --framework-root . --module-version 1.1.3 --author "Oleh Kulykov" --author_url http://www.resident.name --github_url https://github.com/OlehKulykov/NSMutableNumber --module NSMutableNumber --root-url http://olehkulykov.github.io/NSMutableNumber --theme apple --min-acl public --readme ../README.md

    pushd docs

    echo -e "Creating gh-pages\n"
    git init
    git config user.email ${GIT_EMAIL}
    git config user.name ${GIT_NAME}
    git add -A
    git commit -m "Documentation from Travis build of $TRAVIS_COMMIT"
    git push --force --quiet "https://${GH_TOKEN}@github.com/OlehKulykov/NSMutableNumber.git" master:gh-pages > /dev/null 2>&1
        
    echo -e "Published documentation to gh-pages.\n"

    popd
fi

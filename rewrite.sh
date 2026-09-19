#!/bin/sh
git filter-branch -f --env-filter '
    export GIT_COMMITTER_NAME="Pranav kumar"
    export GIT_COMMITTER_EMAIL="pranavkumar2906@gmail.com"
    export GIT_AUTHOR_NAME="Pranav kumar"
    export GIT_AUTHOR_EMAIL="pranavkumar2906@gmail.com"
' --tag-name-filter cat -- --branches --tags

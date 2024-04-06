# Project 5
## CD Project Overview
- The goal of this project is to apply deployment principles to the contents of project 4. We will be implementing `git tag` metadata to introduce semantic versioning to our website via GitHub Actions, and will then be using webhooks to keep the website's production up to date.

## Semantic Versioning
- A tag in git can be generated in two ways:
    - Create and push a commit, then run `git tag -a [TAG_NAME] [COMMIT_ID]` to create the tag and `git push origin --tags` to push all tags or `git push origin [TAG_NAME]` to push a specific tag to remote (GitHub)
    - 
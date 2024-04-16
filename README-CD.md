# Project 5
## CD Project Overview
- The goal of this project is to apply deployment principles to the contents of project 4. We will be implementing `git tag` metadata to introduce semantic versioning to our website via GitHub Actions, and will then be using webhooks to automatically keep the website's production up to date whenever an update is released (AKA tagged and pushed to GitHub).

## Semantic Versioning
- A tag in git can be generated in two ways:
    - Create and push a commit, then run `git tag -a [TAG_NAME] [COMMIT_ID]` to create the tag and `git push origin --tags` to push all tags or `git push origin [TAG_NAME]` to push a specific tag to remote (GitHub)
    - Create a commit, but don't push it yet. Then a tag by using `git tag -a [TAG_NAME]`, which will be a tag of the commit just created. Then push the commit with `git push` then the tag with `git push origin --tags`.
### Workflow
- The updated GitHub workflow will now run when a TAG is pushed to the main branch of the repository. When that happens, it will checkout the repository, collect necessary image/tag metadata, login to docker hub, and build and push the image to dockerhub with the given tag name and label.
- [My DockerHub Repository](https://hub.docker.com/repository/docker/isabwami/sabwami-project4/general) 

## Deployment
- To install docker to my instance there were quite a few steps followed from Docker's documentation. In short, I had to add Docker's official GPG key to my instance, and then I had to add the Docker repository to `apt`'s sources. Once this was done, I was then able to install Docker using `sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin` and then verified it with `sudo docker run hello-world`
### Deployment Script
- Everytime an update is made to the containerized project, it is best to have a script that will stop and remove the old container, pull an updated container image, adn then run the new container. That way, we do not have to do these steps manually each time an update is made.  
- On the instance, the script should be where the `hooks.json` file specifies under `execute-command: "/path/to/script.sh"`. If someone else would like to use the script, they should either move the script to this location, or update the `hooks.json` file to the new location of the script.
### Client-Side Webhook Configuration
- To install adnanh's `webhook`, I chose to use `sudo apt-get install webhook` as it was the path of least resistance.
- To start the `webhook`, I used `webhook -hooks hooks.json -verbose`.
- The `webhook` definition file, `hooks.json` is what tells the webhook what it should do. The `id` field gives the hook a unique identifier, the `execute-command` field specifies what command should be run when the hook is triggered, and `command-working-directory` is used primarily for logging.
- This definition file should be in the directory the webhook is being run from.
- To ensure that the webhook listener is listening as soon as the system is booted, the webhook service file needed to be updated. Specifically, I had to point the service file to the directory in which my definition file was located. I changed the conditional statement to look for the hooks.json file and changed the ExecStart entry to point to the hooks.json file.
- After modifying the webhook service file, I needed to reload the daemon using `systemctl daemon-reload` and then had to restart the webhook service with `sudo systemctl restart webhook.service`.
### Server-Side Webhook Configuration
- To configure the webhook in DockerHub, I went to `Webhooks` under my repository and created a new webhook named `AWS` whos URL is `http://3.226.84.197:9000/hooks/deploy`. The webhook will be triggered only by push events.
- To configure the webhook in GitHub, I would go to my repositor settings and under Webhooks, I would give it the webhook URL and then would specify the `Content type`, `Secret` (if any), and the events that trigger the webhook. 
# Instructions
## Preparations
### Create GitHub Account
* create GitHub account with name and password
* follow the instructions available on the Internet for creating a *secret*
* save guard the secret for use later in the installation

### Create DockerHub Account
* create DokcertHub account with name and password
* follow the instructions available on the Internet for creating a *secret*
* save guard the secret for use later in the installation

### Set-Up 'ESSL-Lab Wiki-Page' Project
* create new project in GitHub
* add a README.md file
* store DockerHub secrets as '_New repository secret_' items
* connect VSC to new project

### Load Project and Content Files
* copy existing ESSL-Lab documentation files into root folder of project on local machine
* unzip and copy '*CICD.yml*' file to '_/path/to/yaml/file_'
* modify '*CICD.yml*' file to apply values specific to ESSL-Lab

### Make and Deploy Initial Wiki-Page Instance
#### Build Docker Image
* verify Docker is running on local machine
* change directory to folder with _Dockerfile_
* run the _Dockerfile_ from the command line using `sudo docker build -t name-of-build:tag .`
* Log-in to GitHub with user credentials
* Push built image using `sudo docker push name-of-docker-build:tag`
#### Deploy Wiki Image in ESSL-Cluster
* unzip and store 'ESSL-Wiki' K8s manifests in appropriate directory
* modify K8s manifest files to apply values specific to ESSL-Lab
* run `kubectl apply` command to evaluate K8s manifest files
* verify the '*Hugo-Wiki*' K8s pods running
* run `*kubectl port-forward*` command to access `*Hugo-Wiki*` landing page
* verify access to '_ESSL-Lab Wiki-Page_' landing page

### Automatically Build 'ESSL-Lab Wiki' Image
* make sure VSC work-space is connected to *main* project branch on GitHub repo
* commit and push files to GitHub repo
* watch the execution of the CI/CD pipeline
* go to DockerHub and verify that the Hugo image has been pushed

### Flux K8s Config Automation
#### Install Flux Baseline
* follow instructions on [Get Started with Flux](https://fluxcd.io/docs/get-started/)
* if "`flux check --pre`" command fails, make sure '*~/.kube/config*' is available
* include [Clone the git repositoy](https://fluxcd.io/docs/get-started/#clone-the-git-repository) step and then stop following the '*get started*' instructions

#### Automate Image Updates to GIT
* follow instructions on [Automate image updates to Git](https://fluxcd.io/docs/guides/image-update/)
* re-run the "`flux bootstrap github`" command with the the extra components
* subsequently follow the '*Deploy a demo app*' instructions, but apply modifications required for *ESSL-Lab Wiki*
* note, there will be steps that need to be skipped!!!
* use the recommended steps to verify FLUX updating the *ESSL-Wiki* image
* try to access the *ESSL-Wiki* landing page
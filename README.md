# GitOps Pipeline with Argo CD and Argo Rollouts

![image](https://github.com/Ritish134/Gitops-pipeline-ArgoCD/assets/121374890/4f1266ec-2afe-4199-9546-3e8bc45d1730)

## Overview

This repo demonstrates setting up a GitOps pipeline using Argo CD for continuous deployment and Argo Rollouts for advanced deployment strategies within a Kubernetes environment. This automates the deployment and management of a simple web application.

## Prerequisites

- Docker installed on your machine.
- kubectl installed on your machine.
- Minikube installed on your machine.

## Summary of Process

1. **Start Minikube with Docker as the Driver:**
   - Start Minikube using Docker as the driver.
     ```bash
     minikube start --driver=docker
     ```

     ![s1](https://github.com/Ritish134/web-app/assets/121374890/2bd5fc38-863b-4671-96e1-f0e6f81d16f8)


2. **Setup and Configuration:**
   - Created a GitHub repository to host the source code.
   - Install Argo CD on the Kubernetes cluster following the official documentation.
     ```bash
     kubectl create namespace argocd
     kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
     ```
   - Install the Argo Rollouts controller in the Kubernetes cluster following the official guide.
     ```bash
     kubectl create namespace argo-rollouts
     kubectl apply -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml
     ```

     ![s2](https://github.com/Ritish134/web-app/assets/121374890/2099e0eb-42ad-42d8-8d37-423bdd39bce3)


3. **Creating the GitOps Pipeline:**
   **Dockerize the Application:**
   - Build a Docker image for the web application and push it to a public container registry.<a href="https://hub.docker.com/repository/docker/ritish134/web-app/general" > Here </a>
     ```bash
     docker build -t ritish134/web-app:v1 .
     docker push ritish134/web-app:v1
     ```
     
    ![s3](https://github.com/Ritish134/web-app/assets/121374890/5c78943e-97d4-4b8d-b9bd-34e8cb34ae68)
    ![s4](https://github.com/Ritish134/web-app/assets/121374890/dbf269d2-4a8d-4ca5-b11f-f518c620f03e)

   - Modified Kubernetes manifests in the Git repository to use the Docker image.
   - Configured Argo CD to monitor the repository and automatically deploy changes to the Kubernetes cluster.

5. **Implementing a Canary Release with Argo Rollouts:**
   - Defined a rollout strategy using Argo Rollouts, specifying a canary release strategy.
   - Triggered a rollout by updating the Docker image, pushing the new version to the registry, and updating the rollout definition.
   - Monitored the rollout using Argo Rollouts to ensure successful completion of the canary release.
   
    ![s5](https://github.com/Ritish134/web-app/assets/121374890/63584ca4-22fd-4390-aa59-d3009157ba96)


## Challenges Encountered and Resolutions

- **ImagePullBackOff and ErrImagePull Errors:**
  - Challenge: Encountered issues with pulling the Docker image during deployment.
  - Resolution: Verified image availability, checked network connectivity, and ensured proper Docker and Kubernetes configurations.

  ![s7](https://github.com/Ritish134/web-app/assets/121374890/891a1315-4922-44cf-9f63-e4c3e104f06e)


- **Pending External IP for LoadBalancer Service:**
  - Challenge: Faced difficulties obtaining an external IP address for the LoadBalancer service.
  - Resolution: Used port forwarding or NodePort service types for local Kubernetes clusters.

  ![s6](https://github.com/Ritish134/web-app/assets/121374890/b73f74f7-9be4-4386-9a10-076f0aa9c73a)

  ![s8](https://github.com/Ritish134/web-app/assets/121374890/3dff5746-da70-4861-8a4a-5ff6a983dcfb)


## Clean Up

To cleanly remove all resources created from the Kubernetes cluster:

1. **Delete Argo CD Application:**
   - Log in to the Argo CD UI.
   - Delete the `web-app` application to remove deployed resources from the cluster.

2. **Uninstall Argo CD and Argo Rollouts Controllers:**

- Uninstall Argo CD:

   ```bash
   kubectl delete -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

- Uninstall Argo Rollouts:
  ```bash
  kubectl delete -n argo-rollouts -f https://github.com/argoproj/argo-rollouts/releases/latest/download/install.yaml

3. **Delete Kubernetes Resources:**
   - Use `kubectl delete` commands to delete any remaining Kubernetes resources, such as deployments, services, and pods.

4. **Clean Up Git Repository:**
   - Optionally, clean up the Git repository by removing any files or branches related to it.

By following these steps, we can ensure a clean removal of all resources created, leaving the Kubernetes cluster and Git repository in original state.

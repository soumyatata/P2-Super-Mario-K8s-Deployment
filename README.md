# **Super Mario Game on Kubernetes with Jenkins CI/CD**

This repository demonstrates how to deploy the Super Mario game on Kubernetes using **AWS EKS** (Elastic Kubernetes Service) and **Jenkins CI/CD pipeline**.

## **Project Overview**

In this project, I have used the following technologies:

- **Docker** for containerization of the Super Mario game.
- **AWS EKS** for Kubernetes orchestration.
- **Terraform** for managing the EKS infrastructure.
- **Jenkins CI/CD Pipeline** to automate the build and deployment process.

The project follows the steps below:

### **Docker Image Build and Push**:
- A Docker image for the Super Mario game is pulled, tagged, and pushed to Docker Hub for easy access.

### **Terraform for EKS Setup**:
- Infrastructure on AWS EKS is set up using Terraform.

### **Kubernetes Deployment**:
- The Docker image is deployed to a Kubernetes cluster in AWS EKS using kubectl.

### **Jenkins Pipeline**:
- The entire process is automated using a Jenkins pipeline, making the deployment process efficient and repeatable.

## **Steps Involved**

### **Docker Image Build and Push**:
- A Docker image for the Super Mario game is pulled from the repository and tagged with the appropriate name.
- The image is pushed to a Docker registry (e.g., Docker Hub) for use in Kubernetes deployments.

### **Terraform Infrastructure Setup**:
- The necessary infrastructure for EKS is created using Terraform. This includes creating an EKS cluster, configuring VPC, subnets, and other AWS resources.
- The infrastructure is provisioned using the `terraform init`, `terraform plan`, and `terraform apply` commands.

### **Kubernetes Deployment**:
- Kubernetes resources such as deployments and services are applied using kubectl.
- The game is exposed to the internet via a Kubernetes service, making it accessible from the web.

### **Jenkins CI/CD Pipeline**:
- Jenkins automates the entire workflow, from pulling code from GitHub, building and pushing the Docker image, to setting up the infrastructure and deploying the application on Kubernetes.

## **Pipeline Stages**

### **Clean Workspace**:
- Cleans up previous builds to ensure a clean slate for each run.

### **Checkout Code from GitHub**:
- Checks out the latest code from the main branch of the repository.

### **Pull, Tag and Push Docker Image**:
- Pulls the Docker image from the source, tags it appropriately, and pushes it to Docker Hub.

### **Terraform Plan**:
- Runs `terraform plan` to check the changes to be applied to the AWS infrastructure.

### **Terraform Apply**:
- Applies the Terraform plan and creates the infrastructure on AWS EKS.

### **Get EKS Cluster Name**:
- Retrieves the EKS cluster name from Terraform outputs and sets it as an environment variable.

### **Configure kubectl for EKS and Deploy**:
- Configures `kubectl` to interact with the EKS cluster and deploys Kubernetes resources such as deployments and services.

### **Clean Up Resources**:
- Cleans up the deployed Kubernetes resources and destroys Terraform-managed infrastructure to ensure a clean environment after testing.

## **Instructions to Run Locally**

1. Clone this repository:
    ```bash
    git clone https://github.com/soumyatata/P3-Super-Mario-K8s-Deployment.git
    ```

2. Make sure you have **Jenkins**, **Docker**, **Terraform**, and **kubectl** installed and configured.

3. Set up **AWS credentials** in Jenkins for `AWSCredentials` and Docker registry credentials as `docker`.

4. Run the **Jenkins pipeline**.

## **Reference**

- **Ajay Kumar Yegireddi's Article** - [This article](https://mrcloudbook.com/deploying-super-mario-on-kubernetes/) describes the manual process of deploying Super Mario on Kubernetes using Terraform and EKS.

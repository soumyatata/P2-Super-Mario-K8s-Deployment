# **Super Mario Game on Kubernetes with Jenkins CI/CD**

This repository demonstrates how to deploy the **Super Mario** game on **Kubernetes** using **AWS EKS** (Elastic Kubernetes Service) and **Jenkins CI/CD pipeline**.

## **Project Overview**

### **Technologies Used**
- **Docker** 🐳 - For containerization of the Super Mario game.
- **AWS EKS** ☁️ - For Kubernetes orchestration.
- **Terraform** 🌍 - For managing the EKS infrastructure.
- **Jenkins CI/CD Pipeline** 🚀 - To automate the build and deployment process.

## **Project Workflow**

### **1️⃣ Docker Image Pull and Push**
- Pulls a Docker image for the Super Mario game.
- Tags and pushes the image to **Docker Hub** for easy access.

### **2️⃣ Terraform for EKS Setup**
- Uses **Terraform** to set up infrastructure on **AWS EKS**.

### **3️⃣ Kubernetes Deployment**
- Deploys the Docker image to **AWS EKS** using `kubectl`.

### **4️⃣ Jenkins CI/CD Pipeline**
- Automates the entire process: **code checkout → Docker image build → push to registry → Kubernetes deployment**.

---

## **Pipeline Stages** 🛠️

### **🔹 Clean Workspace**
- Ensures a fresh build environment by removing old builds.

### **🔹 Checkout Code from GitHub**
- Retrieves the latest code from the repository.

### **🔹 Build and Push Docker Image**
- Pulls the Docker image, tags it, and pushes it to **Docker Hub**.

### **🔹 Terraform Plan & Apply**
- Runs `terraform plan` to preview infrastructure changes.
- Applies the infrastructure changes using `terraform apply`.

### **🔹 Configure `kubectl` for EKS & Deploy**
- Retrieves EKS cluster details from **Terraform outputs**.
- Configures `kubectl` and deploys Kubernetes resources.

### **🔹 Clean Up Resources** (Optional)
- Cleans up deployed resources and destroys the infrastructure if needed.

---

## **Setup Instructions 🏗️**

### **Prerequisites**
- **Jenkins**, **Docker**, **Terraform**, and **kubectl** installed & configured.
- **AWS credentials** added in Jenkins as `AWSCredentials`.
- **Docker registry credentials** stored in Jenkins as `docker`.

### **Steps to Run Locally**
1️⃣ Clone the repository:
```bash
 git clone https://github.com/soumyatata/P3-Super-Mario-K8s-Deployment.git
```
2️⃣ Navigate into the project directory:
```bash
 cd P3-Super-Mario-K8s-Deployment
```
3️⃣ Run the **Jenkins pipeline**.

---

## **References 📚**

- **Ajay Kumar Yegireddi's Article** - [Deploying Super Mario on Kubernetes](https://mrcloudbook.com/deploying-super-mario-on-kubernetes/)

---

🚀 **Happy Coding & Kubernetes Deployment!** 🕹️

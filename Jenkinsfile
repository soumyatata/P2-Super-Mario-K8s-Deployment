pipeline {
    agent any

    environment {
        // AWS credentials from Jenkins Credentials System
        AWS_ACCESS_KEY_ID     = credentials('AWSCredentials').username
        AWS_SECRET_ACCESS_KEY = credentials('AWSCredentials').password

        // Docker Hub credentials from Jenkins Credentials System
        DOCKER_HUB_CREDENTIALS = credentials('docker')
    }

    stages{
         stage('Clean Workspace') {
            steps {
                cleanWs()  // Clean up previous builds
            }
        }

        stage('Checkout code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/soumyatata/P3-Super-Mario-K8s-Deployment.git'
            }
        }


        stage('Pull,Tag and Push Docker Image'){
            steps {
                script {
                    // Pull the Docker image from the public repository
                    sh 'docker pull sevenajay/mario:latest'

                    // Log in to Docker Hub using Jenkins credentials
                    docker.withRegistry('https://registry.hub.docker.com', 'DOCKER_HUB_CREDENTIALS') {
                        // Tag the image with your Docker Hub repository
                        sh 'docker tag sevenajay/mario:latest myawsdevopsjourney/super-mario:latest'

                        // Push the image to your Docker Hub repository
                        sh 'docker push myawsdevopsjourney/super-mario:latest'
                    }
                }
            }
        }

        // stage('Terraform Init and Apply'){

        // }

        // stage('Kubernetes Deployment'){

        // }
    }
}
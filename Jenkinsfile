pipeline {
    agent any

    environment {
        // AWS credentials from Jenkins Credentials System
        // AWS_ACCESS_KEY_ID     = credentials('AWSCredentials').username
        // AWS_SECRET_ACCESS_KEY = credentials('AWSCredentials').password

        // Docker Hub credentials from Jenkins Credentials System
        DOCKER_REGISTRY_CREDENTIALS = 'docker'
        DOCKER_IMAGE = 'myawsdevopsjourney/p3-super-mario:latest'
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
                    withDockerRegistry(credentialsId: "${DOCKER_REGISTRY_CREDENTIALS}") {
                        sh '''
                        docker tag sevenajay/mario:latest ${DOCKER_IMAGE}
                        docker push ${DOCKER_IMAGE}
                        '''
                    }
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    withCredentials([[$class: 'UsernamePasswordMultiBinding', 
                                      credentialsId: "${AWS_CREDENTIALS_ID}", 
                                      usernameVariable: 'AWS_ACCESS_KEY_ID', 
                                      passwordVariable: 'AWS_SECRET_ACCESS_KEY']]) {
                        sh '''
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        terraform init
                        terraform plan -out=tfplan
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply if Changes Detected') {
            steps {
                script {
                    def planOutput = sh(script: "terraform show -json tfplan | jq '.resource_changes'", returnStdout: true).trim()
                    if (planOutput != "[]") {
                        echo "Changes detected, applying Terraform..."
                        sh 'terraform apply -auto-approve tfplan'
                    } else {
                        echo "No changes detected, skipping Terraform apply."
                    }
                }
            }
        }

        stage('Kubernetes Deployment') {
            steps {
                script {
                    sh '''
                    kubectl apply -f k8s/deployment.yaml
                    kubectl apply -f k8s/service.yaml
                    '''
                }
            }
        }
    }
}
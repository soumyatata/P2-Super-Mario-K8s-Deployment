pipeline {
    agent any

    environment {
        AWS_CREDENTIALS_ID = 'AWSCredentials'
        DOCKER_REGISTRY_CREDENTIALS = 'docker'
        DOCKER_IMAGE = 'myawsdevopsjourney/p2-super-mario:latest'
        AWS_REGION = 'us-east-1'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()  // Clean up previous builds
            }
        }

        stage('Checkout code from GitHub') {
            steps {
                git branch: 'main', url: 'https://github.com/soumyatata/P2-Super-Mario-K8s-Deployment'
            }
        }

        stage('Pull,Tag and Push Docker Image') {
            steps {
                script {
                    sh 'docker pull sevenajay/mario:latest'

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
                    withCredentials([aws(credentialsId: 'AWSCredentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
                        export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
                        cd EKS-TF
                        
                        # Remove any previous lock file and plan
                        rm -f terraform.lock.hcl
                        rm -f tfplan
                        
                        # Clear any old Terraform state files
                        rm -rf .terraform
                        
                        # Re-initialize Terraform and upgrade provider if needed
                        terraform init -upgrade
                        

                        # Generate a new plan file
                        terraform plan -out=tfplan

                        terraform show -no-color tfplan > tfplan.txt
                        ls -al
                        '''
                    }
                }
            }
        }

        stage('Terraform Apply if Changes Detected') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWSCredentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                         cd EKS-TF
                         terraform apply -input=false tfplan
                        '''
                    }
                }
            }
        }
        
        stage('Get EKS Cluster Name') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWSCredentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        // Retrieve the cluster name dynamically using terraform output
                        def clusterName = sh(script: 'cd EKS-TF && terraform output -raw eks_cluster_name', returnStdout: true).trim()
                        echo "EKS Cluster Name: ${clusterName}"
                        env.EKS_CLUSTER_NAME = clusterName // Set the EKS cluster name as an environment variable
                    }
                }
            }
        }

        stage('Configure kubectl for EKS and Deploy') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWSCredentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        # Configure kubectl to use the newly created EKS cluster
                        aws eks --region ${AWS_REGION} update-kubeconfig --name ${EKS_CLUSTER_NAME}
                        
                        kubectl apply -f deployment.yaml
                        kubectl get all
                        kubectl apply -f service.yaml
                        kubectl get all
                        kubectl describe service mario-service
                        '''
                    }
                }
            }
        }
        
         // **New Stage to Clean Up Resources**
        stage('Clean Up Resources') {
            steps {
                script {
                    withCredentials([aws(credentialsId: 'AWSCredentials', accessKeyVariable: 'AWS_ACCESS_KEY_ID', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                        sh '''
                        # Clean up Kubernetes Resources
                        echo "Deleting Kubernetes service and deployment..."
                        kubectl delete service mario-service || true
                        kubectl delete deployment mario-deployment || true
                        
                        # Destroy Terraform-managed Infrastructure
                        echo "Destroying Terraform-managed resources..."
                        cd EKS-TF
                        terraform destroy --auto-approve
                        '''
                    }
                }
            }
        }
       
    }
}

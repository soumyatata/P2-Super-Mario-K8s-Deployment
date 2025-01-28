pipeline{
    agent any

    environment{
        SONAR_TOKEN = credentials('sonar-token')  
        DOCKER_CREDENTIALS = credentials('docker')  
        AWS_CREDENTIALS = credentials('AWSCredentials')
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

        stage('Sonarqube Analysis'){
            steps {
                withCredentials([string(credentialsId: 'sonar-token', variable: 'SONAR_TOKEN')]) {
                    script {
                        sh 'sonar-scanner -Dsonar.login=$SONAR_TOKEN'
                    }
                }
            }
        }

        // stage('Docker Pull,Tag and Push'){

        // }

        // stage('Terraform Init and Apply'){

        // }

        // stage('Kubernetes Deployment'){

        // }
    }
}
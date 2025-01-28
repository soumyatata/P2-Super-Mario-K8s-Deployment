pipeline{
    agent any

    environment{
        SONAR_TOKEN = credentials('sonar-token')  
        DOCKER_CREDENTIALS = credentials('docker')  
        AWS_CREDENTIALS = credentials('AWSCredentials')
    }

    stages{
        stage('Checkout'){

        }

        stage('Sonarqube Analysis'){

        }

        stage('Docker Pull,Tag and Push'){

        }

        stage('Terraform Init and Apply'){

        }

        stage('Kubernetes Deployment'){
            
        }
    }
}
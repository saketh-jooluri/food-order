pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS_ID = 'docker-hub-credentials'
        DOCKERHUB_USERNAME = 'sakethjooluri'
        NAMESPACE = 'food-app'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh 'docker build -t $DOCKERHUB_USERNAME/auth-service:latest ./auth-service'
                    sh 'docker build -t $DOCKERHUB_USERNAME/order-service:latest ./order-service'
                    sh 'docker build -t $DOCKERHUB_USERNAME/payment-service:latest ./payment-service'
                    sh 'docker build -t $DOCKERHUB_USERNAME/restaurant-service:latest ./restaurant-service'
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: DOCKERHUB_CREDENTIALS_ID, usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                        sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                        
                        sh 'docker push $DOCKERHUB_USERNAME/auth-service:latest'
                        sh 'docker push $DOCKERHUB_USERNAME/order-service:latest'
                        sh 'docker push $DOCKERHUB_USERNAME/payment-service:latest'
                        sh 'docker push $DOCKERHUB_USERNAME/restaurant-service:latest'
                    }
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    // Ensure ansible is installed or use a docker agent with ansible
                    // Assuming ansible is available in the Jenkins agent
                    dir('ansible') {
                        sh 'ansible-playbook deploy-all-services.yml'
                    }
                }
            }
        }
    }
}

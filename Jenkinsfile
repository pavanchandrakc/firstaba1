pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "pavanchandrakc/pavan"
        IMAGE_TAG = "9"
        LATEST_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build & Test with Maven') {
            steps {
                script {
                    echo "JAVA_HOME: ${JAVA_HOME}"
                    echo "Maven version:"
                    bat 'mvn --version'
                    bat 'mvn clean test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    bat "docker build -t ${DOCKER_IMAGE}:${IMAGE_TAG} ."
                    bat "docker tag ${DOCKER_IMAGE}:${IMAGE_TAG} ${DOCKER_IMAGE}:${LATEST_TAG}"
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                    script {
                        bat "echo ${DOCKER_PASSWORD} | docker login -u ${DOCKER_USERNAME} --password-stdin"
                        bat "docker push ${DOCKER_IMAGE}:${IMAGE_TAG}"
                        bat "docker push ${DOCKER_IMAGE}:${LATEST_TAG}"
                    }
                }
            }
        }
    }

    post {
        success {
            emailext subject: 'Build Success',
                     body: 'Jenkins build completed successfully.',
                     to: 'pavanchandra2599@gmail.com'
        }
        failure {
            emailext subject: 'Build Failed',
                     body: 'Jenkins build failed. Please check the logs.',
                     to: 'pavanchandra2599@gmail.com'
        }
    }
}

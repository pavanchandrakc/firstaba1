pipeline {
    agent any

    environment {
        IMAGE_NAME = "pavanchandrakc/pavan"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${IMAGE_NAME}")
                }
            }
        }

        stage('Push to Docker Hub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        success {
            mail to: 'pavanchandra2599@gmail.com',
                 subject: "✅ Build Success: ${env.JOB_NAME}",
                 body: "The build and deployment completed successfully."
        }
        failure {
            mail to: 'pavanchandra2599@gmail.com',
                 subject: "❌ Build Failed: ${env.JOB_NAME}",
                 body: "There was an error in the pipeline. Check Jenkins logs."
        }
    }
}

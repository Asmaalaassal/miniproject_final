pipeline {
    agent any

    environment {
        REGISTRY = 'localhost:5000'
        IMAGE_BASE = 'miniproject'
        IMAGE_TAG = "${env.BUILD_NUMBER}"
        IMAGE_NAME = "${REGISTRY}/${IMAGE_BASE}:${IMAGE_TAG}"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-token', url: 'https://github.com/Asmaalaassal/miniproject_final.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $IMAGE_NAME .'
            }
        }

        stage('Push to Local Registry') {
            steps {
                sh 'docker push $IMAGE_NAME'
            }
        }

        stage('Update Deployment') {
            steps {
                sh """
                    sed 's|IMAGE_PLACEHOLDER|$IMAGE_NAME|' k8s-deployment.yaml > k8s-deployment-final.yaml
                    kubectl apply -f k8s-deployment-final.yaml
                """
            }
        }
    }

    post {
        success {
            echo '✅ Deployment completed successfully!'
        }
        failure {
            echo '❌ Deployment failed.'
        }
    }
}
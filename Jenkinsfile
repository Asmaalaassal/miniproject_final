pipeline {
    agent any

    environment {
        IMAGE_NAME = 'localhost:5000/miniproject:latest'
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

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    def timestamp = System.currentTimeMillis()
                    sh """
                        sed -i 's/redeploy-timestamp: ".*"/redeploy-timestamp: "${timestamp}"/' k8s-deployment.yaml
                        kubectl apply -f k8s-deployment.yaml
                    """
                }
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

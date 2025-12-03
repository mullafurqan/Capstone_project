pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "devopsx-app"
        DOCKER_TAG = "latest"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
                echo "Source code pulled from GitHub"
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh '''
                    eval $(minikube docker-env)
                    cd app
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    '''
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl apply -f k8s/deployment.yaml
                kubectl apply -f k8s/service.yaml
                kubectl apply -f k8s/servicemonitor.yaml
                kubectl rollout restart deployment devopsx-deploy
                '''
            }
        }
    }

    post {
        success {
            echo "🎉 Build & Deployment Successful!"
        }
        failure {
            echo "❌ Build/Deployment Failed!"
        }
    }
}

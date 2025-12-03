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
                bat '''
                echo === BUILD STAGE STARTED ===
                cd app
                dir
                echo (Here you would run: docker build -t %DOCKER_IMAGE%:%DOCKER_TAG% .)
                '''
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat '''
                echo === DEPLOY STAGE STARTED ===
                echo (Here you would run: kubectl apply -f k8s\\deployment.yaml etc.)
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


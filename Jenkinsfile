pipeline {
    agent any

    environment {
        AWS_REGION      = "us-east-1"
        AWS_ACCOUNT_ID  = "541739678686"
        ECR_REGISTRY    = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
        APP_NAME        = "devops-python-app"
        IMAGE_TAG       = "v${BUILD_NUMBER}"
        ECR_IMAGE       = "${ECR_REGISTRY}/${APP_NAME}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Python Unit Tests') {
            steps {
                sh '''
                    python3 -m venv .venv
                    . .venv/bin/activate
                    pip install -r app/requirements.txt
                    pytest app/test_main.py
                '''
            }
        }

        stage('Maven Java Build & Test') {
            steps {
                dir('java-util') {
                    sh 'mvn clean test compile'
                }
            }
        }

        stage('SonarQube Analysis') {
            steps {
                script {
                    def scannerHome = tool 'Sonar-Scanner'
                    withSonarQubeEnv('SonarQube-Server') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }
                }
            }
        }

        stage('Quality Gate') {
            steps {
                timeout(time: 2, unit: 'MINUTES') {
                    waitForQualityGate abortPipeline: true
                }
            }
        }

        stage('Docker Build & Push to ECR') {
            steps {
                sh '''
                    aws ecr get-login-password --region ${AWS_REGION} | docker login --username AWS --password-stdin ${ECR_REGISTRY}
                    docker build -t ${ECR_IMAGE}:${IMAGE_TAG} -t ${ECR_IMAGE}:latest .
                    docker push ${ECR_IMAGE}:${IMAGE_TAG}
                    docker push ${ECR_IMAGE}:latest
                '''
            }
        }
    }

    post {
        always {
            sh "docker logout ${ECR_REGISTRY} || true"
            cleanWs()
        }
    }
}

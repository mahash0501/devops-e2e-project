pipeline {
    agent any

    environment {
        IMAGE_TAG = "v${BUILD_NUMBER}"
        APP_NAME  = "devops-python-app"
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
                withSonarQubeEnv('SonarQube-Server') {
                    def scannerHome = tool 'Sonar-Scanner'
                    sh "${scannerHome}/bin/sonar-scanner"
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

        stage('Docker Build') {
            steps {
                sh "docker build -t ${APP_NAME}:${IMAGE_TAG} -t ${APP_NAME}:latest ."
            }
        }
    }

    post {
        always {
            cleanWs()
        }
    }
}

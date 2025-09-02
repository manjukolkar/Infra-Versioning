pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = "us-east-1"
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/manjukolkar/Infra-Versioning.git'
            }
        }
        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }
        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }
        stage('Terraform Plan') {
            steps {
                sh 'terraform plan -out=tfplan'
            }
        }
        stage('Terraform Apply') {
            steps {
                input message: 'Approve deployment?', ok: 'Deploy'
                sh 'terraform apply -auto-approve tfplan'
            }
        }
    }
    post {
        always {
            archiveArtifacts artifacts: 'tfplan', fingerprint: true
        }
    }
}

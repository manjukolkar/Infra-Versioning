pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
        // Replace with the ID of the Jenkins credential you created (type = AWS credentials)
        AWS_CREDS = credentials('aws-creds')
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/manjukolkar/Infra-Versioning.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withEnv([
                    "AWS_ACCESS_KEY_ID=${AWS_CREDS_USR}",
                    "AWS_SECRET_ACCESS_KEY=${AWS_CREDS_PSW}",
                    "AWS_DEFAULT_REGION=${AWS_REGION}"
                ]) {
                    sh 'terraform init -input=false'
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                withEnv([
                    "AWS_ACCESS_KEY_ID=${AWS_CREDS_USR}",
                    "AWS_SECRET_ACCESS_KEY=${AWS_CREDS_PSW}",
                    "AWS_DEFAULT_REGION=${AWS_REGION}"
                ]) {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                withEnv([
                    "AWS_ACCESS_KEY_ID=${AWS_CREDS_USR}",
                    "AWS_SECRET_ACCESS_KEY=${AWS_CREDS_PSW}",
                    "AWS_DEFAULT_REGION=${AWS_REGION}"
                ]) {
                    sh 'terraform plan -out=tfplan'
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                input(message: "Approve apply?", ok: "Apply")
                withEnv([
                    "AWS_ACCESS_KEY_ID=${AWS_CREDS_USR}",
                    "AWS_SECRET_ACCESS_KEY=${AWS_CREDS_PSW}",
                    "AWS_DEFAULT_REGION=${AWS_REGION}"
                ]) {
                    sh 'terraform apply -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/terraform.tfstate*', fingerprint: true
        }
    }
}

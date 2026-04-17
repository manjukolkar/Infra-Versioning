pipeline {
    agent any

    environment {
        AWS_REGION = "us-east-1"
    }

    options {
        timestamps()
    }

    stages {

        stage('Checkout') {
            steps {
                cleanWs()  
                git branch: 'master', url: 'https://github.com/manjukolkar/Infra-Versioning.git'
            }
        }

        stage('Terraform Init') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    retry(2) {  
                        sh '''
                        rm -rf .terraform
                        terraform init -input=false -reconfigure
                        '''
                    }
                }
            }
        }

        stage('Terraform Validate') {
            steps {
                sh 'terraform validate'
            }
        }

        stage('Terraform Plan') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform plan -input=false -out=tfplan'
                }
            }
        }

        stage('Approval to Proceed') {
            steps {
                script {
                    timeout(time: 2, unit: 'MINUTES') {  
                        def userInput = input(
                            id: 'ApprovalInput',
                            message: '⚠️ Proceed with Terraform Apply?',
                            parameters: [
                                choice(
                                    name: 'CONFIRM',
                                    choices: ['No', 'Yes'],
                                    description: 'Select Yes to continue'
                                )
                            ]
                        )

                        if (userInput != 'Yes') {
                            error("❌ Apply aborted by user.")
                        }
                    }
                }
            }
        }

        stage('Terraform Apply') {
            steps {
                withAWS(credentials: 'aws-creds', region: "${AWS_REGION}") {
                    sh 'terraform apply -input=false -auto-approve tfplan'
                }
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: '**/*.tf', allowEmptyArchive: true
        }
        failure {
            echo "❌ Pipeline failed. Check Terraform state or backend lock."
        }
    }
}

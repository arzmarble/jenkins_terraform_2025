pipeline {
    agent any

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
        choice(name: 'action', choices: ['apply', 'destroy'], description: 'Select the action to perform')
    }

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION    = 'ap-southeast-1'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/arzmarble/jenkins_terraform_2025.git'
            }
        }
        stage('Terraform init') {
            steps {
                sh 'terraform init'
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan -out tfplan'
                sh 'terraform show -no-color tfplan > tfplan.txt'
            }
        }
        stage('Approval Gate') {
            // จะหยุดรอถ้าไม่ได้ติ๊ก autoApprove หรือถ้าเลือก action เป็น destroy
            when {
                expression { params.autoApprove == false || params.action == 'destroy' }
            }
            steps {
                script {
                    def plan = readFile 'tfplan.txt'
                    input message: "Review ${params.action.toUpperCase()} action",
                          parameters: [text(name: 'Terraform Plan Output', defaultValue: plan)]
                }
            }
        }

        stage('Execution') {
            steps {
                script {
                    if (params.action == 'apply') {
                        sh 'terraform apply -input=false tfplan'
                    } else if (params.action == 'destroy') {
                        sh 'terraform destroy --auto-approve'
                    }
                }
            }
        }
    }

    post {
        always {
            // ลบไฟล์ Plan ทิ้งเพื่อความปลอดภัย ไม่ให้มีข้อมูล Infra ค้างในเครื่อง
            sh 'rm -f tfplan tfplan.txt'
        }
    }
}
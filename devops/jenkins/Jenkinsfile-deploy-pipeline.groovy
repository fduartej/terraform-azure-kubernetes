def TF_WORKSPACE='terraform-kubernetes'
pipeline{
    agent{
        docker {
            image 'hashicorp/terraform:latest'
            args  "--entrypoint=''"
            reuseNode true
        }
    }

    options { 
        timestamps () 
        skipStagesAfterUnstable()
        skipDefaultCheckout()
    }

    environment {
        TF_WORKSPACE2 = 'terraform-kubernetes' 
    }

    stages{
        stage('Prepare'){
            steps{
                checkout scm
                echo 'Prepare...'  
                sh 'terraform --version'
            }
        }

        stage('Terraform Init'){
            steps{
                echo 'Terraform Init...'  
                sh "pwd"
                sh "ls -Rls"
                sh """
                    cd terraform-kubernetes/devops/terraform
                    terraform init
                """
            }
        }

        stage('Terraform Plan'){
            steps{
                echo 'Terraform Plan...'
                sh "pwd"  
                sh """
                    cd terraform-kubernetes/devops/terraform
                    terraform plan -var-file='develop.tfvars' -out=tfplan.out
                    ls -ll
                """
            }
        }

        stage('Terraform Apply'){
            steps{
                echo 'Terraform Apply...'  
                sh """
                    cd terraform-kubernetes/devops/terraform
                    terraform apply -var-file='develop.tfvars' tfplan.out
                """
            }
        }

        stage('Save State'){
            steps{
                echo 'Save State...'  
            }
        }

    }

}
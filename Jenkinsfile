#!groovy

//@Library('github.com/ayudadigital/jenkins-pipeline-library@v6.3.0') _


pipeline {
    agent any 
    // agent { label 'docker' }
    options {
        
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {
        
        stage ('Terraform Init') {
            environment{
                ACCOUNT_ID= "774430347359"
            }

            steps  {
                script{    
                    echo "Doing Tf Init"
                    sh "terraform init "       
                }
            }
        }   
        stage ('Terraform Plan') {
            when {
                not {
                    expression { BRANCH_NAME.equals('main') }
                }
            }

            steps  {
                script{    
                    echo "Doing Tf plan"                              
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKeyID', passwordVariable: 'accessKeySecret')]){
                        sh "terraform plan -var key_access=${accessKeyID}  -var key_secret=${accessKeySecret} -out mmjesu6.tfplan"
                        
                    }
                }
            }
        }   
        stage ('Terraform Apply') {
            when {
                anyOf {
                    expression { BRANCH_NAME.equals('main') }
                }
            }
            steps  {
                script{    
                    echo "Doing Tf apply"                              
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKeyID', passwordVariable: 'accessKeySecret')]){
                        sh "terraform apply -input=false -auto-approve -var key_access=${accessKeyID}  -var key_secret=${accessKeySecret}"
                        
                    }
                }
            }
        } 
        stage ('Checking Ansible '){
            steps{
                script{
                    echo "Checking Ansible script"
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKeyID', passwordVariable: 'accessKeySecret')]){
                        sh "ansible-playbook  retoCloudGitOps.yml --extra-vars='access_key_id=${accessKeyID}' --extra-vars='access_key_secret=${accessKeySecret}' --extra-vars='aws_region=eu-west-1' --check"
                        
                        
                    }
                }
            }
        }
        stage ('Ansible html provisioning'){
            when {
                anyOf {
                    expression { BRANCH_NAME.equals('main') }
                }
            }
            steps{
                script{
                    echo "Provisioning with Ansible"
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKeyID', passwordVariable: 'accessKeySecret')]){
                        sh "ansible-playbook  retoCloudGitOps.yml --extra-vars='access_key_id=${accessKeyID}' --extra-vars='access_key_secret=${accessKeySecret}' --extra-vars='aws_region=eu-west-1'"
                        
                    }
                }
            }
        }

        stage ('Terraform destroy') {
            when {
                anyOf {
                    expression { BRANCH_NAME.equals('main') }
                }
            }
            steps  {
                script{    
                    echo "Doing Tf apply"                              
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKeyID', passwordVariable: 'accessKeySecret')]){
                        sh "terraform destroy -input=false -auto-approve -var key_access=${accessKeyID}  -var key_secret=${accessKeySecret}"
                        
                    }
                }
            }
        } 
               
            
        stage ('Sonar Stage') {
            steps  {
                echo "Sonar Analysis"
                // withSonarQubeEnv ('SonarCloud') {
                //     sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar \
                //         -Dsonar.organization="mmjesu6" \
                //         -Dsonar.projectKey="retoCloudGitOps" \
                //         -Dsonar.branch.name="$BRANCH_NAME"'
                // }
            }
        }        
    }    
}

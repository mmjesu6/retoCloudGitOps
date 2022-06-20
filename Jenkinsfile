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
                not {
                    expression { BRANCH_NAME.equals('main') }
                }
            }
            steps  {
                script{    
                    echo "Doing Tf apply"                              
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKeyID', passwordVariable: 'accessKeySecret')]){
                        sh "terraform apply -input=false -auto-approve mmjesu6.tfplan -no-color"
                        
                    }
                }
            }
        } 
        stage ('Terraform destroy') {
            when {
                not {
                    expression { BRANCH_NAME.equals('main') }
                }
            }
            steps  {
                script{    
                    echo "Doing Tf apply"                              
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKeyID', passwordVariable: 'accessKeySecret')]){
                        sh "terraform destroy -input=false -auto-approve mmjesu6.tfplan -no-color"
                        
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

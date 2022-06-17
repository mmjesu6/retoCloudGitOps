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
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKey-ID', passwordVariable: 'accessKey-Secret')]){
                        assume_result = sh(script: "export AWS_ACCESS_KEY_ID=${accessKey-ID} && export AWS_SECRET_ACCESS_KEY=${accessKey-Secret}", returnStdout: true)
                        assume_values = assume_result.split("\t")
                        env.AWS_ACCESS_KEY_ID=assume_values[0]
                        env.AWS_SECRET_ACCESS_KEY=assume_values[1]
                        env.AWS_SESSION_TOKEN=assume_values[2].replaceAll("[\n]","")
                    }
                }
            }
        }   
        stage ('Terraform Plan') {
            environment{
                ACCOUNT_ID= "774430347359"
            }

            steps  {
                script{    
                    echo "Doing Tf plan"
                              
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKey-ID', passwordVariable: 'accessKey-Secret')]){
                        sh "terraform plan -var key_access=${accessKey-ID}  -var key_secret=${accessKey-Secret}"
                        
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

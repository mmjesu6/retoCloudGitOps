#!groovy

//@Library('github.com/ayudadigital/jenkins-pipeline-library@v6.3.0') _


pipeline {
    // agent any 
    agent { label 'docker' }
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
                    sh('aws configure set region eu-west-1')
                    withCredentials([usernamePassword(credentialsId: 'AWS-accessKey-MMJESU6retoCloudGitOps', usernameVariable: 'accessKey-ID', passwordVariable: 'accessKey-Secret')]){
                        assume_result = sh(script: "export AWS_ACCESS_KEY_ID=${accessKey-ID} && export AWS_SECRET_ACCESS_KEY=${accessKey-Secret} && aws sts assume-role --role-arn arn:aws:iam::${ACCOUNT_ID}:role/Jenkins --query '[Credentials.AccessKeyId,Credentials.SecretAccessKey,Credentials.SessionToken]' --output text", returnStdout: true)
                        assume_values = assume_result.split("\t")
                        env.AWS_ACCESS_KEY_ID=assume_values[0]
                        env.AWS_SECRET_ACCESS_KEY=assume_values[1]
                        env.AWS_SESSION_TOKEN=assume_values[2].replaceAll("[\n]","")
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

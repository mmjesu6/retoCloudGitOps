#!groovy

//@Library('github.com/ayudadigital/jenkins-pipeline-library@v6.3.0') _


pipeline {
    agent any 
    // agent { label 'docker' }
    options {
        
        timeout(time: 30, unit: 'MINUTES')
    }

    stages {
        stage ('First Stage') {
            steps  {
                echo "Starting"
            }
        }     
        stage ('Sonar Stage') {
            steps  {
                echo "Sonar Analysis"
                withSonarQubeEnv ('SonarCloud') {
                    sh 'mvn org.sonarsource.scanner.maven:sonar-maven-plugin:3.7.0.1746:sonar \
                        -Dsonar.organization="mmjesu6" \
                        -Dsonar.projectKey="retoCloudGitOps" \
                        -Dsonar.branch.name="$BRANCH_NAME"'
                }
            }
        }        
    }    
}

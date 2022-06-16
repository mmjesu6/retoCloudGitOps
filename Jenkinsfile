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
    }

    post {
        always {
        }
    }

    
}

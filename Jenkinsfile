pipeline {
    agent any
    tools {
        maven 'maven'
    }
    options {
    buildDiscarder(logRotator(numToKeepStr: '30', artifactNumToKeepStr: '30'))
    }
    stages{
        stage('Git checkout'){
            steps{
                git 'https://github.com/jedhammi/simple-maven-project.git'
                
            }
        }
        stage('Unit Testing'){
            steps{
                sh 'mvn test '
                
            }
        }

    }
}
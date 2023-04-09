pipeline {
    agent any
    tools {
        maven 'maven'
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
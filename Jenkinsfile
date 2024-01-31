pipeline {
    agent any
    tools {
        maven 'maven'
    }
   
    stages {
        stage('Unit Testing') {
            steps {
                git 'https://github.com/jedhammi/simple-maven-project.git'
                bat 'mvn test '
            }
        }
        stage('Build') {
            steps {
                bat 'mvn clean install'
            }
        }
    }
}

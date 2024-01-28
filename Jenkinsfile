pipeline {
    agent any
    tools {
        maven 'maven'
    }
    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '30'))
    }
    stages {
        stage('Unit Testing') {
            steps {
                git 'https://github.com/jedhammi/simple-maven-project.git'
                sh 'mvn test '
            }
        }
        stage('Build') {
            steps {
                sh 'mvn clean install'
            }
        }
    }
}

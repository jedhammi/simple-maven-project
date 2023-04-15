pipeline {
    agent any
    tools {
        maven 'maven'
    }
    options {
    buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '30'))
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
        stage('Integration Testing'){
            steps{
                sh 'mvn verify -DskipUnitTests'
                
            }
        }
        stage('Build'){
            steps{
                sh 'mvn clean install'
                
            }
        }
        stage('SonarQube'){
            steps{
                withSonarQubeEnv(credentialsId: 'sonar-user', installationName: 'sonar' ) {
                    sh 'mvn package sonar:sonar'

                }
                
            }
        }
        stage('Quality Gate'){
            steps{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-user'
                
            }
        }

    }
}

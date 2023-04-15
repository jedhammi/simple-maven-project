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

        stage('Upload Artifacts to Nexus'){
            steps{
                script {
                def artifactsVersion = readMavenPom file: 'pom.xml'
                nexusArtifactUploader artifacts: [
                    [artifactId: 'simple-maven-project',
                     classifier: '',
                      file: 'target/Uber.jar',
                       type: 'jar']
                       ],
                        credentialsId: 'nexus-user', 
                        groupId: 'com.example',
                         nexusUrl: '192.168.1.16:8081',
                          nexusVersion: 'nexus3',
                           protocol: 'http',
                            repository: 'simple-maven-project-release',
                             version: "${artifactsVersion.version}"
                        }                
            }
        }

    }
}

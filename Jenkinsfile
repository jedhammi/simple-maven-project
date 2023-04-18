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
                def nexusRepo = artifactsVersion.version.endsWith("SNAPSHOT") ? "simple-maven-project-snapshot" : "simple-maven-project-release" 
                echo "${nexusRepo}"
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
                            repository: "${nexusRepo}",
                             version: "${artifactsVersion.version}"  
                             echo "${artifactsVersion.version}"
                }                   
            }
        }
        stage ("Build Docker images"){            
            steps{
                script{
                    sh 'docker build -t jedhammi/maven-image:${BUILD_NUMBER} .'
                }
            }
        }
        stage("Push Docker Images") {
            steps {
                sh 'docker push $(docker images | head -2 | tail -1 | awk \'{print $1 ":" $2}\')'
                }
        }
    }
}

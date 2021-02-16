pipeline {
    agent any
    environment {
        DOCKER_HOST = 'tcp://127.0.0.1:2375'
        SONARQUBE_KEY = credentials('SONARQUBE_KEY')
        TAG = "${env.BUILD_NUMBER}"
    }
    stages {
        stage('Check out code') {
            steps {
                git 'https://github.com/shashank-ssriva/leave-management-system.git'
            }
        }
        stage('SonarQube analysis') {
            steps {
                echo ${SONARQUBE_KEY}
                sh "/usr/local/bin/envsubst < sonar-project.properties | /Users/admin/Downloads/sonar-scanner-4.5.0.2216-macosx/bin/sonar-scanner"
            }
        }
        stage('Build WAR artifact') {
            steps {
                sh '/usr/local/bin/mvn clean package'
            }
        }
        stage('Push Docker image to Nexus') {
            when {
                branch 'master'
            }
            steps {
                sh '/usr/local/bin/mvn dockerfile:push'
            }
        }
        stage('Deploy on K8s') {
            when {
                branch 'master'
            }
            steps {
                echo env.BUILD_NUMBER
                echo "${TAG}"
                sh "/usr/local/bin/envsubst < lms-resources.yaml | /usr/local/bin/kubectl apply -f - --namespace=lms"
            }
        }    
    }
}

pipeline {
    agent any

    tools {
        maven 'Maven 3.8.1' // This must match Jenkins' Maven tool name
        jdk 'Java 11'       // Match your installed JDK name in Jenkins
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/hninpwintcho/jenkine-pipeline-maven-demo.git'
            }
        }

        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Test') {
            steps {
                sh 'mvn test'
            }
        }
    }

    post {
        always {
            junit '**/target/surefire-reports/*.xml'
        }
    }
}

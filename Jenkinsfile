pipeline {
    agent {
        docker {
            image 'java_sdkman:latest'
            label 'docker'
            reuseNode true
        }
    }

    environment {
        JAVA_HOME = "/home/jenkins/.sdkman/candidates/java/current"
        PATH = "${env.JAVA_HOME}/bin:${env.PATH}"
    }

    stages {
        stage('Check Java Version') {
            steps {
                sh 'java -version'
            }
        }
    }
}



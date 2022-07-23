pipeline {
    agent {
        label 'slave1-label'
    }
    environment {
        PATH = "/opt/apache-maven-3.8.4/bin:$PATH"
        DOCKERHUB_CREDENTIALS=credentials('dockerhub')
    }
    stages {
        stage("Downloading code") {
            steps {
                echo "code cloning"
             git credentialsId: 'github-jenkins-key', url: 'git@github.com:asrafbd/JavaApp1.git'
            }
        }
        stage("Build code") {
         steps {
             echo "Code building"
             sh 'mvn clean package'
             
            }
          }
        stage("Build Docker image") {
         steps {
             echo "Docker image building"
         
             sh 'docker build -t java-app1:v1.$BUILD_ID .'
	     sh 'docker tag java-app1:v1.$BUILD_ID asrafbd/java-app1:latest'
	     sh 'docker tag java-app1:v1.$BUILD_ID asrafbd/java-app1:v1.$BUILD_ID'
             
            }
          }
          
        stage('Docker Hub Login') {

			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}
		
        stage('Push Image') {

			steps {
				sh "docker push asrafbd/java-app1:v1.$BUILD_ID"
				sh "docker push asrafbd/java-app1:latest"
			}
		}
	    stage('Cleaning up') { 
          steps { 
                sh "docker rmi asrafbd/java-app1:v1.$BUILD_ID" 
		sh "docker stop java-app1" 
		sh "docker rm java-app1" 
            }
        } 
       stage('Run Docker container on Jenkins Agent') {
             
            steps {
                sh "docker run -d -p 4030:8080 --name java-app1 asrafbd/java-app1:latest"
 
            }
        }
      }  
      
    post {
		always {
			sh 'docker logout'
		}
		
    }
}

    

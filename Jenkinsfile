pipeline {
	agent any

	tools {maven "mvn3.6.3"}
	
	stages {
		stage('Clean') {
			steps {
				sh 'mvn clean'	
			}
		}
		stage('Test') {
			steps {
				sh 'mvn test'
			}
		}
		stage('Compile') {
			steps {
				sh 'mvn compile'
			}
		}
		stage('Package') {
			steps {
				sh 'mvn package'
				
			}
			/*post {
				always {
					archiveArtifacts(artifacts: "${pom.artifactId}.war", fingerprint: true)
					
				}
			}*/
		}
		stage('Build Docker Image') {
			steps {
                script {
                    pom = readMavenPom file: pom.xml
                }
				sh "docker build -t weather-app:latest ."
			}
		}
		stage('Tag Docker Image') {
			steps {
				script { 
					pom = readMavenPom file: 'pom.xml'
				}
				sh "docker tag weather-app:latest qui3tst0rm/weather-app:${pom.version}"
			}
		}
		stage('Push Docker Image') {
			steps {
				withCredentials([usernamePassword(credentialsId: 'DOCKER_CREDS', passwordVariable: 'DOCKER_HUB_PWD', usernameVariable: 'DOCKER_HUB_USER')]) {
					sh 'docker login -u $DOCKER_HUB_USER -p $DOCKER_HUB_PWD'
					sh "docker push qui3tst0rm/addressbook:${pom.version}"
				}
			}
		}
	}
}

//app version from package.json
//cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g'

//app name from package.json
//cat package.json | grep name | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g'
/*{
    "scripts": {
        "postpublish" : "PACKAGE_VERSION=$(cat package.json | grep version | head -1 | awk -F: '{ print $2 }' | sed 's/[\",]//g' | tr -d '[[:space:]]') && git tag $PACKAGE_VERSION && git push --tags"
    }
}*/

//https://github.com/rajavasista/pipeline_project/blob/main/Jenkinsfile
//https://github.com/rajavasista/pipeline_project/blob/main/Dockerfile

pipeline {
    agent any
        environment {
                PROJECT_ID = 'usecase-2-412812'
                CLUSTER_NAME = 'cluster-1'
                LOCATION = 'us-west1'
                CREDENTIALS_ID = 'terraform'
        }

    stages {

            stage('terraform init') {
                steps {
                    script {
                        sh "terraform init"
                    }
                }
            }

            stage('terraform apply') {
                steps {
                    script {
                        sh "terraform apply -auto-approve"
                    }
                }
            }
            stage('Build Docker Image') {
                    steps {
                            script {
                                    sh "docker build -t 19980617/usecase2:${env.BUILD_ID} ."
                            }
                    }
            }
        
            stage("Push Docker Image") {
                    steps {
                            script {
                                    echo "Push Docker Image"
                                    withCredentials([string(credentialsId: 'Dockerhub', variable: 'Dockerhub')]) {
                                        sh "docker login -u 19980617 -p ${Dockerhub}"
                                        sh "docker push 19980617/usecase2:${env.BUILD_ID}"
                                    }
                            }
                    }
            }

            stage('Deploy to K8s') {
                    steps{
                                sh "sed -i 's/tagversion/${env.BUILD_ID}/g' deployment.yaml" 
                                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deployment.yaml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: true])
                            echo "Deployment Finished ..."
                    }
             }
       }
}

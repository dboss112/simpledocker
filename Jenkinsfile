node{
    
    stage('Starting Sonarqube server & Artifactory server ')
    {
        sh 'docker start sonarqube'
        sh 'docker start artifactory'
        sh 'sleep 1m'
    }
    
    stage('Checkout code')
    {
        git 'https://github.com/SwarupDey3/login.git'
    }
    
    stage('Sonarqube test')
    {
       
      sh 'mvn compile'
      
      script
      {
        withSonarQubeEnv(credentialsId: 'Sonarqube-1') {
              sh 'mvn sonar:sonar'
           }  
      }    
    }
    
    stage('Build')
    {
        sh 'mvn clean install'
        sh 'pwd'
    }
    
    stage('Jfrog Artifact archive')
    {
        script {
            rtUpload (
                 serverId: 'Artifactory',
                 spec: '''{
                      "files": [
                     {
                          "pattern": "target/*.war",
                          "target": "login-page-repo"
                     }
                ]
            }'''
           )
          }
        
    }
    
    stage('Docker QA Env')
    {
        sh 'docker-compose up -d --build'
                   
    }
    
     stage('Ansible Configurations')
    {
       withCredentials([file(credentialsId: 'PRIVATE_KEY', variable: 'key')]) {
        sh 'chmod 777 ./terraform'
        sh 'cp -f ${key} ./terraform/AwsKey.pem'
      }
        sh 'cp target/account-1.0-SNAPSHOT.war ./terraform/account-1.0-SNAPSHOT.war'
    }
    
    
    
    stage('Terraform Production Env')
    {
          def project_path_1 = "./terraform"
          dir(project_path_1){
            sh 'pwd'
            sh 'terraform init'
            sh 'terraform apply -var="access_key=***************" -var="secrate_key=***************" -input=false -auto-approve'
       }
     }
    
   
    stage('Destroy Env')
    {
        sh 'sleep 4m'
        
        def project_path_2 = "./terraform"
        dir(project_path_2){
           sh 'terraform destroy -var="access_key=**************" -var="secrate_key=**************" -input=false -auto-approve'
        }
       
        sh 'docker-compose down'
    }
    
}
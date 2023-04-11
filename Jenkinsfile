pipeline {
    agent any 
    
    stages {
        
        stage('git') {
            steps{
            git 'https://github.com/TDiazSouble/trivy-scan'
            }
        }

        stage('Build docker image') {
            steps {  
                sh 'docker build -t mhunn/buildtest:1.0.0'
            }
        }
    
        stage('Scan') {
            steps {
                // Install trivy
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/install.sh | sh -s -- -b /usr/local/bin v0.18.3'
                sh 'curl -sfL https://raw.githubusercontent.com/aquasecurity/trivy/main/contrib/html.tpl > html.tpl'

                // Scan all vuln levels
                sh 'mkdir -p reports'
                sh 'trivy image --format template --template "@html.tpl" -o reportTest.html '
                publishHTML target : [
                    allowMissing: true,
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportDir: 'reports',
                    reportFiles: 'nodjs-scan.html',
                    reportName: 'Trivy Scan',
                    reportTitles: 'Trivy Scan'
                ]   

                // Scan again and fail on CRITICAL vulns
                sh 'trivy filesystem --ignore-unfixed --vuln-type os,library --exit-code 1 --severity CRITICAL ./nodejs'

            }
        }
    }
}
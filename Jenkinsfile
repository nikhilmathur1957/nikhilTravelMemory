pipeline {
    agent any
    tools {
        'jenkins.plugins.shiningpanda.tools.PythonInstallation' 'Python3'
    }
    stages {
        stage('Diagnose Python') {
            steps {
                sh '''
                    echo "=== Python Diagnostic Information ==="
                    echo "PATH: $PATH"
                    echo "Working directory: $(pwd)"
                    echo "Python tool installation check:"
                    which python || echo "python not found"
                    which python3 || echo "python3 not found"
                    ls /usr/bin/python* 2>/dev/null || echo "No Python in /usr/bin/"
                    ls /usr/local/bin/python* 2>/dev/null || echo "No Python in /usr/local/bin/"
                    echo "=== End Diagnostic ==="
                '''
            }
        }
        stage('Build') {
            steps {
                dir('backend') {
                    sh '''
                        # Create virtual environment using absolute path
                        /usr/bin/python3 -m venv venv
                        
                        # Use the virtual environment's pip directly
                        ./venv/bin/pip install --upgrade pip
                        ./venv/bin/pip install -r requirements.txt
                    '''
                }
            }
        }
        stage('Test') {
            steps {
                dir('backend') {
                    sh '''
                        # Use the virtual environment's python directly
                        ./venv/bin/python -m pytest --junitxml=test-results.xml -v
                    '''
                }
            }
            post {
                always {
                    junit 'backend/test-results.xml'
                }
            }
        }
        stage('Deploy to Staging') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                dir('backend') {
                    sh 'echo "Deploying to staging environment..."'
                }
            }
        }
    }
    post {
        failure {
            emailext (
                subject: "FAILED: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                body: "Check console output at ${env.BUILD_URL}",
                to: "nikhilmathur1957@gmail.com"
            )
        }
        success {
            emailext (
                subject: "SUCCESS: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'",
                body: "Build successful!",
                to: "nikhilmathur1957@gmail.com"
            )
        }
    }
}

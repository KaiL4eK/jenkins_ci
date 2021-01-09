// Backuped pipeline

pipeline {
    agent {
        node {
            label 'android'
        }
    }

    stages {
        stage('VCS') {
            steps {
                git branch: 'master', credentialsId: 'git-server-key', url: 'git@bitbucket.org:windstranger/coiot.git'
            }
        }
        
        stage('Build') {
            steps {
                dir('app') {
                    sh "npm install"
                    sh "npm run build"
                }
            }
        }
        
        stage('Publish APK') {
            steps {
                sshPublisher(
                    publishers: [sshPublisherDesc(
                        configName: 'Internal SFTP', 
                        transfers: [
                            sshTransfer(
                                cleanRemote: false, 
                                excludes: '', 
                                execCommand: '', 
                                execTimeout: 120000, 
                                flatten: false, 
                                makeEmptyDirs: false, 
                                noDefaultExcludes: false, 
                                patternSeparator: '[, ]+', 
                                remoteDirectory: 'stable', 
                                remoteDirectorySDF: false, 
                                removePrefix: 'app/android/app/build/outputs/apk/release/', 
                                sourceFiles: 'app/android/app/build/outputs/apk/release/app-release.apk'
                            )
                        ], 
                        usePromotionTimestamp: false, 
                        useWorkspaceInPromotion: false, 
                        verbose: false
                    )]
                )
            }
        }
    }
}

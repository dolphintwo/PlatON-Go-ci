pipeline {
    agent any
    options {
        timeout(time: 15, unit: 'MINUTES')
        buildDiscarder logRotator(daysToKeepStr: '30', numToKeepStr: '10')
        timestamps()
        ansiColor('xterm')
    }
    parameters {
        text defaultValue: 'latest', description: 'build target', name: 'DOCKER_TAG'
        gitParameter name: 'BRANCH_TAG',
                     type: 'PT_BRANCH_TAG',
                     defaultValue: 'origin/master',
                     selectedValue: 'TOP',
                     sortMode: 'DESCENDING_SMART',
                     quickFilterEnabled: true,
                     listSize: '10'

    }
    stages {
        stage("Preparation") {
            steps {
                checkout([$class: 'GitSCM', 
                            branches: [[name: "${params.BRANCH_TAG}"]],
                            doGenerateSubmoduleConfigurations: false, 
                            extensions: [
                                [$class: 'SubmoduleOption', disableSubmodules: false, parentCredentials: false, recursiveSubmodules: true, trackingSubmodules: false]
                            ], 
                            gitTool: 'Default',
                            submoduleCfg: [], 
                            userRemoteConfigs: [[url: 'https://github.com/PlatONnetwork/PlatON-Go.git']]
                        ])
            }
        }
        stage("Build") {
            steps{
                sh """
                    git checkout -b ${params.BRANCH_TAG}
                    curl https://raw.githubusercontent.com/dolphintwo/PlatON-Go-ci/master/Dockerfile > ./Dockerfile
                    docker build -t dolphintwo/platon-go:${DOCKER_TAG} .
                """
            }
        }
        stage("Test") {
            steps{
                sh """
                    echo "====镜像内platon版本===="
                    docker run --rm dolphintwo/platon-go:${DOCKER_TAG} version
                """
            }
        }
        stage("Finish Job"){
            steps{
                buildDescription "Build: ${params.BRANCH_TAG}"
                buildName "#${BUILD_NUMBER} TAG=${DOCKER_TAG}"
            }
        }
    }
}
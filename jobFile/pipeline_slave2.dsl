pipelineJob('pipeline_slave2') {
    concurrentBuild(true)
    description('Pipeline Slave2テスト')
    keepDependencies(false)
    properties {
        rebuild {
            autoRebuild(false)
            rebuildDisabled(false)
        }
    }
    parameters {
        stringParam('str_param1','0','必要か否か必要:1不要:0')
        stringParam('str_param2','','対象のチームID')
    }
    logRotator {
        daysToKeep(-1)
        numToKeep(30)
        artifactDaysToKeep(-1)
        artifactNumToKeep(-1)
    }
    authenticationToken('nakasin52')
    definition {
        cps {
            script("""
                node {
                    stage('test'){
                        echo 'pipeline_slave2　success'
                    }
                }
            """.stripIndent()) 
            sandbox()
        }
    }
}
pipelineJob('pipeline_master') {
    concurrentBuild(true)
    description('pipeline-coreのテスト　トップ')
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
            def SlackChannel = 'general' //Todo
            def ResultCheck = true;

            stage ('slave_Pipeline check') {

                parallel(
                    "pipeline_slave1": {
                        try{
                            build job: 'Pipeline_slave1'
                        } catch(Exception e) {
                            currentBuild.result = 'FAILURE'
                        }
                    },
                    "pipeline_slave2": {
                        try{
                            build job: 'Pipeline_slave2'
                        } catch(Exception e) {
                            currentBuild.result = 'FAILURE'
                        }
                    },
                )
            }

        }
            """.stripIndent()) 
            sandbox()
        }
    }
}
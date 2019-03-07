pipelineJob('pipeline_github') {
    concurrentBuild(true)
    description('pipelineジョブの確認')
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
    triggers {
        cron('H/20 * * * *') 
    }
    definition {
        cpsScm {
            scriptPath 'pipeline/jenkinsfile_1' //github上のスクリプトソース指定
            scm {
                git {
                    remote { url 'https://github.com/biz-nakashima001/jcasc.git' } //対象githubリポジトリ
                    branch '*/master'
                }
            }
        }
    }
}
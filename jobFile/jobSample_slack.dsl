job('jobSample_slack') {
    concurrentBuild(true)
    description('slackチェック')
    keepDependencies(false)
    properties {
        rebuild {
            autoRebuild(false) //Rebuilds job without asking for parameters. Defaults to false.
            rebuildDisabled(false) //Disables job rebuilding. Defaults to false.
        }
    }
    parameters {
        stringParam('target_team_id','','対象のチームID')
    }
    logRotator {
        daysToKeep(-1)
        numToKeep(30)
        artifactDaysToKeep(-1)
        artifactNumToKeep(-1)
    }
    authenticationToken('nakasin52')
    wrappers {
        timestamps() //Adds timestamps to the console log.
        buildUserVars() //Adds a number of environment variables with information about the current user.
    }
    configure { project ->
        project / publishers << 'jenkins.plugins.slack.SlackNotifier' {
        startNotification(true)
        notifySuccess(true)
        notifyAborted(true)
        notifyNotBuilt(true)
        notifyUnstable(true)
        notifyRegression(true)
        notifyFailure(true)
        notifyBackToNormal(false)
        notifyRepeatedFailure(false)
        includeTestSummary(false)
        includeFailedTests(false)
        commitInfoChoice("NONE")
        includeCustomMessage(true)
        customMessage("env:$ENV user:$BUILD_USER")
        }
    }
    configure { project ->
        project / 'properties' / 'com.chikli.hudson.plugin.naginator.NaginatorOptOutProperty' { //This plugin allows you to automatically reschedule a build after a build failure
            'optOut'(false)
        }
    }

    steps  {
        shell("echo jenkinsSample_2;echo 'slackチェック'; echo success!")
    }
}
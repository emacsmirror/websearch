pipeline
{
    agent any

    environment
    {
        DO_NOT_TRACK = "true"
        EARTHLY_DISABLE_ANALYTICS = "true"
    }

    stages
    {
        stage("checkout")
        {
            steps
            {
                checkout scm
            }
        }

        stage("refresh")
        {
            options
            {
                timeout(time: 4, unit: "MINUTES")
            }

            steps
            {
                sh "./code/integration/ci_refresh.sh"
            }
        }

        stage("prepare")
        {
            when
            {
                anyOf
                {
                    changeset "Earthfile"
                    changeset "Jenkinsfile"
                    changeset "code/source/v3/**"
                }
            }

            options
            {
                timeout(time: 8, unit: "MINUTES")
            }

            steps
            {
                sh "earthly +prepare-v3"
            }
        }

        stage("build")
        {
            when
            {
                anyOf
                {
                    changeset "Earthfile"
                    changeset "Jenkinsfile"
                    changeset "code/source/v3/**"
                }
            }

            options
            {
                timeout(time: 8, unit: "MINUTES")
            }

            steps
            {
                sh "earthly +build-v3"
            }
        }

        stage("tests")
        {
            when
            {
                anyOf
                {
                    changeset "Earthfile"
                    changeset "Jenkinsfile"
                    changeset "code/source/v3/**"
                }
            }

            options
            {
                timeout(time: 16, unit: "MINUTES")
            }

            parallel
            {
                stage("test")
                {
                    steps
                    {
                        catchError(buildResult: "SUCCESS", stageResult: "FAILURE")
                        {
                            sh "earthly +test-v3"
                        }
                    }
                }

                stage("lint")
                {
                    steps
                    {
                        catchError(buildResult: "SUCCESS", stageResult: "FAILURE")
                        {
                            sh "earthly +lint-v3"
                        }
                    }
                }
            }
        }
    }
}

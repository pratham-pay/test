node {
    def ams

    stage('Clone repository') {
        /* Let's make sure we have the repository cloned to our workspace */
        checkout scm
    }

//     stage('Run Tests') {
//         sh "./startup_scripts/run_tests.sh"
//     }

    stage('Build image') {
        /* This builds the actual image; synonymous to
         * docker build on the command line */
        ams = docker.build("paysense/ams-nbfc", "-f Dockerfile ./")
    }

    stage('Push image') {
        /* Finally, we'll push the images with two tags:
         * First, the incremental build number from Jenkins
         * Second, the 'latest' tag.
         * Pushing multiple tags is cheap, as all the layers are reused. */
        docker.withRegistry('https://registry.hub.docker.com', 'docker-paysense-credentials') {
            ams.push("${env.BUILD_NUMBER}-${env.BRANCH_NAME}")
            ams.push("latest-${env.BRANCH_NAME}")
        }
        sh 'docker rmi -f $(docker images --filter "reference=*/paysense/ams-nbfc:*-$BRANCH_NAME" -q | tail -n +4) || echo "No images to remove"'
        sh 'docker rmi $(docker images -f "dangling=true" -q) || echo "No Dangling images to remove"'
        sh 'If [ $BRANCH_NAME == master ]; then echo “Branch name is “master”; else echo “Branch name is “sandbox”; fi'
    }
}

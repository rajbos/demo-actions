module.exports = ({github, context, title}) => {
    console.log(`issue title ${title}`)
    if (title.includes('💩')) {
        // add a label to the issue

        github.rest.issues.addLabels({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            labels: ['poop']
        })
        
        console.log(`labeled the isse`)
    }
    else {
        console.log(`issue does not contain 💩`)
    }


    if (title.includes('bug')) {
        // add a label to the issue

        github.rest.issues.addLabels({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            labels: ['bug']
        })
        
        console.log(`labeled the isse`)
    }
    else {
        console.log(`issue does not contain 💩`)
    }
    return true
}
module.exports = ({github, context, title}) => {
    console.log(`issue title ${title}`)
    if (title.includes('💩')) {
        // add a comment and close the issue
        github.rest.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: 'Greetings, this issue has been closed because it contains 💩'
        })
        console.log(`commented on issue`)

        github.rest.issues.update({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            state: 'closed'
        })
        console.log(`closed the issue`)
    }
    else {
        console.log(`issue does not contain 💩`)
    }
    return true
}
module.exports = async ({github, context, owner, repo, workflow}) => {
    
    console.log(`beginning on workflow [${workflow}]`);
    const workflowParts = workflow.split('/')
    const workflow_id = workflowParts[workflowParts.length-1]
    
    console.log(`Running on repo [${owner}/${repo}] with workflow_id: [${workflow_id}]`)
          
    try {
        console.log(`Start of the try call`)

        const runs = await github.rest.actions.getWorkflow({
            owner,
            repo,
            workflow_id
        });
        console.log(``)
        let runObj = JSON.stringify(runs)
        console.log(`Runs: ${runObj}`)
        console.log(``)
        
        const runs2 = await github.rest.actions.listWorkflowRunsForRepo({
                owner,
                repo
            },
            (response) => console.log(`Response: ${JSON.stringify(response)}`)
        )        
        console.log(`Runs2: ${JSON.stringify(runs2)}`)

        try {
            const response = await github.request(
                "GET /repos/{owner}/{repo}/actions/runs",
                {owner, repo}
            )        
            console.log(`Response: ${JSON.stringify(response)}`)
        }
        catch(err) { 
            console.log(`err: ${err}`)
        }

        // const runs = await github.rest.actions.listWorkflowRuns({
        //     owner,
        //     repo,
        //     workflow_id
        // });
                    
        
        
    } catch (error) {
        console.log(`error: ${error}`)
    }

    console.log(`The End`)

  }

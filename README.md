<div align="center">
    <h1>Github Actions Releaser</h1>
</div>

<p>A Docker GitHub Action that runs Atlassian CLI (ACLI) to search workitems (issues/jira tickets) and returns the results.</p>

# Inputs

| Key | Description | Required | Type |
| --- | ----------- | -------- | ---- |
| `JIRA_API_TOKEN` | The Jira Token | **TRUE** | **SECRET** |
| `JIRA_BASE_URL` | Site of the Atlassian instance is required for authentication | **TRUE** | String |
| `JIRA_AUTH_EMAIL` | User email is required for authentication | **TRUE** | String |
| `JIRA_WORKITEM_KEY` | Work item to search | **TRUE** | String |

# Usage (in a workflow):

```yaml
- name: Get JIRA Workitem
  id: jira-search
  uses: GuilhermeCarra/github-actions-jira-workitem-searcher
  with:
    JIRA_API_TOKEN: ${{ secrets.JIRA_API_TOKEN }}
    JIRA_AUTH_EMAIL: ${{ secrets.JIRA_AUTH_EMAIL }}
    JIRA_BASE_URL: 'your-instance.atlassian.net'
    JIRA_WORKITEM_KEY: 'ZZM-3610'
- name: Use the results
  run: echo "Results: ${{ steps.jira-search.outputs.results }}"
```
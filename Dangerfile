# Always require a description of work
if github.pr_body.length < 5
  fail 'Please provide a summary in the Pull Request description'
end

# Post sentiment analysis to the pull request
sentiment.post_analysis

# Send analysis table to Discord
discord.notify(content: sentiment.formatted_analysis)

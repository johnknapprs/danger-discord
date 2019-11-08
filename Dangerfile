# Always require a description of work
if github.pr_body.length < 5
  warn 'Please provide a summary in the Pull Request description'
end

# Post to the pull request
sentiment.post_analysis

# Send a message in Discord
discord.notify(
  content: ['Sentiment Analysis of PR', sentiment.formatted_analysis].join("\n")
)

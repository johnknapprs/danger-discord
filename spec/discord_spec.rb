require File.expand_path('spec_helper', __dir__)

module Danger
  describe Danger::DangerDiscord do
    it 'should be a plugin' do
      expect(Danger::DangerDiscord.new(nil)).to be_a Danger::Plugin
    end

    #
    # You should test your custom attributes and methods here
    #
    describe 'with Dangerfile' do
      before do
        @dangerfile = testing_dangerfile
        @my_plugin = @dangerfile.discord

        # mock the PR data
        # you can then use this, eg. github.pr_author, later in the spec
        json = File.read(File.dirname(__FILE__) + '/support/fixtures/github_pr.json')
        allow(@my_plugin.github).to receive(:pr_json).and_return(json)
      end

      # Some examples for writing tests
      # You should replace these with your own.

      it 'Checks for discord webhook url' do
        expect(ENV['DISCORD_WEBHOOK_URL']).to include('discordapp.com/api/webhooks/')
      end
    end
  end
end

module Danger
  # This is your plugin class. Any attributes or methods you expose here will
  # be available from within your Dangerfile.
  #
  # To be published on the Danger plugins site, you will need to have
  # the public interface documented. Danger uses [YARD](http://yardoc.org/)
  # for generating documentation from your plugin source, and you can verify
  # by running `danger plugins lint` or `bundle exec rake spec`.
  #
  # You should replace these comments with a public description of your library.
  #
  # @example Ensure people are well warned about merging on Mondays
  #
  #          my_plugin.warn_on_mondays
  #
  # @see  John Knapp/danger-discord
  # @tags monday, weekends, time, rattata
  #
  class DangerDiscord < Plugin
    # API token to authenticate with Discord API
    #
    # @return [String]
    attr_accessor :api_token

    def initialize(dangerfile)
      super(dangerfile)

      @api_token = ENV['DISCORD_WEBHOOK_URL'] ||= raise('Unable to find DISCORD_WEBHOOK_URL')
    end

    # Notify Discord Channel
    #
    # @param   [String] text
    #          text message posted to discord, defaults to nil.
    #          if nil, this method post danger reports to discord.
    # @param   [Hash] **opts
    # @return [void]
    def notify(channel: '#general', content: nil, **opts)
      require 'discordrb/webhooks'

      client = Discordrb::Webhooks::Client.new(url: @api_token)

      client.execute { |builder| builder.content = content }
    end
  end
end

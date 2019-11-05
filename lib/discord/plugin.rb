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

      @api_token = ENV['DISCORD_WEBHOOK_URL']
    end

    # Notify Discord Channel
    #
    # @param   [String] channel
    #          It is channel to be notified, defaults to '#general'
    # @param   [String] text
    #          text message posted to slack, defaults to nil.
    #          if nil, this method post danger reports to slack.
    # @param   [Hash] **opts
    # @return [void]
    def notify(channel: '#general', text: nil, **opts)
      # webhook url implimentation
      require 'discordrb/webhooks'

      client = Discordrb::Webhooks::Client.new(url: @api_token)

      client.execute do |builder|
        builder.content = text
        builder.add_embed do |embed|
          embed.title = 'This is an Embed Title'
          embed.description = 'Here is an Embed description'
          embed.timestamp = Time.now
        end
      end

      # attachments = text.nil? ? report : []
      # text ||= '<http://danger.systems/|Danger> reports'
      # @conn.post do |req|
      #   req.url 'chat.postMessage'
      #   req.params = {
      #     token: @api_token,
      #     channel: channel,
      #     text: text,
      #     attachments: attachments.to_json,
      #     link_names: 1,
      #     **opts
      #   }
      # end
    end
  end
end

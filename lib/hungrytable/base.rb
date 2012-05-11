module Hungrytable
  class Base
    def validate_environment_variables
      raise "Please set the environment variable OT_OAUTH_KEY to your OpenTable OAuth Table." unless ENV['OT_OAUTH_KEY']
      raise "Please set the environment variable OT_OAUTH_SECRET to your OpenTable OAuth Secret Key." unless ENV['OT_OAUTH_SECRET']
      raise "Please set the environment variable OT_PARTNER_ID to your OpentTable Partner ID." unless ENV['OT_PARTNER_ID']
    end

    def parse_uri_option(option_name, options)
      val = options[option_name.to_sym]
      raise "Missing required option: #{option_name}" if val.nil?
      if val.is_a?(String)
        val = CGI.escape(val).gsub(/[+]/, '%20')
      end
      instance_variable_set("@#{option_name}", val)
    end

    def parse_uri_options(*option_names, options)
      option_names.each { |option_name| parse_uri_option(option_name, options) }
    end

    def parse_json(string)
      JSON.parse(string)
    end
  end
end

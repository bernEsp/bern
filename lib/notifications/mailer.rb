module Notifications
  require 'net/smtp'

  class Mailer
    attr_accessor :smtp_server, :smtp_port, :smtp_domain
    attr_reader :smtp_username

    def initialize(smtp_server:,smtp_port:, smtp_domain:, smtp_username:, smtp_password:)
      @smtp_server = smtp_server
      @smtp_port = smtp_port
      @smtp_domain = smtp_domain
      @smtp_username = smtp_username
      @smtp_password = smtp_password
      @smtp_server = Net::SMTP.new(@smtp_server, @smtp_port)
    end

    def send(host_email:, delivery_email:)
      @smtp_server.start(@smtp_domain, @smtp_username, @smtp_password, :plain) do |smtp|
        smtp.enable_starttls
        smtp.open_message_stream(host_email, delivery_email) do |message|
          message.puts "From: #{host_email}"
          message.puts "To: #{delivery_email}"
          message.puts 'Subject: I have just logged your hours in your system.Atte Bern'
          message.puts
          message.puts 'You have just logged your hours tomorrow you are going to receive a new message, if you want to deactivate your bot go to your server'
        end
        smtp.finish
      end
    end

  end
end

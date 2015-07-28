require 'minitest/autorun'
require './lib/notifications/mailer.rb'
require 'net/smtp'

class MailerTest < Minitest::Test

  SmtpStruct = Struct.new(:smtp_server, :smtp_port) do
    def initialize(*)
      @smtp_server = self.smtp_server
      @smtp_port = self.smtp_port
    end

    def start(domain, username, password, type=plain)
      self
    end

    def open_message_stream
      'done'
    end

    def finish
      true
    end
  end

  def setup
    @smtp_stub = SmtpStruct.new('localhost', '25')
    @custom_mailer = Notifications::Mailer.new(smtp_server: 'test', smtp_port: '25', smtp_domain: 'localhost', smtp_username: 'tester', smtp_password: 'test')
  end

  def test_should_return_smtp_object
    Net::SMTP.stub :new, @smtp_stub do
      @mailer = Notifications::Mailer.new(smtp_server: 'test', smtp_port: '25', smtp_domain: 'localhost', smtp_username: 'tester', smtp_password: 'test')
      assert_equal @smtp_stub, @mailer.send(host_email:'test@example.com', delivery_email: 'test2@example.com')
    end
  end

  def test_smtp_server_can_set_after_initialize
    @custom_mailer.smtp_server = 'test'
    assert_equal 'test', @custom_mailer.smtp_server
  end

  def test_smtp_port_can_set_after_initialize
    @custom_mailer.smtp_port = 22
    assert_equal 22, @custom_mailer.smtp_port
  end

  def test_smtp_domain_can_set_after_initialize
    @custom_mailer.smtp_domain = 'test'
    assert_equal 'test', @custom_mailer.smtp_domain
  end

  def test_mailer_should_not_response_to_username_setter
    refute_respond_to @custom_mailer, :smtp_username=
  end

  def test_mailer_should_not_response_to_password_setter
    refute_respond_to @custom_mailer, :smtp_password=
  end

  def test_mailer_should_not_response_to_password_getter
    refute_respond_to @custom_mailer, :smtp_password
  end

  def test_mailer_should_response_to_username
    assert_respond_to @custom_mailer, :smtp_username
  end
end

require 'minitest/autorun'
require './lib/cloud_logger/redmine.rb'
require 'rubygems'
require 'excon'

class RedmineTest < Minitest::Test
  def setup
    Excon.defaults[:mock] = true
    url = 'http://apitest.example.com'
    headers = {'Content-Type' => 'application/json',
      'X-Redmine-API-Key' => ENV['THIRD_PARTY_KEY']
    }
    Excon.stub({}, {:body => 'body', :status => 200})
    @redmine_logger = CloudLogger::Redmine.new(url:'http://test.com')
  end

  def test_initialize_headers_include_content_type_json
    assert_equal 'application/json', @redmine_logger.headers.fetch('Content-Type')
  end

  def test_log_excon_success
    assert_equal 200, @redmine_logger.log_hours.status
  end

  def test_log_excon_failed
    Excon.stub({}, {:body => 'body', :status => 400})
    assert_equal 400, @redmine_logger.log_hours.status
  end

  def test_log_hours_set_headers
    @redmine_logger.log_hours(body: 'test', custom_headers: {'test' => 'test'})
    custom_headers = {'Content-Type' => 'application/json', 'test' => 'test'}
    assert_equal custom_headers, @redmine_logger.headers
  end

  def test_headers_setter_should_add_custom_headers
    @redmine_logger.headers = {'test' => 'test'}
    custom_headers = {'Content-Type' => 'application/json', 'test' => 'test'}
    assert_equal custom_headers, @redmine_logger.headers
  end

  def test_custom_headers_should_be_a_hash_or_know_how_to_be
    assert_raises(NoMethodError){@redmine_logger.headers = 'test'}
  end

  def test_set_body
    assert_equal 'test', @redmine_logger.body = 'test'
  end

  def test_log_hours_with_custom_headers
    @redmine_logger.headers = {'test' => 'test'}
    assert_equal 200, @redmine_logger.log_hours.status
  end
end

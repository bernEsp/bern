require_relative 'redmine_log_cli'
require 'date'
require './lib/cloud_logger/redmine'

class BernRedmineLogError < NameError 
end

class RedmineLogHour
  attr_reader :third_party_key, :comment, :holidays,
    :third_party_url, :issue_id, :hours, :activity_id, :spent_on

  def initialize(options)
    args = RedmineLogCli.parse(options)
    @comment = args.comment 
    @holidays = args.holidays
    @third_party_key = args.third_party_key
    @third_party_url = args.third_party_url
    @issue_id = args.issue_id
    @hours = args.hours
    @activity_id = args.activity_id
    @date = args.date || DateTime.now
    @spent_on = @date.strftime('%F')
    @number_of_day = @date.strftime('%u').to_i
  end

  def run
    begin
      if @number_of_day < 6 && holidays.none? {|holiday| holiday == spent_on }
        redmine = CloudLogger::Redmine.new(url: third_party_url)
        response = redmine.log_hours(body: body, custom_headers: headers)
        if response.status == 200 || response.status == 201
          p  "Bern logged Redmine time successfully: issue_id => #{issue_id}, spent_on => #{spent_on}"
        else
          raise BernRedmineLogError
        end
      end
    rescue BernRedmineLogError, NoMethodError
        puts 'An error ocurred, please review your bern.env file  env variables and that third party key still valid'
        puts ''
        puts '<==================***TIP***========================================>'
        puts 'Tip set your environment variables with bern set_env -e name -v value'
    end
  end

  private
    def headers
      { 'X-Redmine-API-Key' => third_party_key }
    end

    def body
      {
        "time_entry" => {
          "issue_id" => issue_id,
          "spent_on" => spent_on,
          "hours"=> hours,
          "activity_id"=> activity_id,
          "comments" => comment
        }
      }
    end

end

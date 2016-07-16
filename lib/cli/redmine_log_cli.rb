require 'optparse'
Options = Struct.new(:comment, :activity_id, :hours, :issue_id, :third_party_key, :third_party_url, :date, :holidays)

class RedmineLogCli
  def self.parse(options)
    bern_env_vars = self.load_environment
    args = Options.new('bern')
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: redmine_log_hour [options]'
      # read bern dot file or environment variables
      args.activity_id = bern_env_vars.fetch('ACTIVITY_ID', opts.environment('activity_id')&.first)
      args.hours = bern_env_vars.fetch('HOURS', opts.environment('hours')&.first)
      args.issue_id = bern_env_vars.fetch('ISSUE_ID', opts.environment('issue_id')&.first)
      args.third_party_key = bern_env_vars.fetch('THIRD_PARTY_KEY', opts.environment('third_party_key')&.first)
      args.third_party_url = bern_env_vars.fetch('THIRD_PARTY_URL', opts.environment('third_party_url')&.first)
      args.holidays = bern_env_vars.fetch('HOLIDAYS', opts.environment('holidays')&.first)&.split(',')


      opts.on('-cCOMMENT', '--comment=COMMENT', 'Comment to appear in the time entry') do |n|
        args.comment = n
      end

      opts.on('-dDate', '--date=DATE_SPENT_ON', 'set a custom date to log time yyyy-mm-dd') do |n|
          args.date = Date.parse(n)
      end

      opts.on('-h', '--help', 'Print this help') do
        puts 'Bern needs the list of environment variables describe in the README'
        puts 'Bern prefers env variable to keep secret your information'
        puts opts
        exit
      end
    end
    
    opt_parser.parse!(options)
    return args
  end

  def self.load_environment
    File.read('./.bern.env').gsub("\r\n","\n").split("\n").inject({}) do |bern_var, line|
      r = line.match /\[(?<name>\w+)\]=(?<value>.*)\z/
      if r
        key = r[:name]
        val = r[:value]
        case val
        when /\A'(.*)\z/ then bern_var[key] = $1
        when /\A"(.*)\z/ then bern_var[key] = $1
        else bern_var[key] = val
        end
      end
      bern_var
    end
  end
end

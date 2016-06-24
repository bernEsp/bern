require 'optparse'
OptionsEnv = Struct.new(:name, :value)

class SetEnvCli
  def self.parse(options)
    args = OptionsEnv.new('env')
    opt_parser = OptionParser.new do |opts|
      opts.banner = 'Usage: set_env [options]'

      opts.on('-eENVIRONMENT', '--environement=ENVIRONEMENT', 'Environment variable name') do |n|
        args.name = n
      end

      opts.on('-vVALUE', '--value=VALUE', 'Environmenti variable  value') do |n|
        args.value = n
      end

      opts.on('-h', '--help', 'Print this help') do 
        puts opts
        exit
      end

    end
    opt_parser.parse!(options)
    return args
  end
end

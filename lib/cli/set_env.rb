require_relative 'set_env_cli'

class SetEnv
  attr_reader :name, :value

  def initialize(options)
    args = SetEnvCli.parse(options)
    @name = args.name.upcase
    @value = args.value
    @file = './.bern.env'
  end

  def run
    system <<-CMD
    echo 'ENV[#{name}]=#{value}' >> #{@file}
    CMD
  end
end

require 'comodule'

namespace :comodule do

  def platform
    return @platform if @platform
    platform_name = @args && @args.platform_name
    env = {}

    ['project_root', 'db_host', 'db_password', 'RAILS_ENV', 'env'].each do |env_name|
      env[env_name.to_sym] = ENV[env_name] if ENV[env_name]
    end

    @platform = Comodule::Deployment::Platform.new(platform_name, env)
  end

  task :variables do |cmd, args|
    @args = args
  end

  namespace :platform do

    desc 'Create necessary directories and files for the platform'
    task :create, [:platform_name] => [:environment, :variables] do
      platform.create
    end
  end
end
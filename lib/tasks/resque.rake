require 'resque/tasks'
require 'resque/scheduler/tasks'
require 'resque/pool/tasks'

task 'resque:setup' => :environment do
    Resque.schedule = YAML.load_file('config/resque-schedule.yml')
end

task "resque:pool:setup" do
    # close any sockets or files in pool manager
    ActiveRecord::Base.connection.disconnect!
    # and re-open them in the resque worker parent
    Resque::Pool.after_prefork do |job|
        ActiveRecord::Base.establish_connection
        Resque.redis.client.reconnect
        # Dir.glob("#{ Rails.root }/app/models/**/**.rb").each{|fn| require_dependency File.basename(fn, '.rb') rescue nil }
    end
end

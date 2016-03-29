namespace :api do
  desc 'API Routes'
  task :routes => :environment do
    BetterDoctor::Base.routes.each do |api|
      if api.route_method
        method      = api.route_method.ljust(10)
        path        = api.route_path.ljust(50)
        description = api.route_description

        puts "\t#{method} #{path} # #{description}"
      end
    end
  end
end

# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization
a# rails-api-example

Rails Project using Rails-API

## Serializing API Output


```ruby
gem 'active_model_serializers'
```

And then make initializer file

    # config/initializers/active_model_serializer.rb
    ActiveModel::Serializer.config.adapter = ActiveModel::Serializer::Adapter::JsonApi



## Enabling CORS 

 
```ruby
gem 'rack-cors'
```

```ruby
module MyApp
  class Application < Rails::Application

    # ...

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

  end
end

```

## Rate Limiting and Throttling

```ruby
gem 'rack-attack'
```

```ruby
module MyApp
  class Application < Rails::Application

    # ...

    config.middleware.use Rack::Attack

  end
end
```
config/initializers/rack_attack.rb

```ruby
class Rack::Attack

  # `Rack::Attack` is configured to use the `Rails.cache` value by default,
  # but you can override that by setting the `Rack::Attack.cache.store` value
  Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new

  # Allow all local traffic
  whitelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Allow an IP address to make 5 requests every 5 seconds
  throttle('req/ip', limit: 5, period: 5) do |req|
    req.ip
  end

  # Send the following response to throttled clients
  self.throttled_response = ->(env) {
    retry_after = (env['rack.attack.match_data'] || {})[:period]
    [
      429,
      {'Content-Type' => 'application/json', 'Retry-After' => retry_after.to_s},
      [{error: "Throttle limit reached. Retry later."}.to_json]
    ]
  }
end
```

## Versioning API

    app/controllers/
    |-- api
      |-- v1
          |`-- api_controller.rb
          |`-- users_controller.rb
      |-- v2
          |`-- api_controller.rb
          |`-- users_controller.rb
    |`-- application_controller.rb



`v1` -> id, name, gender, phone
`v2` -> id, name, gender, gender_str, phone

app/controllers/api/v1/users_controller.rb 
``` ruby
module Api::V1
  class UsersController < ApiController
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index

      @users = User.page(1).per(20)
      @users = User.page(params[:page][:number]).per(params[:page][:size]) if params[:page].present?

      render json: @users, each_serializer: V1UserSerializer
    end 
    ......
  end
```

app/serializers/v1_user_serializer.rb
```ruby
class V1UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :phone
end
```


app/controllers/api/v2/users_controller.rb 
``` ruby
module Api::V2
  class UsersController < ApiController
    before_action :set_user, only: [:show, :update, :destroy]

    # GET /users
    def index

      @users = User.page(1).per(20)
      @users = User.page(params[:page][:number]).per(params[:page][:size]) if params[:page].present?

      render json: @users
    end 
    ......
  end
```

app/serializers/user_serializer.rb 
```ruby
class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :gender, :gender_str, :phone
    
  def gender_str
    return "male" if object.gender == 1
    return "female" if object.gender == 2
      
  end
end  
```



## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request


## License

The gem is available as open source under the terms of the [MIT
License](http://opensource.org/licenses/MIT).





* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

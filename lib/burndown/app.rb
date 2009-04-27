module Burndown
  class App < Sinatra::Default
    set :root,     File.dirname(__FILE__) + "/../.."
    set :app_file, __FILE__
    enable :sessions

    include Burndown
    include Burndown::Helpers
    
    get "/" do
      show :index
    end
    
    get "/project" do
      show :project
    end
    
    get "/timeline" do
      @start_date = Date.new(2009, 3, 8)
      @due_date = Date.new(2009, 4, 30)
      show :timeline
    end
    
    get "/setup" do
      @tokens = [ OpenStruct.new({:note => "All Projects",      :token => "c52afafd297721ec4896956e4f29fcf0fedeef44"}),
                  OpenStruct.new({:note => "Read Only Tender",  :token => "5df6f2ewc52afafd297721ec4896956e4f29fcf0"})]
      show :setup
    end
    
    # Validates a token (AJAX method)
    post "/token_validity" do
      @token = Token.new(params[:token])
      status (@token.valid_lighthouse_token? ? 200 : 500)
    end
    
    # Creates a new token (AJAX method)
    post "/token" do
      @token = Token.new(params[:token])
      if @token.save
        status 200
      else
        status 500
      end
    end
    
  end
end
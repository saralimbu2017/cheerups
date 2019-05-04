require 'sinatra'
require 'sinatra/reloader'
require 'pry'
require_relative 'db_config'
require_relative 'models/activity'
require_relative 'models/user'
require_relative 'models/category'
require_relative 'models/like'
require_relative 'models/comment'
require_relative 'models/quote'
require_relative 'models/image'
require 'bcrypt'
enable :sessions

helpers do
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !!current_user ##truthy
  end
end

after do
  ActiveRecord::Base.connection.close
end

get '/' do
  erb :index
end

get '/activities' do
  @activities = Activity.all
  
  erb :activities
  # erb :test
end

post '/activities/new' do
  @activities = Activity.where(user_id: session[:user_id])

  erb :new
end

get '/activities/:id' do
  @activity = Activity.find(params[:id])
  erb :show
end

get '/activities/:id/edit' do
  @activity = Activity.find(params[:id]) ##any other than id use where
  # @activity.house_number = {params[:house_number]} #{params[:street_name]},#{params[:suburb]},#{params[:state]},#{params[:country]}
  # @comments = Comment.where(dish_id: @dish.id)
  erb :edit
end

post '/activities' do
  activity = Activity.new
  activity.name = params[:name]
  activity.description = params[:description]
  activity.image_url = params[:image_url]
  activity.category_id = params[:category].to_i
  activity.location = "#{params[:house_number]} #{params[:street_name]},#{params[:suburb]},#{params[:state]},#{params[:country]}"
  activity.date = params[:date]
  activity.time = params[:time]
  activity.user_id = session[:user_id]
  # activity.like_count = 0
  activity.save
  redirect '/activities'
end

put '/activities/:id' do 
  #fetch existing quote from db
  #update properties to new user submit content
  #redirect to somewhere safe
  activity = Activity.find(params[:id])
  # if params[:like] 
  #   activity.like = params[:like].to_i
  # else
    
  # end

  activity.name = params[:name]
  activity.description = params[:description]
  activity.image_url = params[:image_url]
  activity.category_id = params[:category].to_i
  activity.location = params[:location]
  activity.date = params[:date]
  activity.time = params[:time]
  activity.user_id = session[:user_id]
  # activity.like_count = 0
  activity.save
  redirect "/activities/#{activity.id}"
end

delete '/activities/:id' do #dangerous
  @activity = Activity.find(params[:id])
  @activity.delete #dangerous so redirect
  # # "Deleted"
  redirect '/activities' #so redirect to somewhere else
end

get '/users/new' do
  erb :users_new
end

post '/users' do
  user = User.new
  user.name = params[:name]
  user.email = params[:email]
  # user.password = BCrypt::Password.create(params[:password])
  user.password = params[:password]
  user.image_url = params[:image_url]
  user.phone_number = params[:phone_number]
  user.house_number = params[:house_number]
  user.street_name = params[:street_name]
  user.suburb = params[:suburb]
  user.state = params[:state]
  user.country = params[:country]
  user.save
  redirect '/activities'
end

get '/login' do
  erb :login
end

post '/session' do
  user = User.find_by(email: params[:email])
  if user && user.authenticate(params[:password])
    session[:user_id] = user.id  
    redirect "/activities"
  else
    redirect '/'
  end
end

delete '/session' do
  # "delete the session"
  session[:user_id] = nil
  redirect "/login"
end

put '/likes/:id' do 
  # activity_like = Like.where(user_id: session[:user_id], activity_id: params[:id])
  # like = Like.find_by(user_id: )
  
  # if activity_like.size != 0 
  #   redirect "/activities"

  # else
  
    # activity = Activity.find(params[:id])
    # activity.like_count = activity.like_count + 1
    # activity.save
    like = Like.new
    like.user_id = session[:user_id]
    like.activity_id = activity.id
    like.save
    redirect "/activities"
  # end
end

post '/comments' do 
    comment = Comment.new
    comment.content = params[:comment]
    comment.user_id = session[:user_id]
    comment.activity_id = params[:activity_id]
    comment.quote_id = params[:quote_id]
    comment.save
    redirect "/activities"
  # end
end

post '/quotes/new' do
  @quotes = Quote.where(user_id: session[:user_id])

  erb :quote_new
end

post '/quotes' do
  quote = Quote.new
  quote.content = params[:content]
  quote.user_id = session[:user_id]
  quote.save
  redirect '/quotes'
end

get '/quotes' do
  @quotes = Quote.all
  
  erb :quotes
end

get '/quotes/:id' do
  @quote = Quote.find(params[:id])
  erb :show
end

delete '/quotes/:id' do #dangerous
  @quote = Quote.find(params[:id])
  @quote.delete #dangerous so redirect
  # # "Deleted"
  redirect '/activities' #so redirect to somewhere else
end

post '/images/new' do
  @images = Image.where(user_id: session[:user_id])

  erb :image_new
end

post '/images' do
  image = Image.new
  image.url = params[:url]
  image.user_id = session[:user_id]
  image.save
  redirect '/images'
end

get '/images' do
  @images = Image.all
  
  erb :images
end

get '/images/:id' do
  @image = Image.find(params[:id])
  erb :image_show
end

delete '/images/:id' do #dangerous
  @image = Image.find(params[:id])
  @image.delete #dangerous so redirect
  # # "Deleted"
  redirect '/images' #so redirect to somewhere else
end


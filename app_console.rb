require 'pry'
require_relative 'db_config'
require 'bcrypt'
# more things here 

# lets tell the translation about our tables
require_relative 'models/activity'
require_relative 'models/category'
require_relative 'models/user'
require_relative 'models/like'
require_relative 'models/comment'
require_relative 'models/quote'
require_relative 'models/comment'
require_relative 'models/image'
binding.pry
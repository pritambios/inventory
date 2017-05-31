require 'rails_helper'

 module LoginHelper
   def login(user)
     mock_auth_hash
     visit '/login'
   end
 end

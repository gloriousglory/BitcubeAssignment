## 
# Static Web Page Actions
# - Home Page
class StaticPagesController < ApplicationController
    
    before_action :authenticate_user!
    
    # The home page of the site. Shows buttons to link users to where they want to navigate to.
    def home
    end
end
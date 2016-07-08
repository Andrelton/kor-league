class WelcomeController < ApplicationController
  def index
    @owners = Owner.all
    render :index
  end
end

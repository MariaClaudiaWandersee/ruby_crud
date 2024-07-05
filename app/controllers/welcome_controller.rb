class WelcomeController < ApplicationController
  def index
    @my_name = params[:name] #colocar na barra do navegador: ?name=Maria
    @curso = "Rails"
  end
end

# -*- encoding : utf-8 -*-
class LandingController < ApplicationController

  def checklist

  end

  def planner

  end

  def framework

  end

  def events
      @title = params[:title]
      @image = "http://www.penseventos.com.br#{params[:image]}"
      @description = params[:description]
  end

  def events_weekend
     @title = params[:title]
     @image = "http://www.penseventos.com.br#{params[:image]}" #TROCAR PARA WEBSERVICE
     @description = params[:description]
  end

  def thankyou
    @id = params[:id]
     user_params = params[:user]
     @type =  user_params[:file_type]
     @user = User.new
     @user.name = user_params[:name] + " " + user_params[:last_name]
     @user.email = user_params[:email]
     @user.isPJ = user_params[:isPJ]
     @user.password = user_params[:email]
     @user.ip = request.remote_ip
     @user.save!

      respond_to do |format|
        format.html
      end
  end

  def download
    id = params[:id].to_i
    url = "#{Rails.root}/public/#{id ==  1 ? 'Checklist para eventos' : id == 2 ? 'PLANNER' : 'Framework Eventos'}.pdf"
    send_file url, :type=>"application/pdf", :x_sendfile=>true
  end
end

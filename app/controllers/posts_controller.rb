# -*- encoding : utf-8 -*-

class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_filter :authorize_admin, only: [:new, :edit, :list, :update, :create, :destroy]

  def index
     if not current_admin_user.nil?
      redirect_to admin_path and return
    end

    @posts = Post.where(active: true).order_by(:created_at.desc)

    respond_to do |format|
      format.html
      format.json { render json: { post: @posts} }
    end
  end

  def show
    @posts = Post.where(active: true).order_by(:views.desc)[0..5]
    @post = Post.find(params[:id])
    @post.views ||= 0
    @post.views += 1
    @post.save!

    respond_to do |format|
      format.html
      format.json { render json: { post: @post } }
    end
  end

  def mini_site

  end

  def list
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to posts_list_path, notice: 'Post criado com sucesso!' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to posts_list_path, notice: 'Post atualizado com sucesso!' }
        format.json { render :list, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
   @post.destroy
   respond_to do |format|
      format.html { redirect_to posts_list_path, notice: "Post removido com sucesso!" }
      format.json { hepost :no_content }
    end
  end

  def download
   @id = params[:id]
   user_params = params[:user]
   @user = User.new
   @user.name = user_params[:name] + " " + user_params[:last_name]
   @user.email = user_params[:email]
   @user.isPJ = user_params[:isPJ]
   @user.password = user_params[:email]
   @user.save!

   respond_to do |format|
        format.html { redirect_to posts_concluded_path(@id) }
        format.json { hepost :no_content }
    end
  end

  def concluded
    @post = Post.find(params[:id])
  end

  def leads_list
    @users = User.all
    respond_to do |format|
      format.csv do
        headers['Content-Disposition'] = "attachment; filename=\"leads-list\""
        headers['Content-Type'] ||= 'text/csv'
      end
    end
  end

  private
  def set_post
      @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:active, :title, :description, :content, :author, :tag_list , :main_image, :pdf_file)
  end

end

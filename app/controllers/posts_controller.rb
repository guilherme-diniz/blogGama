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
    @post = Post.find(params[:id])
    @post.views ||= 0
    @post.views += 1
    @post.save!
    # @similar_posts = PostsHelper.similar_posts(@mini_site)

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
        format.html { redirect_to return_url, notice: 'Post criado com sucesso!' }
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
        format.html { redirect_to return_url, notice: 'Post atualizado com sucesso!' }
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
      format.html { redirect_to return_url, notice: "Post removido com sucesso!" }
      format.json { hepost :no_content }
    end
  end

  private
  def set_post
      @post = Post.find(params[:id])
  end

  def post_params
    params.require(:blog).permit(:active, :title, :description, :content, :author, :tag_list , :main_image)
  end

  def return_url
    blogs_list_path(:type => post_params[:blog_type])
  end
end

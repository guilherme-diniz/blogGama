class Post
  include Mongoid::Document
  include Mongoid::Paperclip
  include Mongoid::Timestamps

  has_mongoid_attached_file  :main_image, styles: { big: "900x900>", medium: "500x500>", thumb: "250x250>", minithumb:  "55x54#" }
  validates_attachment_content_type :main_image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  has_mongoid_attached_file :pdf_file
  validates_attachment :pdf_file, :content_type => { :content_type => %w(application/pdf) }

  field :active, type: Boolean #Indica se esta ativo no sistema
  field :title, type: String        #Titulo do post
  field :description, type: String #Pequena descricao
  field :content, type: String      #Conteudo do post (wysiwyg)
  field :author, type: String       #Autor do post (em mini-site é a empresa)
  field :tags, type: Array            #tags do post (colocadas manualmente)
  field :views, type: Integer       #Numero de visualizacoes

  def self.create params
    post = Post.new

    post.title = params[:title]
    post.content = params[:content]
    post.author = params[:author]
    post.active = params[:active]
    post.description = params[:description]
    post.tags = params[:tags].split(",")
    post.views = 0
    post.main_image = params[:main_image] if params[:main_image]

    post
  end

  def self.update post, params
    post.title = params[:title]
    post.content = params[:content]
    post.author = params[:author]
    post.active = params[:active]
    post.description = params[:description]
    post.tags = params[:tags].split(",")
    post.main_image = params[:main_image] if params[:main_image]

  end

  def tag_list=value
    self.tags = value.split(",")
  end

  def tag_list
    tags.join(",") rescue ""
  end
end

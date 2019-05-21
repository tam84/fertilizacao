class ProductArticlesController < ApplicationController
  #before_action :authenticate_admin_user!
  

  def new
    @product_article = ProductArticle.new
    @users = User.all
  end

  def create
    @product_article = ProductArticle.new(product_article_params)
    if @product_article.save
      flash[:success] = "Associação feita com sucesso"
      redirect_back(fallback_location: root_path)
    else
      flash[:error] = "Algo deu errado. Por favor tente novamente"
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    if params[:id]
      @product_article = ProductArticle.find_by(id: params[:id])
      @product_articles = ProductArticle.where(product_id: @product_article.product_id, article_type: 1)
      @guides = ProductArticle.where(product_id: @product_article.product_id, article_type: 0)
    end
  end

  def index
    if params[:product_id] and !params[:article_type] 
      @product_articles = ProductArticle.where(product_id: params[:product_id], article_type: 0)
      @product = Product.find_by(id: params[:product_id])
    elsif params[:product_id] and params[:article_type]
      @product_articles = ProductArticle.where(product_id: params[:product_id], article_type: 1)
      @product = Product.find_by(id: params[:product_id])
      render "_experiencias"
    else
      @product_articles = ProductArticle.all
      @product = Product.first
    end
  end

  def edit
    @product_article = ProductArticle.find_by(id: params[:id])
  end

  def update
    @product_article = ProductArticle.find_by(id: params[:id])
    if @product_article.update(product_article_params)
      flash[:success] = "Produto atualizado com sucesso!"
      redirect_to product_article_path(@product_article)
    else
      flash[:erro] = "Não foi possível atualizar o produto. Por favor tente novamente"
      redirect_to product_article_path(@product_article)
    end

  end

  private

  def product_article_params
    params.require(:product_article).permit(:article_type,:product_id, :title, :content, images:[])       
  end


end
    


class AddArticleTypeToProductArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :product_articles, :article_type, :integer
  end
end

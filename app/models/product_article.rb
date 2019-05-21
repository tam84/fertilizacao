class ProductArticle < ApplicationRecord
	belongs_to :product
	has_many_attached :images
	 
	enum article_type: {guide: 0, question: 1, review:2}


	def category_name product_article
		product = product_article.product
		category_name = product.category.name
	end

end

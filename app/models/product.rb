class Product < ApplicationRecord
# belongs_to :assetclass
  belongs_to :category
  has_many :email_messages
  has_many :product_associates
  has_many_attached :images
  has_many_attached :documents
  has_many_attached :videos    
  has_one :product_specific
  belongs_to :firm
  has_many :posts, as: :postable
  has_many_attached :releases
  has_many :youtube_videos, as: :videoable
  has_many :product_articles

  enum view_status: {revisando: 0, público: 1, confidencial: 2}   


  accepts_nested_attributes_for :product_specific

  require 'roo'

  validates :name, presence: true
  validates :description, presence: true


  def category_name product
    category_name = product.category.name
  end


  def thumbnail input
    return self.images[input].variant(resize: '300x300!').processed
  end

  def self.filter_1 params
    if params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] != ""  and params["/products"]["target_return_benchmark_to"] != ""  and params["/products"]["to_investment_period"] != ""     
        print "----------------------"
        print "destribuitor = nil"
        category_id = Category.find_by(name: params["/products"]["category_name"]).id
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i
        products = Product.where(['target_return_benchmark_to > ? and category_id = ? and to_investment_period < ?', params["/products"]["target_return_benchmark_to"], category_id, cdb_date]).includes(:product_associates, :category)    


    elsif params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] != "" and   params["/products"]["to_investment_period"] != ""     
        print "----------------------"
        print "destribuitor = nil and category_name == nil"
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i        
        products = Product.where(['target_return_benchmark_to > ? and to_investment_period < ?', params["/products"]["target_return_benchmark_to"], cdb_date]).includes(:product_associates, :category)   
      

    elsif params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] == "" and params["/products"]["to_investment_period"] == ""     
        print "----------------------"
        print "destribuitor = nil and category_name == nil and target_return == nil and to_investment_period == nil"
        products = Product.all.includes(:product_associates, :category)
      

    elsif params["/products"]["destribuitor"] != "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] == "" and params["/products"]["to_investment_period"] == ""     
        print "----------------------"
        print "category_name == nil and target_return == nil and to_investment_period == nil"
        products = Product.where(destribuitor: params["/products"]["destribuitor"]).includes(:product_associates, :category)

    elsif params["/products"]["destribuitor"] != "" and params["/products"]["category_name"] != ""  and params["/products"]["target_return_benchmark_to"] == "" and params["/products"]["to_investment_period"] == ""      
        print "----------------------"
        print "target_return == nil and to_investment_period == nil"
        category_id = Category.find_by(name: params["/products"]["category_name"]).id        
        products = Product.where(["destribuitor = ? and category_id = ?", params["/products"]["destribuitor"], category_id] ).includes(:product_associates, :category)

    elsif params["/products"]["destribuitor"] != "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] != "" and params["/products"]["to_investment_period"] == ""      
        print "----------------------"
        print "firm == nil and to_investment_period == nil"
        products = Product.where(["destribuitor = ? and target_return_benchmark_to > ?", params["/products"]["destribuitor"], params["/products"]["target_return_benchmark_to"]] ).includes(:product_associates, :category)

      
    elsif params["/products"]["destribuitor"] != "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] == "" and params["/products"]["to_investment_period"] != ""      
        print "----------------------"
        print "target_return == nil and category == nil"
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i                
        products = Product.where(["destribuitor = ? and to_investment_period < ?", params["/products"]["destribuitor"], cdb_date] ).includes(:product_associates, :category)


    elsif params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] != ""  and params["/products"]["target_return_benchmark_to"] == ""  and params["/products"]["to_investment_period"] == ""        
        print "----------------------"
        print "target_return == nil and destribuitor = nil and to_investment_period == nil"
        category_id = Category.find_by(name: params["/products"]["category_name"]).id
        products = Product.where(['category_id = ?', category_id]).includes(:product_associates, :category)         


    elsif params["/products"]["destribuitor"] != "" and params["/products"]["category_name"] != ""  and params["/products"]["target_return_benchmark_to"] == "" and params["/products"]["to_investment_period"] != ""       
        print "----------------------"
        print "target_return == nil"
        category_id = Category.find_by(name: params["/products"]["category_name"]).id
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i        
        products = Product.where(['category_id = ? and destribuitor = ? and to_investment_period < ?', category_id, params["/products"]["destribuitor"], cdb_date]).includes(:product_associates, :category)        


    elsif params["/products"]["destribuitor"] != "" and params["/products"]["category_name"] != ""  and params["/products"]["target_return_benchmark_to"] != ""  and params["/products"]["to_investment_period"] != ""        
        print "----------------------"
        print "tudo preenchido"
        category_id = Category.find_by(name: params["/products"]["category_name"]).id
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i                
        products = Product.where(['target_return_benchmark_to > ? and category_id = ? and destribuitor = ? and to_investment_period < ?', params["/products"]["target_return_benchmark_to"], category_id, params["/products"]["destribuitor"], cdb_date]).includes(:product_associates, :category)          

    elsif params["/products"]["destribuitor"] != "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] != ""  and params["/products"]["to_investment_period"] != ""         
        print "----------------------"
        print "category == nil "
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i                
        products = Product.where(['target_return_benchmark_to > ? and destribuitor = ? and to_investment_period < ?', params["/products"]["target_return_benchmark_to"], params["/products"]["destribuitor"], cdb_date]).includes(:product_associates, :category)          


    elsif params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] != ""  and params["/products"]["target_return_benchmark_to"] != ""  and params["/products"]["to_investment_period"] == ""         
        print "----------------------"
        print "firm == nill and to_investment_period == nill"
        category_id = Category.find_by(name: params["/products"]["category_name"]).id
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i                
        products = Product.where(['target_return_benchmark_to > ? and category_id = ?', params["/products"]["target_return_benchmark_to"], category_id]).includes(:product_associates, :category)          



    elsif params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] != ""  and params["/products"]["target_return_benchmark_to"] == ""  and params["/products"]["to_investment_period"] != ""         
        print "----------------------"
        print "target_return == nill and destribuitor == nill "
        category_id = Category.find_by(name: params["/products"]["category_name"]).id
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i                
        products = Product.where(['category_id = ? and to_investment_period < ?', category_id, cdb_date]).includes(:product_associates, :category)          



    elsif params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] == ""  and params["/products"]["to_investment_period"] != ""         
        print "----------------------"
        print "destribuitor = nil and category_name == nil and target_return == nil"
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i                
        products = Product.where(['to_investment_period < ?', cdb_date]).includes(:product_associates, :category)          


    elsif params["/products"]["destribuitor"] == "" and params["/products"]["category_name"] == ""  and params["/products"]["target_return_benchmark_to"] != ""  and params["/products"]["to_investment_period"] == ""         
        print "----------------------"
        print "destribuitor = nil and category_name == nil and to_investment_period == nil"
        cdb_date = Date.current + params["/products"]["to_investment_period"].to_i                
        products = Product.where(['target_return_benchmark_to > ?', params["/products"]["target_return_benchmark_to"]]).includes(:product_associates, :category)        



      end
  end

  def to_param
    "#{id}-#{name}".parameterize
  end    


def self.import(file)
  spreadsheet = open_spreadsheet(file)
  header = spreadsheet.row(1)
  (2..spreadsheet.last_row).each do |i|
    row = Hash[[header, spreadsheet.row(i)].transpose]
    product = find_by_name(row["name"]) || new
    product.attributes = row.to_hash.slice(*Product.attribute_names())
    product.save!
  end
end

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Roo::CSV.new(file.path)
  when ".xls" then Roo::Excel.new(file.path)
  when ".xlsx" then Roo::Excelx.new(file.path)
  else raise "Unknown file type: #{file.original_filename}"
  end
end  



end

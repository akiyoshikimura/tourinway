class ProductsController < ApplicationController

  def new
    @product = Product.new
    @product.productimages.build
  end

  def create
    binding.pry
    @reviews = Review.all
    @product = Product.new(create_params)
    unless @product.save
      @product.productimages.build
      render :new
    else
      map = Map.new(address: create_params_for_map, product_id: @product.id)
      map.save
    end
  end

  def search
    if (params[:departure]=="指定しない") && (params[:arrival]=="指定しない") then
      @products = Product.where(['title LIKE? or destination LIKE? or departure LIKE? or arrival LIKE? or detail LIKE?' , "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).order("created_at DESC")
    elsif (params[:departure]!="指定しない") && (params[:arrival]=="指定しない") then
      search_products = Product.where(departure: params[:departure])
      @products = search_products.where(['title LIKE? or destination LIKE? or departure LIKE? or arrival LIKE? or detail LIKE?' , "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).order("created_at DESC")
    elsif (params[:departure]=="指定しない") && (params[:arrival]!="指定しない") then
      search_products = Product.where(arrival: params[:arrival])
      @products = search_products.where(['title LIKE? or destination LIKE? or departure LIKE? or arrival LIKE? or detail LIKE?' , "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).order("created_at DESC")
    else
      search_products = Product.where(departure: params[:departure], arrival: params[:arrival])
      @products = search_products.where(['title LIKE? or destination LIKE? or departure LIKE? or arrival LIKE? or detail LIKE?' , "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%", "%#{params[:keyword]}%"]).order("created_at DESC")
    end
  end

  def show
    @product = Product.find(params[:id])
    @productimage = Productimage.where(product_id: params[:id])
    @map = Map.find_by(product_id: params[:id])
    @hash = Gmaps4rails.build_markers(@map) do |map, marker|
      marker.lat map.latitude
      marker.lng map.longitude
      marker.infowindow map.description
      marker.json({title: map.title})
    end
    @reviews = Review.where(product_id: params[:id]).order("created_at DESC")
    @review = Review.new
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    binding.pry
    @product = Product.find(params[:id])
    @product.update(update_params)
    map = Map.find_by(product_id: params[:id].to_i)
    map.address = update_params_for_map
    map.save
  end

  def destroy
    product = Product.find(params[:id])
    productimage = Productimage.where(product_id: params[:id])
    if product.user_id == current_user.id
      product.destroy
      productimage.each do |a|
        a.destroy
      end
    end
  end

  private
  def create_params
    params.require(:product).permit(:title, :destination, :departure, :arrival, :detail, productimages_attributes: [:image_url]).merge(user_id: current_user.id)
  end

  def create_params_for_map
    params.require(:product).permit(:destination)[:destination]
  end

  def update_params
    params.require(:product).permit(:title, :destination, :departure, :arrival, :detail, productimages_attributes: [:id, :_destroy, :image_url])
  end

  def update_params_for_map
    params.require(:product).permit(:destination)[:destination]
  end

end

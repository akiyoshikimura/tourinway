class ReviewsController < ApplicationController

  def create
    Review.create(review_params)
    @reviews = Review.all
    @product = Product.find(review_params[:product_id])
    @productimage = Productimage.where(product_id: params[:id])
    @map = Map.find_by(product_id: params[:id])
    @hash = Gmaps4rails.build_markers(@map) do |map, marker|
      marker.lat map.latitude
      marker.lng map.longitude
      marker.infowindow map.description
      marker.json({title: map.title})
    end
    @reviews = Review.where(product_id: review_params[:product_id]).order("created_at DESC")
    @review = Review.new
  end

  def destroy
    Review.find(params[:id]).destroy
    @reviews = Review.all
    @product = Product.find(params[:product_id])
    @productimage = Productimage.where(product_id: params[:product_id])
    @map = Map.find_by(product_id: params[:product_id])
    @hash = Gmaps4rails.build_markers(@map) do |map, marker|
      marker.lat map.latitude
      marker.lng map.longitude
      marker.infowindow map.description
      marker.json({title: map.title})
    end
    @reviews = Review.where(product_id: params[:product_id]).order("created_at DESC")
    @review = Review.new
  end

  private
  def review_params
    params.require(:review).permit(:review).merge(user_id: current_user.id, product_id: params[:product_id].to_i)
  end

end

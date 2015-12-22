class Api::V1::CowsController < ApplicationController

skip_before_action :verify_authenticity_token

  def index
  	render json: Cow.all.as_json(include: :calves)
  end

  def show
    if cow = Cow.find_by_id(params[:id])
      render json: cow.as_json(include: :calves)
    else 
      render status: 404, json: { 
        error: 'requested cow does not exist' 
      }
    end
  end


  def new
    @cow = Cow.new
  end


  def edit
  end

  def create
    @cow = Cow.new(cow_params)

    if @cow.save
      render json: @cow.as_json
    else
      render status: 400
    end

  end

  def update
    @cow = Cow.find_by_id(params[:id])
      if @cow.update(cow_params)
      render json: @cow.as_json
    else
      render status: 400
    end
    end
  end

  private
    def set_cow
      @cow = Cow.find(params[:id])
    end

    def cow_params
      params.require(:cow).permit(:name, :heading, :description, :image_url, :image, :money, :hay_bales)
    end

end

class Api::V1::CowsController < ApplicationController

skip_before_action :verify_authenticity_token

before_filter :cors_preflight_check
after_filter :cors_set_access_control_headers

  # For all responses in this controller, return the CORS access control headers.

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Max-Age'] = "1728000"
  end

  # If this is a preflight OPTIONS request, then short-circuit the
  # request, return only the necessary headers and return an empty
  # text/plain.

  def cors_preflight_check
    if request.method == :options
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

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
    respond_to do |format|
      if @cow.update(cow_params)
        format.html { redirect_to @cow, notice: 'Cow was successfully updated.' }
        format.json { render :show, status: :ok, location: @cow }
      else
        format.html { render :edit }
        format.json { render json: @cow.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @cow.destroy
    respond_to do |format|
      format.html { redirect_to cows_url, notice: 'Cow was successfully destroyed.' }
      format.json { head :no_content }
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

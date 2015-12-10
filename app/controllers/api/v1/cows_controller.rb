class Api::V1::CowsController < ApplicationController
  def index
  	render json: Cow.all.as_json(except: [:created_at, :updated_at])
  end

  def show
    if cow = Cow.find_by_id(params[:id])
      render json: cow.as_json(
        except: [:created_at, :updated_at], 
        include: { 
         calves: { except: [:created_at, :updated_at, :category_id] } 
        }
      )
    else 
      render status: 404, json: { 
        error: 'requested cow does not exist' 
      }
    end
  end

end

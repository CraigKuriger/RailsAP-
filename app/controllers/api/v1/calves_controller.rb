class Api::V1::CalvesController < ApplicationController
  def index
    render json: Calf.all.as_json(
      except: [:created_at, :updated_at, :category_id],
      methods: [:average_rating, :latest_review],
      include: {
        cow: { only: [:id, :title] }
      }
    )
  end

def show
  if calf = Calf.find_by_id(params[:id])
    render json: calf.as_json(
      except: [:created_at, :updated_at, :cow_id],
      methods: [:average_rating],
      include: {
        cow: { only: [:id, :title] },
        comments: { except: [:updated_at, :item_id] }
      }
    )
  else 
    render status: 404, json: { error: 'requested calf does not exist' }
  end
end
end

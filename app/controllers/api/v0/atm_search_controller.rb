class Api::V0::AtmSearchController < ApplicationController

  def search
    render json: AtmFacade.new(params[:id]).nearest_atms
  end

end
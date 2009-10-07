class ChurchesController < ApplicationController
  def show
    @church = Church.find(params[:id])
  end

end

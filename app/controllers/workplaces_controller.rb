class WorkplacesController < ApplicationController
  def show
    @workplace = Workplace.find(params[:id])
  end

end

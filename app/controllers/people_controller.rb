class PeopleController < ApplicationController
  def show
    @person = Person.find params[:id], 
                          :include => [:client, :church, :children, :spouse, :workplace, :schools, :students, :life_events]
  end
end
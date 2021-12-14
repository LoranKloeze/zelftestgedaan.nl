class StaticController < ApplicationController
  def thanks
    @is_positive = params[:is_positive] == 'true'
  end


  def privacy; end
end

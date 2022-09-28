class StaticPagesController < ApplicationController

  def home
    @events = Event.paginate(page: params[:page])
  end

  def help
  end

  def about
  end

  def contact
  end
end

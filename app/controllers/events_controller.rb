class EventsController < ApplicationController
  before_action :correct_user,   only: :destroy

  def new
    @event = Event.new
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "イベントの投稿が完了しました"
      redirect_to "/users/#{current_user.id}"
    else
      render "events/new"
    end
  end

  def destroy
    # @event = current_user.events.find_by(id: params[:id])
    @event.destroy
    flash[:success] = "Event deleted"
    redirect_to request.referrer || root_url
  end

  def show
    @event = Event.find(params[:id])
  end
 
  

  private
    def correct_user
      @event = current_user.events.find_by(id: params[:id])
      redirect_to root_url if @event.nil?
    end

    def event_params
      params.require(:event).permit(
        :maintitle,
        :about,
        :title_content1,
        :content1,
        :title_content2,
        :content2,
        :title_content3,
        :content3,
        :title_content4,
        :content4,
        :title_content5,
        :content5,
      )
    end
end

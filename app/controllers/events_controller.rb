class EventsController < ApplicationController
  def index
	@events=Event.page(params[:page]).per(5)

	respond_to do |format|
    format.html # index.html.erb
    format.xml { render :xml => @events.to_xml }
    format.json { render :json => @events.to_json }
    format.atom { @feed_title = "My event list" } # index.atom.builder
   end

  end
  def new
	@event=Event.new
  end

  def show
     @event = Event.find(params[:id])
	 @page_title = @event.name
	 respond_to do |format|
		format.html
		format.js
	 end
   end
 def edit
     @event = Event.find(params[:id])
  end

  def create
	 @event=Event.new(params[:event].permit(:name,:description))
	 if @event.save
	   
	   redirect_to events_path
	   flash[:notice] = "event was successfully created"
	   
	   
	  else
		render 'new'
	 end
	 
  end

def update
  @event = Event.find(params[:id])
  if @event.update_attributes(params[:event].permit(:name,:description))
      flash[:notice] = "event was successfully updated"
      redirect_to event_url(@event)
	  
  else
	render 'edit'
  end

end

def destroy
  @event = Event.find(params[:id])
  @event.destroy
  flash[:alert] = "event was successfully deleted"
  redirect_to events_url
end




end

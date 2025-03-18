class PlacesController < ApplicationController

  def index
    @places = Place.all
  end

  def show
    @places = Place.find_by({ "id" => params["id"] })
    @entry = Entry.where({ "place_id" => @place["id"] })
    @places = Place.where({ "user_id" => @place["id"], "user_id" => session["user_id"] })
  end

  def new
    @places = Place.find_by({ "id" => params["place_id"] })
  end

  def create
    @places = Place.new
    @places["name"] = params["name"]
    @places.save
    redirect_to "/places"
  end
  
  def edit
    @place = Place.find_by({ "id" => params["id"] })
  end

  def update
    @places = Place.find_by({ "id" => params["id"] })
    if User.find_by({ "id" => session["user_id"] }) != nil
      @places["name"] = params["name"]
      @places.save
    else
      flash["notice"] = "You must be logged in."
    end
    redirect_to "/places"
  end
  
  def destroy
    @places = Place.find_by({ "id" => params["id"] })
    if User.find_by({ "id" => session["user_id"] }) != nil
      @place.destroy
      redirect_to "/places"
    else
      flash["notice"] = "You must be logged in."
      redirect_to "/places"
    end
  end

end

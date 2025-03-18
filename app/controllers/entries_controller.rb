class EntriesController < ApplicationController

  def new
    if session["user_id"] == nil
      redirect_to "/places"
    else
    @places = Place.find_by({ "id" => params["place_id"] })
    end
  end
  
  def create

    @entry = Entry.new
    @entry["title"] = params["title"]
    @entry["description"] = params["description"]
    @entry["occurred_on"] = params["occurred_on"]
    @entry["place_id"] = params["place_id"]
    @entry.uploaded_image.attach(params["uploaded_image"])
    @entry["user_id"] = session["user_id"]
    @entry.save
    redirect_to "/places/#{params["place_id"]}"
  end

end

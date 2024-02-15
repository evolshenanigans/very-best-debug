class VenuesController < ApplicationController

  def index
    matching_venues = Venue.all
    @venues = matching_venues.order(:created_at)

    render({ :template => "venue_templates/venue_list" })
  end

  def show
    venue_id = params.fetch("an_id")
    matching_venues = Venue.where({ :id => venue_id })
    @the_venue = matching_venues.first

    render({ :template => "venue_templates/details" })
  end

  def create
    @venues = Venue.new
    @venues.address = params.fetch("query_address")
    @venues.name = params.fetch("query_name")
    @venues.neighborhood = params.fetch("query_neighborhood")
    @venues.save

    redirect_to("/venues/#{@venues.id}")
  end
  
  def update
    the_id = params.fetch("the_id")

    matching_venue = Venue.where({ :id => the_id })
    venue = matching_venue.first
    venue.address = params.fetch("query_address")
    venue.name = params.fetch("query_name")
    venue.neighborhood = params.fetch("query_neighborhood")
    venue.save
    
    redirect_to("/venues/#{venue.id}")
  end

  def destroy
    the_id = params.fetch("id_to_delete")
    matching_venues = Venue.where({ :id => the_id })
    venue = matching_venues.first
    venue.destroy

    redirect_to("/venues")
  end

end

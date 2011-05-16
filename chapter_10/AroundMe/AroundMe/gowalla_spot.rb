#
#  gowalla_spot.rb
#  AroundMe
#
#  Created by Matt Aimonetti on 5/16/11.
#  Copyright 2011 m|a agile Consulting. All rights reserved.
#

class GowallaSpot
  
  attr_reader :name
  attr_reader :url
  attr_reader :description
  attr_reader :highlights_url
  attr_reader :lat, :lgn
  attr_reader :image
  attr_reader :items_count
  attr_reader :radius_meters
  attr_reader :users, :checkins
  
  def initialize(spot_hash)
    @name = spot_hash['name']
    @url = NSURL.URLWithString(
                  "http://gowalla.com#{spot_hash['url']}")
    @description = spot_hash['description']
    @highlights_url = 'http://gowalla.com'  \
      + spot_hash['highlights_url']
    @lat = spot_hash['lat']
    @lgn = spot_hash['lgn']
    @image = spot_hash['_image_url_50']
    @items_count = spot_hash['items_count']
    @radius_meters = spot_hash['radius_meters']
    @users = spot_hash['users_count']
    @checkins = spot_hash['checkins_count']
  end
  
end
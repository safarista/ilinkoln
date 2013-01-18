
class PagesController < ApplicationController
  # caches_page :events
  
  
  def about_us
    @title = "What iLinkoln is all about"
  end
  
  def contact_us
    @title = "Contact Nelson Kelem with any correspondence"
  end
  
  def lincoln_hack
    @title = 'Lincoln Hack Fest 18-19th June 2011 at the Lincoln University'
    @meta = 'Lincoln Open Hack is a 24 hours event on 18 to 19/06/2011. Desigers, developers, and other geeks come together and create great applications. The venue is Lincoln University Main building contact Nelson Kelem 07807480332'
    respond_to do |format|
      format.html { render :layout => false }
    end
  end
  
  # def download
  #   send_data("#{RAILS_ROOT}/images/LincolnHack1SponsorDocument.pdf", :disposition => "attachment")
  # end
  
  def events
    url = "https://api.meetup.com/events?key=60451a4524d6d1b1f3af3551b4111&sign=true&status=upcoming&group_urlname=ilinkoln"
    events = JSON.parse(open(url).read)
    @events = events["results"]
    @title = @events.first["name"] if @events
    
    # 
    # "rsvpcount" => "1",
    #             "venue_name" => "The Hub",
    #       "payment_required" => "0",
    #        "maybe_rsvpcount" => "0",
    #       "allow_maybe_rsvp" => "0",
    #               "rsvpable" => "OPEN",
    #          "member_status" => "member",
    #                   "time" => "Tue Mar 08 19:00:00 GMT 2011",
    #              "venue_zip" => "",
    #       "venue_visibility" => "public",
    #                "feedesc" => "per person",
    #                "updated" => "Tue Feb 01 06:02:15 EST 2011",
    #         "venue_address1" => "Brayford Pool",
    #            "description" => "<p><strong>RSVP:</strong> <em><span style=\"color: royalblue;\">If you are thinking of attending, please let us know through Meetup as it helps us keep you informed of last-minute changes (and we can get a good seating/food plan together)</span>.  Everyone coming will contribute &pound;5 towards this. Hungry people lose concentration very fast.</em></p>\r\n<p>1. <strong>Running a success business:</strong><em> Trefor Davis of&nbsp;<a href=\"http://www.trefor.net\"> trefor.net</a><br /></em></p>\r\n<p>2. <strong>Measuring in marketing:</strong><em> Andyclayton of <a href=\"http://www.energycell.co.uk/\">the energy cell</a><br /></em></p>",
    #         "venue_address2" => "The Engine Shed, University Of Lincoln",
    #         "venue_address3" => "",
    #               "venue_id" => "1407734",
    #            "rsvp_closed" => "0",
    #            "photo_count" => "",
    #                    "lon" => "-0.550000011920929",
    #           "no_rsvpcount" => "0",
    #                 "status" => "upcoming",
    #              "photo_url" => "http://photos1.meetupstatic.com/photos/event/1/0/a/a/global_18160266.jpeg",
    #               "group_id" => "1676068",
    #        "utc_rsvp_cutoff" => "None",
    #              "questions" => [],
    #            "rsvp_cutoff" => "None",
    #         "attendee_count" => "0",
    #                    "fee" => "5.0",
    #              "venue_map" => "http://maps.google.com/staticmap?center=53.234863,-0.538436&zoom=14&size=512x512&maptype=mobile&markers=53.234863,-0.538436,blues&key=ABQIAAAAiB79SpLrOxrYbOzqaYGrvhQrNhSbWhQbZXKDt0w9V4y2n6CzahTrHTbQjuSGhL4xdTPFH0lRNNe4-A&sensor=false",
    #         "how_to_find_us" => "",
    #              "venue_lat" => "53.234863",
    #         "rsvp_open_time" => "None",
    #     "my_waitlist_status" => "",
    #           "organizer_id" => "11102847",
    #                 "myrsvp" => "yes",
    #                     "id" => "16395699",
    #               "ismeetup" => "1",
    #             "venue_city" => "Lincoln",
    #                   "name" => "Running a success business: Trevor Davis, Measuring in marketing: Andyclayton",
    #         "photo_album_id" => "",
    #                    "lat" => "53.22999954223633",
    #            "venue_state" => "",
    #             "group_name" => "iLinkoln Web and Digital Media Meetup",
    #             "rsvp_limit" => "0",
    #        "group_photo_url" => "http://photos1.meetupstatic.com/photos/event/1/0/a/a/global_18160266.jpeg",
    #            "guest_limit" => "0",
    #               "utc_time" => "1299610800000",
    #      "waiting_rsvpcount" => "0",
    #         "organizer_name" => "Nelson K",
    #            "feecurrency" => "GBP",
    #     "utc_rsvp_open_time" => "None",
    #            "event_hosts" => [
    #         [0] {
    #             "member_name" => "Nelson K",
    #               "member_id" => 11102847
    #         }
    #     ],
    #            "venue_phone" => "0844 888 8766",
    #              "venue_lon" => "-0.538436",
    #           "rating_count" => 0,
    #              "event_url" => "http://www.meetup.com/iLinkoln/events/16395699/",
    #                 "rating" => 0
    # }
  end
end
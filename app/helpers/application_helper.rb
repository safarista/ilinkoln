module ApplicationHelper
  
  def title
    base_title = "iLinkoln Meetup Group - Lincoln UK"
    
    if @title.nil?
      base_title
    else
      "#{@title} | #{base_title}"
    end
  end
  
  def kramdown(text)
    return sanitize Kramdown::Document.new(text).to_html # , :tags => ['a', 'strong', 'p', 'embed', 'object', 'param', 'div', 'span', 'ul', 'li', 'ol', 'img', 'figure', 'figcaption']
  end
  
  def event
    url = "https://api.meetup.com/events?key=60451a4524d6d1b1f3af3551b4111&sign=true&status=upcoming&group_urlname=ilinkoln"
    events = JSON.load(open(url).read)
    @events = events["results"]
    @events.first["time"].to_date()
    
  end
  
end

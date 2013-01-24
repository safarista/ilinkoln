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
    return sanitize Kramdown::Document.new(text).to_html, :tags => ['a', 'strong', 'p', 'embed', 'object', 'param', 'div', 'span', 'ul', 'li', 'ol', 'img', 'iframe', 'figure', 'figcaption', 'cite', 'pre', 'blockquote', 'video', 'audio', 'mark', 'em', 'sup', 'sub', 'small', 'h2', 'h3', 'h4', 'strong']

    # options ||= [:hard_wrap => true, :filter_html => true, :autolink => true, :no_intraemphasis => true, :fenced_code => true, :gh_blockcode => true]
    # kramdown = Redcarpt::Markdown.new(Redcarpet::Render::HTML, *options)
    # kramdown.render(text)
end
  
  def meetup_day
    url = "https://api.meetup.com/2/events?key=60451a4524d6d1b1f3af3551b4111&sign=true&status=upcoming&group_id=1676068&group_urlname=ilinkoln&page=2"
    events = JSON.load(open(url).read)
    eventi = events["results"]
    @evento = eventi.first["time"]
    
  end
  
end

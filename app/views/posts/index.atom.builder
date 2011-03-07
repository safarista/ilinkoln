atom_feed do |feed|
  feed.title("iLinkoln Web & Digital Media for Business Meetup Group ")
  feed.updated(@posts.first.created_at)
  
  @posts.each do |post|
    feed.entry(post) do |entry|
      entry.title(post.title)
      entry.content( "#{ kramdown truncate(post.body, 
                          :length => 1000, 
                          :omission => '...(Read on)') }", 
                          :type => "html")
                      
      entry.author { |author| author.name(post.member.name)}
      
    end
  end
end
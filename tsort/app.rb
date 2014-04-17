require './env'

ks = Kneescraper.new CONFIG["base_url"]
path = CONFIG["path"]
xpath = "//table[contains(@class,'albumlist')]/a"
xpath = "//td"
count = 0
albums = {}
num_cols = 2
this_col = 1
current_album, current_artist = "", ""

ks.fetch path, xpath do |stuff|
  if stuff.attributes["class"] and stuff.attributes["class"].value == 'aat'
    a = stuff.children.first.text
    if a.class==Nokogiri::XML::Element and a.name == "a"
      current_artist = "Childartist:#{a.children.first}"
    else
      current_artist = "Artist:#{a}"
    end
  end

  if stuff.attributes["class"] and stuff.attributes["class"].value == 'att'
    current_album = "Album:#{stuff.children.first.text}"
  end
#<td class="aat"><a href="/music/kzun10.htm">Michael Jackson</a></td>
#<td class="att">Thriller</td>
  #puts stuff.children if this_col == 1
  #puts stuff.children.inspect
  #
#   stuff.children.each do |thing|
#
#     puts thing.inspect
#     puts
#
#   end

#   href = stuff.attributes["href"].value
#
#   if href =~ /#{path}\/(.+)-\d+/
#     count += 1
#     words = $1.split(/-/)
#     album = words.map {|word| word.capitalize}.join " "
#
#   end
  #
  if this_col == num_cols
    this_col = 1
    album = "#{current_artist}||#{current_album}"
    if albums[album]
      albums[album] += 1
    else
      albums[album] = 1
    end
    count += 1
    current_artist, current_album = "", ""
  else
    this_col += 1
  end

end
puts
puts
puts albums.keys
puts "Count: #{count}"

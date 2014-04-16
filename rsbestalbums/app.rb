require './env'

ks = Kneescraper.new CONFIG["base_url"]
path = CONFIG["path"]
xpath = "//div[contains(@class,'quickJumpModule')]/a"
xpath = "//a"
count = 0
albums = {}

ks.fetch path, xpath do |stuff|
  href = stuff.attributes["href"].value
  if href =~ /#{path}\/(.+)-\d+/
    count += 1
    words = $1.split(/-/)
    album = words.map {|word| word.capitalize}.join " "

    if albums[album]
      albums[album] += 1
    else
      albums[album] = 1
    end
  end
end

puts "Count: #{count}"
puts albums.keys.reverse

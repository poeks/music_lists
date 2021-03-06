
class Getter

  def initialize
    @conn = Faraday.new(:url => CONFIG["base_url"]) do |faraday|
      faraday.request  :url_encoded             # form-encode POST params
      faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
    end
  end

  def get_genre_name genre_url
    if genre_url =~ /(.+)-[^-]+/
      $1
    else
      genre_url
    end
  end

  def get_all_genres
    all = []
    CONFIG["genres"].each do |genre|
      all.concat get_genre(genre)
    end
    all
  end

  def get_genre genre
    url = "#{CONFIG["base_url"]}/#{CONFIG["genre_path"]}/#{genre}/albums"
    res = @conn.get(url)
    body = parse res.body
    get_albums(genre, body)
  end

  def parse stuff
    @doc = Nokogiri::HTML stuff
  end

  def get_albums genre, stuff
    path = "//div[contains(@class,'album-highlight')]/a"
    hrefs = @doc.xpath path
    hrefs.collect {|node| 
      title = node.attributes["title"].text
      if title =~ /([^-]+) - (.+)/
        [$1.strip.chomp, $2.strip.chomp, get_genre_name(genre).chomp]
      else
        puts "Couldn't parse #{title}"
      end
    }
  end

  def write_csv things
    CSV.open("all_music.csv", "w") do |csv|
      csv << ["Genre","Artist","Album"]
      things.each do |thing|
        puts thing
        csv << thing
      end
    end
  end

end

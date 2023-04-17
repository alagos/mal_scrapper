module MalScraper
  class Init
    def self.start
      initial_page = 'https://myanimelist.net/anime/21/One_Piece/episode'
      response = Faraday.get(initial_page)
      doc = Nokogiri::HTML(response.body)
      episodes = doc.css('.episode-list-data').map do |episode_data|
        episode = MalScraper::Episode.new(episode_data)
        puts "Episode #{episode.number} - #{episode.title}"
        episode.to_h
      end
      File.open('tmp/episodes.json', 'w') do |file|
        file.write(JSON.pretty_generate(episodes))
      end
      nil
    end
  end
end

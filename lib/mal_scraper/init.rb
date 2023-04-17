module MalScraper
  class Init
    class << self
      def start
        episodes = get_episodes('https://myanimelist.net/anime/21/One_Piece/episode')
        File.open('tmp/episodes.json', 'w') do |file|
          file.write(JSON.pretty_generate(episodes))
        end
      end

      private

      def get_episodes(url)
        page = get_page(url)
        episodes = get_episodes_from_page(page)

        loop do
          pagination = page.css('.pagination')
          break unless pagination.any?

          request_next_page = false
          pagination_links = pagination.css('.link')
          last_page = false

          pagination_links.each_with_index do |link, index|
            if request_next_page
              page = get_page(link.attr('href'))
              episodes += get_episodes_from_page(page)
            end

            request_next_page = link.attr('class').include?('current')
            last_page = request_next_page && index == pagination_links.size - 1
          end
          break if last_page
        end
        episodes
      end


      def get_page(page)
        puts "Getting page #{page}"
        response = Faraday.get(page)
        Nokogiri::HTML(response.body)
      end

      def get_episodes_from_page(page)
        page.css('.episode-list-data').map do |episode_data|
          episode = MalScraper::Episode.new(episode_data)
          puts "Episode #{episode.number} - #{episode.title}"
          episode.to_h
        end
      end
    end
  end
end

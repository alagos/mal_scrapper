module MalScraper
  class Episode
    attr_reader :number, :title, :original_title, :date, :score, :url

    def initialize(episode_data)
      @number = episode_data.css('.episode-number').text
      title_data = episode_data.css('.episode-title')
      @title = title_data.css('a').text
      @original_title = title_data.css('span').text
      @date = episode_data.css('.episode-aired').text
      @score = episode_data.css('.episode-poll .value').text
      @url = episode_data.css('.episode-forum a').attr('href').value
    end

    def to_h
      {
        number: @number,
        title: @title,
        original_title: @original_title,
        date: @date,
        score: @score,
        url: @url
      }
    end
  end
end

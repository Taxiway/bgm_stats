# Download page and return line as Array

require 'open-uri'

class Downloader
  def initialize(url)
    @url = url
  end

  def get_content
    puts "Crawling start: #{@url}"
    @content = Array.new

    open(@url, "r:utf-8") do |f|
      puts f.content_encoding
      f.each_line do |line|
        @content << line
      end
    end
    @content
  end
end

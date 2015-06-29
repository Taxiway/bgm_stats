require_relative "html_downloader.rb"

class BGM_Stats
  @@URL = "http://bgm.tv/anime/list/taxiway/collect"

  def filter_items(html)
    lines = html.select {|line| line =~ /subjectCover/}
    subjects = lines.collect do |line|
      m = /\/subject\/[\d]*/.match line
      m[0]
    end
    subjects
  end

  def run
    @subjects = []
    1.upto(100) do |page|
      downloader = Downloader.new(@@URL + "?page=" + page.to_s)
      html = downloader.get_content
      subjects = filter_items html
      puts subjects
      break if subjects.empty?
      @subjects += subjects
    end
    puts @subjects.length
  end
end

stats = BGM_Stats.new
stats.run

require_relative "html_downloader.rb"

class BGM_Stats
  @@BGM_URL = "http://bgm.tv"
  @@LIST_URL = "http://bgm.tv/anime/list/taxiway/collect"

  def filter_items(html)
    lines = html.select {|line| line =~ /subjectCover/}
    subjects = lines.collect do |line|
      m = /\/subject\/[\d]*/.match line
      m[0]
    end
    subjects
  end

  def download_image(subject)
    downloader = Downloader.new(@@BGM_URL + subject)
    html = downloader.get_content
    lines = html.select {|line| line =~ /lain.bgm.tv\/pic\/cover\/l/}
    url = "http:" + (/\/\/[a-zA-Z0-9.\/_]+/.match lines[0])[0]
    puts url
  end

  def run
    @subjects = []
    1.upto(100) do |page|
      downloader = Downloader.new(@@LIST_URL + "?page=" + page.to_s)
      html = downloader.get_content
      subjects = filter_items html
      break if subjects.empty?
      @subjects += subjects
    end

    @subjects.each do |subject|
      download_image(subject)
    end
  end


end

stats = BGM_Stats.new
stats.run

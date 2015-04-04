module ApplicationHelper
  def strftime(time)
    return time unless time
    time.strftime("%Y-%m-%d %H:%M:%S")
  end

  def icon_link_to(text, url, icon_name, options = {})
    link_to("<i class=\"icon-#{icon_name}\"></i> #{text}".html_safe, url, options)
  end

  def title(text)
    page_tilte = ''
    page_tilte = "#{text} - " unless text.blank?
    page_tilte << 'Dashbozu'
  end
end

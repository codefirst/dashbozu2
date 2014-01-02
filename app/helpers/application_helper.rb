module ApplicationHelper
  def strftime(time)
    return time unless time
    time.strftime("%Y-%m-%d %H:%M:%S")
  end
end

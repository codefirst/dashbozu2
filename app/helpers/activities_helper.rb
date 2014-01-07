module ActivitiesHelper
  def activity_source_image_url(activity)
    image_url activity.source + '.png'
  end
end

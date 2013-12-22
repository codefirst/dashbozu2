class Settings < Settingslogic
  source "#{Rails.root}/config/dashbozu.yml"
  namespace Rails.env
end


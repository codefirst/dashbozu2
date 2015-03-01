module TopHelper
  def github?
    not(ENV['GITHUB_KEY'].nil? or ENV['GITHUB_SECRET'].nil?)
  end

  def bitbucket?
    not(ENV['BITBUCKET_KEY'].nil? or ENV['BITBUCKET_SECRET'].nil?)
  end
end


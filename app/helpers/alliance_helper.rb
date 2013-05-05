module AllianceHelper
  require 'json'
  require 'httparty'

  def getAlliance(id)
    JSON.parse HTTParty.get('http://evewho.com/api.php?type=allilist&id=' + id.to_s).response.body
  end
end

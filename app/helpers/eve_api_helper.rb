module EveApiHelper

  def connection(key_id='', v_code='', scope: 'eve')
    require 'eaal'
    EAAL::API.new(key_id, v_code, scope)
  end

  def alliance_list
    begin
      connection.AllianceList
    rescue Exception => ex
      include LoggersHelper
      eve_api_log.warn ex.message
    end
  end

  def corporation_info(corporation_id)
    begin
      connection(scope: 'corp').CorporationSheet(:corporationID => corporation_id)
    rescue Exception => ex
      include LoggersHelper
      eve_api_log.warn ex.message
    end
  end

end

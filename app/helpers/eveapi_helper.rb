module EveApiHelper

  def connection(key_id='', v_code='', scope='eve')
    begin
      require 'eaal'

      @api = EAAL::API.new(key_id, v_code, scope)
    rescue Exception => ex
      require 'config/loggers'

      eveapi_log.info = ex.message
      @api = false
    end
  end

  def alliance_list
    if @api
      @api.AllianceList
    else
      false
    end
  end

end
module EveApiHelper
  require 'eaal'
  class ApiBadError < StandardError
  end

  class ApiOkError < StandardError
  end

  class EveApi
    def initialize(key_id='', v_code='')
      @key_id, @v_code = key_id, v_code
    end

    def connection(scope)
      EAAL.cache = EAAL::Cache::FileCache.new
      EAAL::API.new(@key_id, @v_code, scope)
    end

    def api_call(method, scope: 'eve', **kwargs)
      begin
        connection(scope).public_send(method, kwargs)
      rescue EAAL::Exception::HTTPError
        raise ApiOkError
      end
    end

    # Unauthorized requests
    def alliance_list
      api_call(:AllianceList)
    end

    def corporation_info(corporation_id)
      api_call(:CorporationSheet, scope: 'corp', :corporationID => corporation_id)
    end

    def character_info(character_id)
      api_call(:CharacterInfo, :characterID => character_id)
    end

    # Authorized requests
    def key_info
      api_call(:APIKeyInfo, scope: 'account')
    end

    def corporation_member_tracking(extended=false)
      if extended
        api_call(:MemberTracking, scope: 'corp', :extended => 'True')
      else
        api_call(:MemberTracking, scope: 'corp')
      end
    end
  end
end

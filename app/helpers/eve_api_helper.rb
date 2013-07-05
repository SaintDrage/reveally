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

    def connection(scope: 'eve')
      EAAL::API.new(@key_id, @v_code, scope)
    end

    # Unauthorized requests
    def alliance_list
      connection.AllianceList
    end

    def corporation_info(corporation_id)
      connection(scope: 'corp').CorporationSheet(:corporationID => corporation_id)
    end

    def character_info(character_id)
      connection.CharacterInfo(:characterID => character_id)
    end

    # Authorized requests
    def key_info
      #connection(scope: 'account').APIKeyInfo
      catch_exceptions "connection(scope: 'account').APIKeyInfo"
    end

    def corporation_member_tracking(extended=false)
      if extended
        connection(scope: 'corp').MemberTracking(:extended => 'True')
      else
        connection(scope: 'corp').MemberTracking
      end
    end

    def catch_exceptions(code)
      begin
        eval(code)
      rescue EAAL::Exception::HTTPError => e
        raise ApiBadError.new e.message
      end
    end
  end
end

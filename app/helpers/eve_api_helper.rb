module EveApiHelper
  class EveApi
    def initialize(key_id='', v_code='')
      @key_id, @v_code = key_id, v_code
    end

    def connection(scope: 'eve')
      require 'eaal'
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
    def corporation_member_tracking(extended=false)
      if extended
        connection(scope: 'corp').MemberTracking(:extended => 'True')
      else
        connection(scope: 'corp').MemberTracking
      end
    end
  end
end

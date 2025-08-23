module Warden
  module Strategies
    class GuestGroupAuthenticatable < Base
      def valid?
        # Check if this request should use guest group authentication
        params['passphrase'].present? && params['guest_group_id'].present?
      end

      def authenticate!
        guest_group_id = params['guest_group_id']
        passphrase = params['passphrase']
        
        guest_group = GuestGroup.find_by(id: guest_group_id)
        
        if guest_group&.authenticate_passphrase(passphrase)
          # Mark the authentication method on the guest_group object
          guest_group.define_singleton_method(:authentication_method) { 'guest_group' }
          
          success!(guest_group)
        else
          fail!("Invalid guest group or passphrase")
        end
      end
    end
  end
end

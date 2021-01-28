note
	description: "Summary description for {ALPHA_CFG_AUTHORIZATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ALPHA_CFG_AUTHORIZATION

inherit
	ALPHA_CONFIGURATION
		redefine
			default_create
		end

feature -- Initialization

	default_create
			--
		do
			Precursor
			create user_id.make_empty
			create password.make_empty
		end

feature -- Access

	user_id: STRING
			-- User id needed for authorization

	password: STRING
			-- Password associated with `user_id'

feature -- Element change

	decrypt
			--
		local
			--l_openssl: OPENSSL
		do
			--create l_openssl.make
			--l_openssl.decrypt (password)
			--if attached l_openssl.last_decrypted as la_decrypted then
			--	password := la_decrypted
			--end
		end
end

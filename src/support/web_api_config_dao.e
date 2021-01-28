note
	description: "Summary description for {WEB_API_CONFIG_DAO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	WEB_API_CONFIG_DAO [G -> ALPHA_CONFIGURATION create default_create end]

inherit
	ALPHA_CONFIGURATION_DAO [G]
		redefine
			make
		end

create
	make

feature {NONE} -- Initialization

	make (a_configuration: ALPHA_CFG_TCP_IP)
			--
		do
			create cfg_client.make (a_configuration)
			create {LINKED_LIST [G]} last_list.make
		end

feature -- Input

	load_for_component (a_component: ALPHA_COMPONENT)
			-- <Precursor>
		do
			last_list.wipe_out
			cfg_client.get_configuration (create {ALPHA_POINT_OF_SERVICE}.make ("3FD8A501-60CC-4F24-8567-6D6FA051BD2E"), a_component)
			if attached {G} cfg_client.last_configuration as la_configuration then
				last_list.extend (la_configuration)
			end
		end

	load_all
			-- N/A
		do
		end

feature -- Implementation

	cfg_client: CFG_WEB_API_HTTP_CLIENT [G]
			-- The client to access the config web api

end

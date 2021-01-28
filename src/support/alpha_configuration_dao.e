note
	description: "Summary description for {ALPHA_CONFIGURATION_DAO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ALPHA_CONFIGURATION_DAO [G -> ALPHA_CONFIGURATION]

inherit
	DAO [G]

feature -- Initialization

	make (a_configuration: ALPHA_CONFIGURATION)
			--
		do
		end

feature -- Input

	load_for_component (a_component: detachable ALPHA_COMPONENT)
			-- Load `a_component''s configuration.
		deferred
		end

end

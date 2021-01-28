note
	description: "Summary description for {ALPHA_CONFIGURATION_REF}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CONFIGURATION_REF

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
			create cfg
		end

feature -- Access

	cfg: ALPHA_CONFIGURATION

end

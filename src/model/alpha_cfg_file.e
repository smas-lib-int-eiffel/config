note
	description: "Summary description for {ALPHA_CFG_FILE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_FILE

inherit
	ALPHA_CONFIGURATION
		redefine
			default_create
		end

create
	default_create,
	make

feature -- Initialization

	default_create
			--
		do
			Precursor
			create path.make_empty
		end

feature -- Implementation

	path: STRING

end

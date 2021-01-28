note
	description: "Summary description for {ALPHA_CFG_PAYMENT_BRAND}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_PAYMENT_BRAND

inherit
	ALPHA_CONFIGURATION
		rename
			name as cfg_name
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
			create identification.make_empty
			create name.make_empty
			create entity_id.make_empty
		end

feature -- Implementation

	identification: STRING

	name: STRING

	entity_id: STRING

end

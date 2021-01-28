note
	description: "Summary description for {ALPHA_CFG_DATA_ACCESS_OBJECT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_DATA_ACCESS_OBJECT

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
			create class_name.make_empty
		end

feature -- Implementation

	class_name: STRING
		-- The class name of the DAO to by dynamically instantiated.

end

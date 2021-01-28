note
	description: "Summary description for {ALPHA_POINT_OF_SERVICE}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_POINT_OF_SERVICE

inherit
	IDENTIFIABLE

create
	make
	
feature -- Initialization

	make (an_identification: like identification)
			-- Create POS with `an_identification'
		do
			identification := an_identification
		ensure
			identifier_set: identification = an_identification
		end


feature -- Implementation

	identification: STRING
			-- The identifier with which a POS can be identified

	solutions: detachable CONTAINER [ALPHA_SOLUTION]
			-- A point of service has one or more alpha solutions

	hardware: detachable CONTAINER [ALPHA_COMPONENT_PHYSICAL]
			-- The hardware for the point of service

end -- class ALPHA_POINT_OF_SERVICE

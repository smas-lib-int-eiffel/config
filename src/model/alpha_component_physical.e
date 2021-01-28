note
	description: "Summary description for {ALPHA_COMPONENT_PHYSICAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_COMPONENT_PHYSICAL

inherit
	ALPHA_COMPONENT
		rename
			make as make_component
		end

create
	make

feature -- Creation

	make(a_identification: like identification; a_version: like version)
		do
			make_component(a_identification, a_version)
		end

end

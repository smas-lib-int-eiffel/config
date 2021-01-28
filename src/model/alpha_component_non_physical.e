note
	description: "Summary description for {ALPHA_COMPONENT_NON_PHYSICAL}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_COMPONENT_NON_PHYSICAL

inherit
	ALPHA_COMPONENT
		redefine
			components
		end

create
	make

feature -- Access

	components: detachable CONTAINER[ALPHA_COMPONENT_NON_PHYSICAL]
		-- The component components if any

end

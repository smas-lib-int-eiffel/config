note
	description: "Summary description for {ALPHA_COMPONENT_OWNER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_COMPONENT_OWNER

create
	make

feature -- Creation

	make
		do
			create solutions.make (0)
		end

feature -- Implementation

	solutions: ARRAYED_LIST [ALPHA_COMPONENT]
			-- The solutions for which the merchant has contracts with the company

end

note
	description: "Summary description for {ALPHA_SOLUTION_OWNER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_SOLUTION_OWNER

create
	make

feature -- Creation

	make
		do
			create solutions.make (0)
		end

feature -- Implementation

	solutions: ARRAYED_LIST [ALPHA_POINT_OF_SERVICE]
			-- The solutions for which the merchant has contracts with the company

end

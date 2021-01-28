note
	description: "Summary description for {ALPHA_SOLUTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ALPHA_SOLUTION

inherit
	ALPHA_COMPONENT_NON_PHYSICAL
		rename
			make as make_alpha_component_non_physical
		end

feature -- Creation

	make(a_identification: like identification; a_version: like version; a_behavioural_and_environmental_identification: like behavioural_and_environmental_identification)
			--
		do
			make_alpha_component_non_physical(a_identification, a_version)
			behavioural_and_environmental_identification := a_behavioural_and_environmental_identification
		end

feature -- Implementation

	behavioural_and_environmental_identification: UUID
		--

end

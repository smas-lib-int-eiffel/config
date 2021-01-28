note
	description: "Summary description for {ALPHA_COMPONENT_IDENTIFIER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_COMPONENT_IDENTIFIER

create
	identify

feature -- Basic operation

	identify (a_uuid: STRING; a_version: STRING)
			-- Identify a running component.
			-- Make result available in `last_identification' and `last_version'.
		local
			l_pattern_matcher: ALPHA_PATTERN_MATCHER
		do
			create l_pattern_matcher.make (a_uuid, a_version)
			if attached l_pattern_matcher as la_pattern_matcher then
				last_version := la_pattern_matcher.version_from_my_filename
				if attached last_version as la_last_version then
					last_version := la_last_version
				end
				last_identification := l_pattern_matcher.uuid_from_my_filename
			end
		end

feature -- Access

	last_identification: detachable STRING
			-- Identification found by last invocation of `identify'

	last_version: detachable STRING
			-- Version found by last invocation of `identify'

end

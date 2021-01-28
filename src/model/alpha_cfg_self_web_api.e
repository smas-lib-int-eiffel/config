note
	description: "Summary description for {ALPHA_CFG_SELF_WEB_API}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_SELF_WEB_API

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
			create api_version.make_empty
		end

feature -- Implementation

	api_version: STRING
		-- The Web API version, to be used in the path part of the URI's
		-- In specificational format for a general Web API: scheme://base_url[:port]/[version]/resource_name_in_plural/any_templates

		-- Example FTG Web API: http://localhost:9093/v1/transactions/0001052018040314174800000000007
		--                                            ^
		--                                            \---- version = v1

end

note
	description: "Summary description for {BOOTSTRAP_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	BOOTSTRAP_CONFIGURATION

inherit
	ALPHA_CONFIGURATION
		redefine
			default_create
		end

feature -- Initialization

	default_create
			--
		do
			Precursor
			create api
			create file
			if attached {LIST [ALPHA_CONFIGURATION]} configurations as la_configurations then
				la_configurations.extend (api)
				la_configurations.extend (file)
			end
		end

feature -- Access

	api: ALPHA_CFG_DATA_ACCESS_OBJECT
			--Configuration via web api

	file: ALPHA_CFG_DATA_ACCESS_OBJECT
			--Configuration via local file

end

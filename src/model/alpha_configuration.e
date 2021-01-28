note
	description: "Summary description for {ALPHA_CONFIGURATION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CONFIGURATION

inherit

	ANY
		redefine
			default_create
		end

feature -- Initialization

	default_create
			--
		do
			Precursor
			create type.make_empty
			create name.make_empty
			create version.make_empty
			create {LINKED_LIST [ALPHA_CONFIGURATION]} configurations.make
		end

	make (a_name: like name)
			--
		do
			default_create
			name := a_name
		end

feature -- Element change

	set_name (a_name: like name)
			--
		do
			name := a_name
		end

feature -- Implementation

	type: STRING
			--

	name: STRING
			-- The name of the configuration

	configurations: detachable CONTAINER [ALPHA_CONFIGURATION]
			-- Sub configurations

	version: detachable STRING
			-- The version of the configuration

end

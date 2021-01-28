note
	description: "Summary description for {ALPHA_COMPONENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ALPHA_COMPONENT

inherit
	IDENTIFIABLE
		redefine
			identification
		end

feature -- Creation

	make( a_id: like identification; a_version: like version)
		do
			identification := a_id
			version := a_version

			create name.make_empty
		ensure
			has_correct_identification: identification = a_id
			has_correct_version: version = a_version
		end

	make_with_components( a_id: like identification; a_version: like version; a_components: like components)
		do
			make(a_id, a_version)
			--create components.make_from_array (a_components.to_array)
			components := a_components
		end

feature -- Implementation

	name : STRING
			-- Name of the component

	components: detachable CONTAINER[ALPHA_COMPONENT]
		-- The component components if any

	has_component: BOOLEAN
			-- True if at least one component is in components.
		do
			if attached components as l_components then
				Result := not l_components.is_empty
			end
		end

	identification: UUID
			-- The identification of the component

	version: STRING
			-- The version of the component

	configuration: detachable ALPHA_CONFIGURATION
			-- The configuration composite

feature -- Element change

	correct_version
			-- Reset last 2 numbers of `version' to 0 (1.0.1.2 -> 1.0.0.0)
		local
			l_third_dot_index: INTEGER
			l_second_dot_index: INTEGER
		do
			if not version.is_empty then
				l_third_dot_index := version.last_index_of ('.', version.count)
				l_second_dot_index := version.last_index_of ('.', l_third_dot_index - 1)
				version.replace_substring ("0", l_third_dot_index + 1, version.count)
				version.replace_substring ("0", l_second_dot_index + 1, l_third_dot_index - 1)
			end
		end

	set_name (a_name: like name)
			--
		do
			name := a_name
		end

	set_configuration (a_configuration: like configuration)
			--
		do
			configuration := a_configuration
		end

end

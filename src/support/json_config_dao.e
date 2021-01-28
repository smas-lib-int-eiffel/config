note
	description: "Summary description for {JSON_CONFIG_DAO}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_CONFIG_DAO [G -> ALPHA_CONFIGURATION create default_create end]

inherit
	ALPHA_CONFIGURATION_DAO [G]
		redefine
			make
		end

create
	make,
	make_from_file

feature {NONE} -- Initialization

	make (a_configuration: ALPHA_CFG_FILE)
			--
		do
			make_from_file (a_configuration.path)
		end

	make_from_file (a_file_name: STRING)
			--
		do
			file_name := a_file_name
			create qualified_name.make_empty
			create {LINKED_LIST [G]} last_list.make
		end

feature -- Access

	file_name: STRING
			--

	qualified_name: STRING
			-- (with UUID and version)

feature -- Input

	load_for_component (a_component: detachable ALPHA_COMPONENT)
			-- <Precursor>
		local
			l_converter: JSON_TO_CONFIG_CONVERTER [G]
		do
			last_list.wipe_out
			qualified_name := file_name.twin
			if attached a_component as la_component then
				if not a_component.version.is_empty then
					qualified_name.precede ('_')
					qualified_name.prepend (a_component.version)
				end
				qualified_name.precede ('_')
				qualified_name.prepend (a_component.identification.out)
			end
			read_json_config_file (qualified_name)
			if attached last_json_config as la_config then
				create l_converter.do_convert (la_config)
				if attached l_converter.converted_object as la_object then
					last_list.extend (la_object)
				end
			end
		end

	load_all
			-- N/A
		do
		end

feature {NONE} -- Implementation

	last_json_object: detachable JSON_OBJECT
			-- Last json object read by `read_json_file'

	last_json_config: detachable JSON_OBJECT
			-- Last json config read by `read_json_config_file'

	read_json_file (fn: STRING)
			--
		local
			l_file: PLAIN_TEXT_FILE
			l_parser: JSON_PARSER
		do
			create l_file.make_with_name (fn)
			if l_file.exists then
				l_file.open_read
				l_file.readstream (l_file.count)
				l_file.close
				create l_parser.make_with_string (l_file.last_string)
				l_parser.parse_content
				if l_parser.is_parsed then
					last_json_object := l_parser.parsed_json_object
				else
					last_json_object := Void
				end
			end
		end

	read_json_config_file (fn: STRING)
			--
		do
			read_json_file (fn)
			if
				attached last_json_object as la_json_object and then
				attached {JSON_ARRAY} la_json_object.item ("configurations") as la_top and then
				attached {JSON_OBJECT} la_top [1] as la_top_first and then
				attached {JSON_ARRAY} la_top_first.item ("configurations") as la_sub and then
				attached {JSON_OBJECT} la_sub [1] as la_sub_first
			then
				last_json_config := la_sub_first
--				last_json_config := la_top_first
			else
				last_json_config := Void
			end
		end

end

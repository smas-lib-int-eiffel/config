note
	description: "Summary description for {ALPHA_PATTERN_MATCHER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_PATTERN_MATCHER

create
	make

feature -- Initialization

	make (a_uuid_c: STRING; a_version_c: STRING)
			-- Initialization for `Current'.
			-- constants of self (ALPHA_COMPONENT) are passed for use as control.
		do
			my_uuid_c := a_uuid_c
			my_version_c := a_version_c
			create uuid_generic
			create my_patt.make_empty
			create regular_expression.make
				--			parent_make (uuid_generic)
		end

feature -- implementation

	version_from_my_filename: STRING
			-- read my name and find version if not succesful
			-- look for alternative file in current directory with uuid and version
			-- corresponding with uuid and version of self (ALPHA_COMPONENT)
		do
			Result := info_from_my_filename (2, "[\_\.]{1}[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}")
		end

	info_from_my_filename (a_choice: INTEGER; a_pattern: STRING): STRING
			-- read my name and find version if not succesful
			-- look for alternative file in current directory with uuid and version
			-- corresponding with uuid and version of self (ALPHA_COMPONENT)
		local
			my_argument: ARGUMENTS_32
		do
			Result := ""
				-- introduce the pattern to the class object:
			regular_expression.compile (a_pattern)
			if regular_expression.is_compiled then
				create my_argument
				Result := info_from_file_name (my_argument.argument (0).as_string_8, a_pattern)
				if Result.is_empty then
					if a_choice = 1 then
						Result := uuid_from_my_directory
					else
						if a_choice = 2 then
							Result := version_from_my_directory
						end
					end
				end
				Result.prune_all_leading ('.')
				Result.prune_all_leading ('_')
				Result.to_upper
			end
		end

	uuid_from_my_filename: STRING
			-- read my name and find uuid if not succesful
			-- look for alternative file in current directory with uuid and version
			-- corresponding with uuid and version of self (ALPHA_COMPONENT)
		do
			Result := info_from_my_filename (1, "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}")
		end

	uuid_from_my_directory: STRING
			-- look for file in current directory with uuid
			-- corresponding with uuid and version of self (ALPHA_COMPONENT)
		local
			l_version: STRING
		do
			create l_version.make_empty
			create Result.make_empty
			if attached (create {FILE_UTILITIES}).file_names (".") as la_fnames then
					-- loop over the found filenames in the directory and find the one with the uuid.
				from
					la_fnames.start
				until
					la_fnames.off or else Result.is_equal (my_uuid_c) and l_version.is_equal (my_version_c)
				loop
					Result := uuid_from_file_name (la_fnames.item.out)
					l_version := version_from_file_name (la_fnames.item.out)
					l_version.prune_all_leading ('_')
					l_version.prune_all_leading ('.')
					Result.to_upper
					la_fnames.forth
				end
			end
		end

	version_from_my_directory: STRING
			-- look for alternative file in current directory with version
			-- corresponding with uuid and version of self (ALPHA_COMPONENT)
		local
			l_patt: STRING
		do
			create l_patt.make_empty
			create Result.make_empty
			if attached (create {FILE_UTILITIES}).file_names (".") as la_fnames then
					-- loop over the found filenames in the directory and find the one with the version
				from
					la_fnames.start
				until
					la_fnames.off or else l_patt.is_equal (my_uuid_c) and Result.is_equal (my_version_c)
				loop
					l_patt := uuid_from_file_name (la_fnames.item.out)
					Result := version_from_file_name (la_fnames.item.out)
					if not l_patt.is_empty and not Result.is_empty then
						Result.prune_all_leading ('.')
						Result.prune_all_leading ('_')
					end
					la_fnames.forth
				end
			end
		end

	uuid_from_file_name (a_file_name: STRING): STRING
			-- Pattern found in `a_file_name'
		local
			l_patt_split: STRING
			l_sarr: ARRAY [STRING_8]
		do
			Result := info_from_file_name (a_file_name, "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}")
		end

	version_from_file_name (a_file_name: STRING): STRING
			-- Version found in `a_file_name'
		do
			Result := info_from_file_name (a_file_name, "[\_\.][0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}\.[0-9]{1,4}")
		end

	info_from_file_name (a_file_name: STRING; a_pattern: STRING): STRING
			-- Info found in `a_file_name' according to `a_pattern'
		local
			l_patt_split: STRING
			l_sarr: ARRAY [STRING_8]
		do
			create Result.make_empty
			create l_patt_split.make_empty
				-- extract patt pattern x.x.x.x
				-- introduce the pattern to the class object:
			regular_expression.compile (a_pattern)
			if regular_expression.is_compiled then
				if attached a_file_name then
					regular_expression.match (a_file_name)
				end
				if regular_expression.has_matched then
					l_patt_split := regular_expression.subject.substring (regular_expression.captured_start_position (0), regular_expression.captured_end_position (0))
					l_sarr := regular_expression.split
				end
				if not l_patt_split.is_empty then
					Result := l_patt_split
				end
			end
		end

feature {NONE} -- attribute(s)

	my_patt: STRING

	uuid_generic: INTEGER_64

	my_uuid_c: STRING

	my_version_c: STRING

feature {NONE} -- Implementation

	regular_expression: RX_PCRE_REGULAR_EXPRESSION

end

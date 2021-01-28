note
	description: "Summary description for {CFG_LOG_FACILITY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CFG_LOG_FACILITY

inherit
	SHARED_LOG_FACILITY
		redefine
			write_error,
			write_information
		end

feature -- Basic operations

	log_correct_identity (a_uuid, a_version: STRING)
			-- Log that identity is correct.
		do
			write_information ("Correct identity (" + a_uuid + "/" + a_version + ")")
		end

	log_incorrect_identity (a_uuid, a_version: STRING)
			-- Log that identity is incorrect.
		do
			write_error ("Incorrect identity (" + a_uuid + "/" + a_version + ")")
		end

	log_config_not_found (a_type: STRING; a_detail: STRING)
			-- Log that no configuration was found for `a_type' / `a_detail'
		do
			write_information ("not found (" + a_type + " / " + a_detail + ")")
		end

feature -- Output

	write_error (msg: STRING)
			-- <Precursor>
		do
			Precursor (caption + msg)
		end

	write_information (msg: STRING)
			-- <Precursor>
		do
			Precursor (caption + msg)
		end

feature -- Implementation

	caption: STRING
			--
		do
			Result := "Configuration: "
		end

end

note
	description: "Components whose identities are checked on creation."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

deferred class
	ALPHA_COMPONENT_NON_PHYSICAL_IDENTIFIABLE

inherit
	ALPHA_COMPONENT_NON_PHYSICAL
		redefine
			default_create
		end

feature {NONE} -- Initialization

	default_create
			--
		do
				-- Remark:
				--      It is intended that The_id is a valid UUID.
				--      It is intended that the UUID will be generated automatically by an external configuration management system, so it can be
				--      assumed that the UUID will always be correct.
				--
				--      In the case of development the UUID is comming from a different source, like a execution program argument. This will be done
				--      manually in most cases and has a high risk of being wrong. Also when it is forgotten to supply the UUID manually, the
				--      application won't be able to run and even will crash with an exception.
				--      Currently this is by design, so the crash wil make the developmer aware of the fact that the running system does not have a valid UUID!
				--      In devlopment mode it is not necessary to have a version for the running component.
				--
				-- prepare data
			create identification.make_from_string (The_id)
			create version.make_from_string (The_version)
			make (identification, version)
				-- do the check
			check_identity (The_id, The_version)
				-- if check unsuccesful the program will not start.
		end

feature -- Basic operations

	check_identity (a_uuid_c: STRING; a_version_c: STRING)
			-- Compare constants of self (PP_COMPONENT) with name or references in the directory.
		local
			l_component_identifier: ALPHA_COMPONENT_IDENTIFIER
		do
			create l_component_identifier.identify (a_uuid_c, a_version_c)
			if
				attached l_component_identifier.last_identification as la_identification and then
				identification.out.is_equal (la_identification) and then
				attached l_component_identifier.last_version as la_version and then
				version.is_equal (la_version)
			then
				(create {CFG_LOG_FACILITY}).log_correct_identity (a_uuid_c, a_version_c)
			else
				(create {CFG_LOG_FACILITY}).log_incorrect_identity (a_uuid_c, a_version_c)
				(create {DEVELOPER_EXCEPTION}).raise
			end
		end

feature -- Constants

	The_id: STRING
			-- The id that should be present in the command name uuid oart
		deferred
		end

	The_version: STRING
			-- The id that should be present in the command name version part
		deferred
		end

end

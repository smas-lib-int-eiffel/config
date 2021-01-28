note
	description: "Summary description for {CFG_BOOTSTRAPPER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CFG_BOOTSTRAPPER [G -> ALPHA_CONFIGURATION create default_create end]

inherit
	INTERNAL

create
	make

feature {NONE} -- Initialization

	make (a_file_name: STRING)
			--
		do
			file_name := a_file_name
		end

feature -- Access

	file_name: STRING
			--

	last_configuration: detachable G
			-- Last configuration loaded by `load_configuration'

feature -- Basic operations

	load_configuration (a_component: ALPHA_COMPONENT)
			--
		local
			l_boot_dao: JSON_CONFIG_DAO [BOOTSTRAP_CONFIGURATION]
			l_cfg_dao: ALPHA_CONFIGURATION_DAO [ALPHA_CONFIGURATION]
		do
			a_component.correct_version
			create l_boot_dao.make_from_file (file_name)
			l_boot_dao.load_for_component (Void)
			if
				attached l_boot_dao.last_item as la_boot and then
				attached {LINKED_LIST [ALPHA_CONFIGURATION]} la_boot.api.configurations as la_configurations and then
				la_configurations.count > 0 and then
				attached {ALPHA_CFG_TCP_IP} la_configurations.first as la_cfg_tcp_ip
			then
				create {WEB_API_CONFIG_DAO [G]} l_cfg_dao.make (la_cfg_tcp_ip)
				l_cfg_dao.load_for_component (a_component)
				if attached {G} l_cfg_dao.last_item as la_configuration then
					last_configuration := la_configuration
				else
					(create {CFG_LOG_FACILITY}).log_config_not_found (la_cfg_tcp_ip.type, la_cfg_tcp_ip.base_url)
				end
			end
			if
				not attached last_configuration and then
				attached l_boot_dao.last_item as la_boot and then
				attached {LINKED_LIST [ALPHA_CONFIGURATION]} la_boot.file.configurations as la_configurations and then
				la_configurations.count > 0 and then
				attached {ALPHA_CFG_FILE} la_configurations.first as la_cfg_file
			then
				create {JSON_CONFIG_DAO [G]} l_cfg_dao.make_from_file (la_cfg_file.path)
				l_cfg_dao.load_for_component (a_component)
				if attached {G} l_cfg_dao.last_item as la_configuration then
					last_configuration := la_configuration
				else
					if attached {JSON_CONFIG_DAO [G]} l_cfg_dao as la_cfg_dao then
						(create {CFG_LOG_FACILITY}).log_config_not_found (la_cfg_file.type, la_cfg_dao.qualified_name)
					end
				end
			end
		end

	load_configuration_anonymous
			--
		local
			l_boot_dao: JSON_CONFIG_DAO [BOOTSTRAP_CONFIGURATION]
		do
			create l_boot_dao.make_from_file (file_name)
			l_boot_dao.load_all
			if
				attached l_boot_dao.last_item as la_boot and then
				attached {LINKED_LIST [ALPHA_CONFIGURATION]} la_boot.configurations as la_configurations
			then
				from
					la_configurations.start
				until
					last_configuration /= Void or else la_configurations.off
				loop
					if
						attached {ALPHA_CFG_DATA_ACCESS_OBJECT} la_configurations.item as la_dao and then
						attached {LIST [ALPHA_CONFIGURATION]} la_dao.configurations as la_dao_configurations and then
						attached new_dao (la_dao.class_name) as la_cfg_dao
					then
						la_cfg_dao.make (la_dao_configurations.first)
						la_cfg_dao.load_all
						if attached {G} la_cfg_dao.last_item as la_configuration then
							last_configuration := la_configuration
						end
					end
					la_configurations.forth
				end
			end
		end

	new_dao (a_class_name: STRING): detachable ALPHA_CONFIGURATION_DAO [ALPHA_CONFIGURATION]
			-- (problem with generic JSON_CONFIG_DAO !!!)
		local
			l_class_name: STRING
			l_dyn_type: INTEGER
			l_any: ANY
		do
			l_class_name := a_class_name.twin
			l_class_name.to_upper
			l_dyn_type := dynamic_type_from_string (l_class_name)
			l_any := new_instance_of (l_dyn_type)
			if attached {ALPHA_CONFIGURATION_DAO [ALPHA_CONFIGURATION]} l_any as la_any then
				Result := la_any
			end
		end

end

note
	description: "Summary description for {JSON_TO_CONFIG_CONVERTER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	JSON_TO_CONFIG_CONVERTER [G -> ALPHA_CONFIGURATION create default_create end]

inherit
	JSON_TO_EIFFEL_CONVERTER [G]
		redefine
			json_object_to_eiffel,
			new_container_item,
			index_of_field
		end

create
	do_convert

feature {NONE}	-- Implementation

	new_configuration (a_type: STRING): detachable ALPHA_CONFIGURATION
			--
		local
			l_type: STRING
			l_dyn_type: INTEGER
			l_any: ANY
		do
			l_type := a_type.twin
			l_type.to_upper
			l_dyn_type := dynamic_type_from_string (l_type)
			l_any := new_instance_of (l_dyn_type)
			if attached {ALPHA_CONFIGURATION} l_any as la_cfg then
				la_cfg.default_create
				Result := la_cfg
			end
		end

	json_object_to_eiffel (a_json_object: JSON_OBJECT; a_name: STRING; i: INTEGER; object: ANY)
			--
		do
			if i = 0 then
				unknow_field_name := a_name
				is_converted := False
			else
				if attached reference_field (i, object) as la_object then
					json_to_eiffel (a_json_object, la_object)
					if
						attached {ALPHA_CONFIGURATION} la_object as la_typed and then
						attached new_configuration (la_typed.type) as la_configuration
					then
						json_to_eiffel (a_json_object, la_configuration)
						set_reference_field (i, object, la_configuration)
					end
				end
			end
		end

	new_container_item (a_gdt: INTEGER; a_value: JSON_VALUE): detachable ANY
			--
		local
			l_inner: ANY
			l_name: STRING
		do
			l_inner := new_instance_of (a_gdt)
			if
				attached {ALPHA_CONFIGURATION} l_inner and then
				attached {JSON_OBJECT} a_value as la_value and then
				la_value.count = 1
			then
				create {ALPHA_CONFIGURATION_REF} l_inner
			end
			Result := eiffel_value (a_value, l_inner)
			if attached {ALPHA_CONFIGURATION_REF} Result as la_ref then
				Result := la_ref.cfg
				if attached {JSON_OBJECT} a_value as la_value then
					l_name := la_value.current_keys [1].item
					la_ref.cfg.set_name (l_name)
				end
			end
		end

	index_of_field (a_field_name: STRING; object: ANY): INTEGER
			--
		do
			Result := Precursor (a_field_name, object)
			if Result = 0 and then attached {ALPHA_CONFIGURATION_REF} object then
				Result := index_of_cfg_field
			end
		end

	index_of_cfg_field: INTEGER
			--
		local
			l_indexes: like field_indexes
		once
			l_indexes := field_indexes (create {ALPHA_CONFIGURATION_REF})
			Result := l_indexes.item ("cfg")
		end

end

note
	description: "Summary description for {CFG_WEB_API_HTTP_CLIENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	CFG_WEB_API_HTTP_CLIENT [G -> ALPHA_CONFIGURATION create default_create end]

inherit
	ALPHA_DEFAULT_HTTP_CLIENT

create
	make

feature -- Basic operations

	get_configuration (a_pos: detachable ALPHA_POINT_OF_SERVICE; a_component: ALPHA_COMPONENT)
			-- Get a configuration specified by its `identification'.
			-- Make result available in `last_configuration'.
		local
			l_request: STRING
		do
			l_request := "configurations"
			if attached a_pos as la_pos then
				l_request.append ("/" + la_pos.identification)
			end
			l_request.append ("/" + a_component.identification.out)
			l_request.append ("/" + a_component.version)
			send_get_request (l_request, Void, Void)
			update_last_configuration
		end

feature -- Access

	last_configuration: detachable G
			-- Result of last configuration related operation

feature {NONE} -- Implementation

	update_last_configuration
			--
		local
			l_converter: JSON_TO_CONFIG_CONVERTER [G]
		do
			if last_response_ok	then
				if attached config_root (json_response) as la_config_root then
					create l_converter.do_convert (la_config_root)
					if l_converter.is_converted then
						last_configuration := l_converter.converted_object
					else
						logger.log_no_valid_resource
					end
				end
			end
		end

	config_root (a_json_object: detachable JSON_OBJECT): detachable JSON_OBJECT
			--
		do
			if
				attached a_json_object as la_json_object and then
				attached {JSON_ARRAY} a_json_object.item ("configurations") as la_top and then
				attached {JSON_OBJECT} la_top [1] as la_top_first and then
				attached {JSON_ARRAY} la_top_first.item ("configurations") as la_sub and then
				attached {JSON_OBJECT} la_sub [1] as la_sub_first
			then
				Result := la_sub_first
			else
				Result := a_json_object
			end
		end

end

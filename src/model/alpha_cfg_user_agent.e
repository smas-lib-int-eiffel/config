note
	description: "Summary description for {ALPHA_CFG_USER_AGENT}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_USER_AGENT

inherit
	ALPHA_CONFIGURATION
		redefine
			default_create
		end

create
	default_create,
	make

feature -- Initialization

	default_create
			--
		do
			Precursor
			create redirect_resource
			create payment_view_resource
			create template.make_empty
			create fallback_language.make_empty
		end

feature -- Implementation

	redirect_resource: ALPHA_CFG_TCP_IP
			-- Configuration for redirect resource

	payment_view_resource: ALPHA_CFG_TCP_IP
			-- Configuration for payment view resource

	template: STRING
			-- The html which describes a payment page or
			-- plain text containing a valid and verified html
			-- document, with valid directives for the configured FTG web API version.

	fallback_language: STRING
			--	A payment page it is possible to be generated or rendered in at least one language,
			--	but often more than one language is available. The number of available languages depends on
			--	things like the chosen payment service provider, the contract between the customer using the
			--	a user agent based payments module and for example the languages a supplier (alpha) supports.
			--	This configuration item is used in cases a wrong or unknown language code is supplied during
			--	the execution of a user agent based payment. In the case a wrong language code is supplied,
			--	this system will fall back on the language specified in this item. This should a language that
			--	always is available for the point of service.

end

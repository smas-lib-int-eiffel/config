note
	description: "Summary description for {ALPHA_CFG_PAYMENT_SERVICE_PROVIDER}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_PAYMENT_SERVICE_PROVIDER

inherit
	ALPHA_CFG_AUTHORIZATION
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
--			create user_id.make_empty
--			create password.make_empty
			create payment_brands.make
		end

feature -- Access

	has_brand(a_brand: STRING): BOOLEAN
			-- True, when brand is available
		do
			from
				payment_brands.start
			until
				Result or payment_brands.after
			loop
				Result := payment_brands.item_for_iteration.name.is_equal (a_brand)
				payment_brands.forth
			end
		end

	brand_entity_id(a_brand: STRING): STRING
			-- Result, is entity of given, existing brand
		require
			brand_exists: has_brand (a_brand)
		do
			create Result.make_empty
			from
				payment_brands.start
			until
				not Result.is_empty or payment_brands.after
			loop
				if payment_brands.item_for_iteration.name.is_equal (a_brand) then
					Result := payment_brands.item_for_iteration.entity_id
				else
					payment_brands.forth
				end
			end
		end

--	user_id: STRING
--			-- The identification of the alpha company at the payment service provider

--	password: STRING
--			-- The password asscociated with the user_id

	entity_id: detachable STRING
			-- The global identification of the merchant channel at the payment service provider
			-- Void:
			--         means that it mandatory to choose a brand upfront in a pre-payment page and use this brand
			--         to fing the proper configured brand entity-d. That brand related entity wil then be used to retrieve
			--         transaction checkout and transaction result information from the payment service provider
			-- Not void:
			--         means that the payment channel can handle payment brands during the payment page is presented,
			--         in that case the customer won't have to make a choice for the payment brand in the pre-payment page.
			--         This is more or less an abnormal case and could be usefull for testing purposes, although obe could imagine
			--         that some merchant wants this kind of application.
			--

	payment_brands: LINKED_LIST [ALPHA_CFG_PAYMENT_BRAND]
			-- The brands for which the merchant has contracts with the payment service provider

end -- class ALPHA_CFG_PAYMENT_SERVICE_PROVIDER

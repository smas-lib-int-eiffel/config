note
	description: "Summary description for {ALPHA_ANY}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_ANY

inherit

	ANY

create
	make

feature -- initialization

	make (a_id: INTEGER; a_entity_version: STRING; a_deletion_date: DATE_TIME; a_begin_date: DATE; a_end_date: DATE)
		do
			id := a_id
			entity_version := a_entity_version
			deletion_date := a_deletion_date
			begin_date := a_begin_date
			end_date := a_end_date
		end

	get_from_id (a_id: INTEGER)
		do
		end

	get_from_date (a_date: DATE)
		do
		end

	set (a_id: INTEGER; a_entity_version: STRING; a_deletion_date: DATE_TIME; a_begin_date: DATE; a_end_date: DATE)
		do
		end

feature -- data declaration

	id: INTEGER
			-- must be automatically incremented

	entity_version: STRING

	deletion_date: detachable DATE_TIME

	begin_date: DATE

	end_date: DATE

end

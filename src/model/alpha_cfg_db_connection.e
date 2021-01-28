note
	description: "Summary description for {ALPHA_CFG_DB_CONNECTION}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_DB_CONNECTION

inherit
	ALPHA_CFG_AUTHORIZATION
		rename
			user_id as user_name
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
			create scheme.make_empty
			create server.make_empty
			create database.make_empty
			create db_connection_string.make_empty
			create version_.make_empty
		end

feature -- Access

	scheme: STRING
			-- Name or scheme of the database

	server: STRING
			-- Server or host or ip address of the location of the database.

	port: INTEGER
			-- Port on which the socket of the database is listening.

	database: STRING
			-- Name of the database

	db_connection_string: STRING
			-- Database connection string

	version_ : STRING
		--	Version if needed 

end -- class ALPHA_CFG_DB_CONNECTION

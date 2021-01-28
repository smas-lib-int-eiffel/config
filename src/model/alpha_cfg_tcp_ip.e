note
	description: "Summary description for {ALPHA_CFG_TCP_IP}."
	author: ""
	date: "$Date$"
	revision: "$Revision$"

class
	ALPHA_CFG_TCP_IP

inherit
	ALPHA_CONFIGURATION
		redefine
			default_create,
			version
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
			create base_url.make_empty
		end

feature -- Elememt change

	set_external_port(a_port_number: like external_port)
			-- Set the external port
		do
			external_port := a_port_number
		end

feature -- Access

	version: STRING
			--<Precursor>

    scheme: STRING
    	-- The scheme, consisting of a sequence of characters beginning with a letter and followed by any combination of letters, digits, plus (+),
    	-- period (.), or hyphen (-). Although schemes are case-insensitive, the canonical form is lowercase and documents that specify schemes
    	-- must do so with lowercase letters. It is followed by a colon (:). Examples of popular schemes include http(s), ftp, mailto, file, data, and irc.
    	-- URI schemes should be registered with the Internet Assigned Numbers Authority (IANA), although non-registered schemes are used in practice.

    base_url: STRING
		-- A "host", consisting of either a registered name (including but not limited to a hostname), or an IP address.
		-- IPv4 addresses must be in dot-decimal notation, and IPv6 addresses must be enclosed in brackets ([]).

    port: detachable INTEGER
		-- The port number on that the API should listen. The dynamic or private ports are those from 49152 through 65535,
		-- this is the range that should be used here. In case the web API uses the fast-cgi connector, this value will not be used,
		-- while then the webserver is responsible to hand out port numbers per used socket per fast-cgi process.

    external_port: detachable INTEGER
		-- The external port number for network context where Network Address Translation is used.

	versioned_authority: STRING
			-- Authority part of the server with version
		do
			Result := authority
			Result.append ("/" + version + "/")
		ensure
			slash_at_end: Result.ends_with ("/")
		end

	authority: STRING
			-- Authority part of the server
		note
			EIS: "name=Authority", "protocol=URI", "src=https://en.wikipedia.org/wiki/Uniform_Resource_Identifier#Examples"
		do
			Result := scheme + "://" + base_url
			if external_port /= 0 then
				Result.append (":" + external_port.out)
			end
		ensure
			no_slash_at_end: not Result.ends_with ("/")
		end

end -- class ALPHA_CFG_TCP_IP

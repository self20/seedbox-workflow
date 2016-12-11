#!/bin/bash
#
#variables
script="/tmp/seedbox-workflow"
"$script"/inc/variables.sh



# variable utilisateur majuscule
			USERMAJ=$(echo "$usersickrage" | tr "[:lower:]" "[:upper:]")
      
FONCPORT () {
	HISTO=$(wc -l < "$RUTORRENT"/histo.log)
	# shellcheck disable=SC2034
	PORT=$(( 5001+HISTO ))
}

      
      FONCRTCONF () {
	cat <<- EOF >> "$NGINXENABLE"/rutorrent.conf

		        location /$1 {
		                include scgi_params;
		                scgi_pass 127.0.0.1:$2;
		                auth_basic "seedbox";
		                auth_basic_user_file "$NGINXPASS/rutorrent_passwd_$3";
		        }
		}
	EOF
}


      
      

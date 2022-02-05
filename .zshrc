_username="%F{red}%n%f"
_at="%F{yellow}@%f"
_hostname="%F{green}%m%f"
_colon="%F{magenta}:%f"
_directory="%F{yellow}%~%f"
_bang="%F{white} $ %f"
        
export PROMPT="${_username}${_at}${_hostname}${_colon}${_directory}${_bang}"

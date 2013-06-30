# unsetting these paths will disable SysV integration in systemd
EXTRA_OECONF += "     --with-sysvinit-path= \
                      --with-sysvrcnd-path= \
" 

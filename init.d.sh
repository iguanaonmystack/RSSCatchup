#! /bin/sh 
# 
# Author:       Nick Murdoch <nick@nivan.net>. 
# 
#               Please remove the "Author" lines above and replace them 
#               with your own name if you copy and modify this script. 
#               
#               Sourced from
# http://groups.google.com/group/turbogears/browse_thread/thread/af07ba5360a28a95

set -e 

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin 
DESC="RSSCatchup" 
NAME="start-rsscatchup" 
DAEMON=/usr/bin/$NAME 
PIDFILE=/var/run/$NAME.pid 
CONFIG=/etc/rsscatchup

SCRIPTNAME=/etc/init.d/$NAME 

# Gracefully exit if the package has been removed. 
test -x $DAEMON || exit 0 

# Read config file if it is present. 
#if [ -r /etc/default/$NAME ] 
#then 
#       . /etc/default/$NAME 
#fi 

# 
#       Function that starts the daemon/service. 
# 
d_start() { 
        start-stop-daemon --start --pidfile $PIDFILE --make-pidfile --background --startas $DAEMON -- $CONFIG

} 

# 
#       Function that stops the daemon/service. 
# 
d_stop() { 
        start-stop-daemon --stop --pidfile $PIDFILE 

} 

# 
#       Function that sends a SIGHUP to the daemon/service. 
# 
d_reload() { 
        d_stop
        sleep 1
        d_start
} 

case "$1" in 
  start) 
        echo -n "Starting $DESC: $NAME" 
        d_start 
        echo "." 
        ;; 
  stop) 
        echo -n "Stopping $DESC: $NAME" 
        d_stop 
        echo "." 
        ;; 
  #reload) 
        # 
        #       If the daemon can reload its configuration without 
        #       restarting (for example, when it is sent a SIGHUP), 
        #       then implement that here. 
        # 
        #       If the daemon responds to changes in its config file 
        #       directly anyway, make this an "exit 0". 
        # 
        # echo -n "Reloading $DESC configuration..." 
        # d_reload 
        # echo "done." 
  #;; 
  restart|force-reload) 
        # 
        #       If the "reload" option is implemented, move the "force-reload" 
        #       option to the "reload" entry above. If not, "force-reload" is 
        #       just the same as "restart". 
        # 
        echo -n "Restarting $DESC: $NAME" 
        d_stop 
        sleep 1 
        d_start 
        echo "." 
        ;; 
  *) 
        # echo "Usage: $SCRIPTNAME {start|stop|restart|reload|force-reload}" >&2 
        echo "Usage: $SCRIPTNAME {start|stop|restart|force-reload}" >&2 
        exit 1 
        ;; 
esac

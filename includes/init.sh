#!/bin/sh
chown -R nginx:nginx /${H5_ROOT}
supervisord -c /usr/local/etc/supervisord.conf &
echo "Logs will displayed in 5 seconds"
sleep 5
tail -f /supervisord.log /var/log/nginx/privatebin_access.log /var/log/nginx/privatebin_error.log /var/log/nginx/privatebin.access.log
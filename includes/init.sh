#!/bin/sh
chown -R nginx:nginx /${H5_ROOT}
supervisord -c /usr/local/supervisord.conf &
echo "Logs will displayed in 5 seconds"
sleep 5
tail -f /supervisord.log /var/log/nginx/access.log /var/log/nginx/error.log /var/log/nginx/h5ai.access.log /var/log/nginx/h5ai.slow.log
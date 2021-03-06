#!/bin/sh
chown -R nginx:nginx /${H5_BASE}/_h5ai
find /${H5_BASE}/ -type d -exec chmod o+rx {} \;
find /${H5_BASE}/ -type f -exec chmod o+r {} \;
supervisord -c /usr/local/supervisord.conf &
echo "Logs will displayed in 5 seconds"
sleep 5
tail -f /supervisord.log /var/log/nginx/access.log /var/log/nginx/error.log /var/log/nginx/h5ai.access.log /var/log/nginx/h5ai.slow.log
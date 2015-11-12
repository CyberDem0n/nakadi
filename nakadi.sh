echo "starting gunicorn..."
gunicorn --workers 32 --worker-class eventlet --access-logfile - --bind 0.0.0.0:8081 nakadi.hack:application &

echo "starting nginx..."
nginx -v
nginx -c `pwd`/nginx.conf
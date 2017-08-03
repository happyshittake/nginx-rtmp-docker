#nginx-rtmp docker image

to set custom nginx conf just mount volume to /usr/local/nginx/conf/nginx.con e.g:
`h-v /host/path/nginx.conf:/etc/nginx/nginx.conf:`

it exposes port 1935
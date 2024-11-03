
docker run -d \
    --name portal-site_ingress-nginx \
    -v $(pwd)/config:/etc/nginx \
    -p 80:80 nginx:1.21.3
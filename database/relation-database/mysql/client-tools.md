

# Client

## DBVisualizer

Long Message:
Unable to load authentication plugin 'caching_sha2_password'.

https://medium.com/@orafaelreis/workaround-to-unable-to-load-authentication-plugin-caching-sha2-password-message-85ddf6a98611


## phpmyadmin

docker run --name myadmin -d -e PMA_HOST=dbhost -p 8080:80 phpmyadmin/phpmyadmin

http://www.lougu.net/2018/12/09/321.html

```sql
use mysql;

ALTER USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'P@ssw0rd';
ALTER USER 'root'@'127.0.0.1' IDENTIFIED WITH mysql_native_password BY 'P@ssw0rd';

FLUSH PRIVILEGES;
```



#!/bin/bash

echo -n "EG: domainName.co.za > ";
read domain;

echo "<VirtualHost *:80>
    ServerName $domain
    DirectoryIndex index.php index.html
    DocumentRoot /var/www/$domain/public/

    <Directory /var/www/$domain/public/>
        <LimitExcept GET POST>
             Require all denied
        </LimitExcept>
        Options -ExecCGI +FollowSymLinks -Includes -Indexes -MultiViews
        AllowOverride All
        php_admin_flag display_errors On
        php_value session.referer_check $domain
        php_value session.cookie_domain $domain
        RewriteEngine on
        RewriteCond %{REQUEST_FILENAME} !-f
        RewriteRule . index.php [L]
        Require all granted
    </Directory>
</VirtualHost>" >> /etc/apache2/sites-available/$domain.conf;

a2ensite $domain;

service apache2 restart;

echo "Created config: $domain";

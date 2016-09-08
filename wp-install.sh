#prompt for the location/name of the project
echo 'Provide name and location of wordpress project: (ie. /this/is/wp-project-name)'
read wpprojectname
#create structure of the site
mkdir $wpprojectname
mkdir $wpprojectname/web
mkdir $wpprojectname/database
mkdir $wpprojectname/config
cp -r database/ $wpprojectname/database/.
cp -r config/ $wpprojectname/config/.

#prompt for location of the wp-install file
#echo 'Provide a location of the Wordpress installation package (must be tar.gz file):'
#read wpinstallation
#unpack the installation file and move the contents in to project/web directory
#tar -xzvf $wpinstallation
#cp -r wordpress/* $wpprojectname/web/.
#rm -r wordpress/

#Download the latest copy of wordpress
wget http://wordpress.org/latest.zip

#unzip the installation
unzip latest.zip

newinstall="wordpress"

#Move over these directories from new install
cp -r $newinstall/* $wpprojectname/web/.


#create the mysql database
echo 'Provide a mysql user with valid privileges'
read mysqluser
echo "Provide mysql password for $mysqluser:"
read mysqlpassword
echo 'Provide a name for the database:'
read databasename
echo 'Provide a user for this database:'
read databaseuser
echo 'Provide a password for this user:'
read userpassword

#Create the mysql script 
sed "s/db_user/$databaseuser/g" wp-mysql-install.sql > temp.file
sed -i "s/db_name/$databasename/g" temp.file 
sed -i "s/db_password/$userpassword/g" temp.file

mysql -u $mysqluser -p$mysqlpassword < temp.file
rm -r temp.file

# Replace the wp-config.php file and enter in proper variables
cp $wpprojectname/web/wp-config-sample.php $wpprojectname/web/wp-config.php

sed -i "s/database_name_here/$databasename/g" $wpprojectname/web/wp-config.php
sed -i "s/username_here/$databaseuser/g" $wpprojectname/web/wp-config.php
sed -i "s/password_here/$userpassword/g" $wpprojectname/web/wp-config.php

# Move over the apache host file and replace the variables
echo 'What is the URL of your Wordpress site?'
read wp_url
echo 'What is the Server Admin email for this site?'
read contact_url
echo 'Where would you like to store your log files (ie. /var/log/apache2/)?'
read log_location

wp_root=$wpprojectname"/web"
wp_error_log=$log_location"/$wp_url-error.log"
wp_access_log=$log_location"/$wp_url-access.log"

sed "s/wp_url/$wp_url/g" $wpprojectname/config/wp-install.apache-config > $wpprojectname/config/$wp_url
sed -i "s/contact_url/$contact_url/g" $wpprojectname/config/$wp_url
sed -i "s/wp_root/$wp_root/g" $wpprojectname/config/$wp_url
sed -i "s/wp_error_log/$wp_error_log/g" $wpprojectname/config/$wp_url
sed -i "s/wp_access_log/$wp_access_log/g" $wpprojectname/config/$wp_url


cp $wpprojectname/config/$wp_url /etc/apache2/sites-available/.
ln -s /etc/apache2/sites-available/$wp_url /etc/apache2/sites-enabled/$wp_url



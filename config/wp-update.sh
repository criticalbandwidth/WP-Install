#Download the latest copy of wordpress
wget http://wordpress.org/latest.zip

#unzip the installation
unzip latest.zip

newinstall="wordpress"

#first get the location of the old installation
echo 'Where is the location of wordpress installation to be upgraded? (ie /var/vhosts/wp-install)'
read currentinstall

#Delete old wp-admin and wp-includes
rm -r $currentinstall/wp-admin
rm -r $currentinstall/wp-includes

#Move over these directories from new install
cp -r $newinstall/wp-admin $currentinstall/.
cp -r $newinstall/wp-includes $currentinstall/.

#Move over contents of wp-content from newinstall
cp -r $newinstall/wp-content $currentinstall/.

#Move over all loose files in root directory of installation
cp $newinstall/*.php $currentinstall/.
cp $newinstall/*.txt $currentinstall/.
cp $newinstall/*.html $currentinstall/.

rm -r $newinstall
rm latest.zip

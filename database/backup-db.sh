#this is a tool to backup the project database
#use it like this: sh backup-db.sh [database] [output file]
echo 'Backing up database'
mysqldump -u root -p --databases $1 > $2
echo 'Complete'

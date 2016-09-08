#program to restore a database from a sql file
#should be run like this:
#sh restore-db.sh [database] [restore file]
mysql -u root -p $1 < $2

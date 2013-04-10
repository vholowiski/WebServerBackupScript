#/bin/sh
#Script Configuration. Change these values
#remote_server = the server you want to back up - specify the address - IP or DNS name
remote_server="50.28.79.76"
#local_server = the server you are backing up to (the server that this script resides on)
mysql_username=""
mysql_password=""

#remote_server_files - the location of the files you want to back up on the remote server
remote_server_files="/home/vhosts"
#local_server_files - the location on the local server where the files will be backed up to
#note that you can store daily and monthly files in a different location
local_server_files_daily=""
local_server_files_monthly=""

#end script configuration
/usr/bin/rsync --verbose --stats --compress --rsh=/usr/bin/ssh --recursive --times --perms --links --delete root@$remote_server:$remote_server_files /var/rsync/rb >> /var/log/rsync_rb.log
/usr/bin/scp root@50.28.79.76:/backup/web_backups/backup.sql /root/backup.sql
/usr/bin/mysql -u $mysql_username -p$mysql_password < /root/backup.sql
tar -czf /root/full_backup_daily.tar.gz /var/rsync/rb/vhosts/* /root/backup.sql
rm -f /root/backups/full_backup_daily.9.tar.gz
mv /root/backups/full_backup_daily.8.tar.gz /root/backups/full_backup_daily.9.tar.gz
mv /root/backups/full_backup_daily.7.tar.gz /root/backups/full_backup_daily.8.tar.gz
mv /root/backups/full_backup_daily.6.tar.gz /root/backups/full_backup_daily.7.tar.gz
mv /root/backups/full_backup_daily.5.tar.gz /root/backups/full_backup_daily.6.tar.gz
mv /root/backups/full_backup_daily.4.tar.gz /root/backups/full_backup_daily.5.tar.gz
mv /root/backups/full_backup_daily.3.tar.gz /root/backups/full_backup_daily.4.tar.gz
mv /root/backups/full_backup_daily.2.tar.gz /root/backups/full_backup_daily.3.tar.gz
mv /root/backups/full_backup_daily.1.tar.gz /root/backups/full_backup_daily.2.tar.gz
mv /root/full_backup_daily.tar.gz /root/backups/full_backup_daily.1.tar.gz
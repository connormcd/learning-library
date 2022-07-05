Content of file mysqlbackup_user_grants.sql

GRANT RELOAD ON *.* TO 'mysqlbackup'@'%';
GRANT BACKUP_ADMIN, SELECT ON *.* TO 'mysqlbackup'@'%';
GRANT CREATE, INSERT, DROP, UPDATE ON mysql.backup_progress TO 'mysqlbackup'@'%';
GRANT CREATE, INSERT, SELECT, DROP, UPDATE ON mysql.backup_history TO 'mysqlbackup'@'%';
GRANT REPLICATION CLIENT ON *.* TO 'mysqlbackup'@'%';
GRANT SUPER ON *.* TO 'mysqlbackup'@'%';
GRANT PROCESS ON *.* TO 'mysqlbackup'@'%';
GRANT CREATE TEMPORARY TABLES on mysql.* TO 'mysqlbackup'@'%';

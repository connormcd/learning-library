#!/bin/sh
#set -vx

#
AUTHOR="Marco Carlessi (marco.carlessi@oracle.com)"
VERSION="2022.04"

# Packages required to install the software
# Set these variables with the file names available on https://edelivery.oracle.com
# MySQL Commercial Server 8.0.xx TAR for Generic Linux x86 (64bit)
export SRV_TAR='V1019324-01.zip'
# MySQL Database/Components 8.0.xx Yum Repository TAR for Oracle Linux / RHEL 8 x86 (64bit)
export REP_RPM='V1019344-01.zip'
# MySQL Enterprise Monitor Service Manager 8.0.xx for Linux x86 (64-bit)
export MEM_SRV='V1018801-01.zip'
# MySQL Enterprise Monitor Agent 8.0.xx for Linux x86 (64-bit)
export MEM_AGT='V1018804-01.zip'


#
# LICENSE: 
# This script is available for free and without support
# This script is created and have to be used to support MySQL workshops delivered by MySQL
# Part of this script may corrupt, destroy or change existing configuration:
# execute this script only in dedicated and empty training compartment (non production)!
#
# This script works with the wget.sh file created by https://edelivery.oracle.comi, which
# have to be manually retrieved by each person taht want to use it, accordingly with
# related rules and licenses
# 
# DON'T USE THIS SCRIPT OR PART OF IT FOR PRODUCTION ENVIRONMNETS OR AS OFFICIAL REFERENCE
#
# Disclaimer of Warranty.
#
# THERE IS NO WARRANTY FOR THE PROGRAM, TO THE EXTENT PERMITTED BY
# APPLICABLE LAW.  EXCEPT WHEN OTHERWISE STATED IN WRITING THE COPYRIGHT
# HOLDERS AND/OR OTHER PARTIES PROVIDE THE PROGRAM "AS IS" WITHOUT WARRANTY
# OF ANY KIND, EITHER EXPRESSED OR IMPLIED, INCLUDING, BUT NOT LIMITED TO,
# THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
# PURPOSE.  THE ENTIRE RISK AS TO THE QUALITY AND PERFORMANCE OF THE PROGRAM
# IS WITH YOU.  SHOULD THE PROGRAM PROVE DEFECTIVE, YOU ASSUME THE COST OF
# ALL NECESSARY SERVICING, REPAIR OR CORRECTION.
#
# Limitation of Liability.
#
# IN NO EVENT UNLESS REQUIRED BY APPLICABLE LAW OR AGREED TO IN WRITING
# WILL ANY COPYRIGHT HOLDER, OR ANY OTHER PARTY WHO MODIFIES AND/OR CONVEYS
# THE PROGRAM AS PERMITTED ABOVE, BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY
# GENERAL, SPECIAL, INCIDENTAL OR CONSEQUENTIAL DAMAGES ARISING OUT OF THE
# USE OR INABILITY TO USE THE PROGRAM (INCLUDING BUT NOT LIMITED TO LOSS OF
# DATA OR DATA BEING RENDERED INACCURATE OR LOSSES SUSTAINED BY YOU OR THIRD
# PARTIES OR A FAILURE OF THE PROGRAM TO OPERATE WITH ANY OTHER PROGRAMS),
# EVEN IF SUCH HOLDER OR OTHER PARTY HAS BEEN ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGES.
#
# Oracle Company is not responsible for any usage of this script
#

#####################################################
# CONFIGURABLE VARIABLES
#####################################################

# Databases
export WORLD_DB='https://downloads.mysql.com/docs/world-db.zip'
export EMPLOYEES_DB='https://github.com/datacharmer/test_db/archive/refs/heads/master.zip'

# OL8 mysql community repository rpm
export COMMUNITY_YUM_REPO='https://dev.mysql.com/get/mysql80-community-release-el8-1.noarch.rpm'

# Where locate labs software
export WORKSHOP_DIRECTORY='/workshop'


#####################################################
# FUNCTIONS TO EXECUTE THE LABS
#####################################################
#
# In case of lab change, rename a function, create a new function or update the content of the existing functions
# The menu will be changed automatically
#
# Format name of the function "lab<number>_<description_with_underscore_for_spaces>"
#

# Don't delete this line
#___START_LABS_FUNCTIONS___

# Variables common to scripts
export workshop_directory=${WORKSHOP_DIRECTORY}
export root_pwd='Welcome1!'
export user_pwd='Welcome1!'
export local_ip=$( oci-metadata -g privateIp | awk '/Private IP address:/ {print $NF}' )

export yum_repo_file="${workshop_directory}/linux/mysql80-community-release-el8-1.noarch.rpm"
export tar_for_installation="${workshop_directory}/linux/mysql-commercial-8.0.*-linux-glibc2.12-x86_64.tar.xz"
export mysql_shell_installation_file="${workshop_directory}/linux/mysql-shell-commercial-8.0.*.rpm"
export router_installation_file="${workshop_directory}/linux/mysql-router-commercial-8.0.*.x86_64.rpm"
export monitorpackage="${workshop_directory}/linux/monitor/mysqlmonitor-8.0.*-linux-x86_64-installer.bin"
export agentpackage="${workshop_directory}/linux/agent/mysqlmonitoragent-8.0.*-linux-x86-64bit-installer.bin"



lab2a_community_installation () {
	server="mysql1"
	ERR=0

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	# TEMORARY FOR A BUG IN COMMUNITY RPM
	echo "$(date) - INFO - Install MySQL Community repository on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} -o "StrictHostKeyChecking=no" opc@${server} "sudo rpm --import https://repo.mysql.com/RPM-GPG-KEY-mysql-2022")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during GPG signature download, temporary workaround for rpm bug (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Install MySQL Community repository on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} -o "StrictHostKeyChecking=no" opc@${server} "sudo yum install -y ${yum_repo_file}")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Community repository installation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Disable mysql default module ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo yum -y module disable mysql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during default mysql yum module disable (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Install MySQL community client and server on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo sudo yum install -y mysql mysql-server")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Community client and server installation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Enable MySQL community server startup on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo systemctl enable mysqld")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Community server enablement (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Start MySQL community server startup on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo systemctl start mysqld")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Community server start (${MSG})" |tee -a ${log_file} ; return $ERR ; fi


	echo "$(date) - INFO - Create script to setup MySQL Community server accounts" |tee -a ${log_file}

	community_configuration=$(mktemp --tmpdir=${TEMP_DIR} community_configuration_XXXXX)
cat << EOF > ${community_configuration}
#|/bin/bash
root_pwd=${root_pwd}
ERR=0

tmp_pwd=\$(sudo awk '/temporary password/ {print \$NF}' /var/log/mysqld.log)
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Root temporary password not found"; exit \$ERR ; fi

mysql -uroot --connect-expired-password -p\${tmp_pwd} -e "ALTER USER root@localhost IDENTIFIED BY '\${root_pwd}'"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Verify MySQL root password set" ; exit \$ERR ; fi

mysql -uroot -p\${root_pwd} -e "CREATE USER admin@'%' IDENTIFIED BY '\${root_pwd}'"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Verify MySQL admin user creation" ; exit \$ERR ; fi

mysql -uroot -p\${root_pwd} -e "GRANT ALL PRIVILEGES ON *.* TO admin@'%' WITH GRANT OPTION"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Verify MySQL admin grants" ; exit \$ERR ; fi

echo "OK"
exit \$ERR
EOF

	echo "$(date) - INFO - Copying the script ${community_configuration} to ${server}" |tee -a ${log_file}
	MSG=$( scp -i /home/opc/sshkeys/id_rsa_${server} ${community_configuration} opc@${server}:/tmp/ 2>&1 )
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during the copy of the file ${community_configuration} to ${server} (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Execute the script ${community_configuration} on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sh /tmp/$(basename ${community_configuration})")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during execution of the file ${community_configuration} on ${server} (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Remove the script ${community_configuration} from local temporary directory" |tee -a ${log_file}
	rm -f ${community_configuration}

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab2b_open_subnet_ports_to_access_mysql () {
	ERR=0

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	echo "$(date) - INFO - Create new rules file" |tee -a ${log_file}
	new_rules=$( mktemp -t new_rules_XXXXX )

	echo "$(date) - INFO - Retrive private subnet ocid" |tee -a ${log_file}
	vnic_ocid=$( oci-metadata -g vnicId | awk '/ocid1/ {print $NF}' )
	this_subnet_ocid=$( oci network vnic get --vnic-id ${vnic_ocid} --raw-output --query data.\"subnet-id\" )
	vcn_ocid=$( oci network subnet get --subnet-id ${this_subnet_ocid} --raw-output --query data.\"vcn-id\" )
	compartment_ocid=$( oci-metadata -g "compartmentId" | awk '/ocid1/ {print $NF}' )
	private_subnet_ocid=$( oci network subnet list --compartment-id ${compartment_ocid} --vcn-id ${vcn_ocid} --raw-output --query "max_by(data[?starts_with(\"display-name\", 'Private')].{ocid:id}, &ocid)" | jq -r '.ocid' )

	echo "$(date) - INFO - Private subnet: $private_subnet_ocid" >> ${log_file}
	echo "$(date) - INFO - Retrive private subnet security list ocid" |tee -a ${log_file}
	existing_security_lists_ocid=$( oci network subnet get --subnet-id ${private_subnet_ocid} --raw-output --query 'data."security-list-ids"' | sed 's/[[,"]//g' | sed 's/\]//g' )

	seclist_found=0
	for private_security_list_ocid in $( echo ${existing_security_lists_ocid} )
	do
		name=$( oci network security-list get --security-list-id "$private_security_list_ocid" --raw-output --query data.\"display-name\")
		if [ "$name" == "Security List for Private Subnet-mysqlvcn" ] ; then
			seclist_found=1
			break
		fi
	done
	if [ ${seclist_found} -eq 0 ] ; then
		ERR=1
		echo "$(date) - ERROR - Security list \"Security List for Private Subnet-mysqlvcn\" not found" |tee -a ${log_file}
		return $ERR
	fi
	
	
	echo "$(date) - INFO - Security list OCID ${private_security_list_ocid}" >> ${log_file}
	echo "$(date) - INFO - Save existing rules inside local file" |tee -a ${log_file}
	oci network security-list get --security-list-id ${private_security_list_ocid} --query data.\"ingress-security-rules\" > ${new_rules}

	echo "$(date) - INFO - Add new rules to local file" |tee -a ${log_file}

	cat << EOF >> ${new_rules}
[
      {
        "description": "Default MySQL ports",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": {
          "destination-port-range": {
            "max": 3306,
            "min": 3306
          },
          "source-port-range": null
        },
        "udp-options": null
      },
      {
        "description": "Default MySQL ports",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": {
          "destination-port-range": {
            "max": 33060,
            "min": 33060
          },
          "source-port-range": null
        },
        "udp-options": null
      },
      {
        "description": "Default MySQL ports",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": {
          "destination-port-range": {
            "max": 3307,
            "min": 3307
          },
          "source-port-range": null
        },
        "udp-options": null
      },
      {
        "description": "MySQL ports for custom installation",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": {
          "destination-port-range": {
            "max": 33070,
            "min": 33070
          },
          "source-port-range": null
        },
        "udp-options": null
      }
]
EOF

	echo "$(date) - INFO - Create ingress file" |tee -a ${log_file}
	ingress_security_list=$( mktemp -t ingress_security_list_XXXXX )
	cat $new_rules |jq -s 'add' > ${ingress_security_list}

	echo "$(date) - INFO - Update private security list with new rules" |tee -a ${log_file}
	MSG=$( oci network security-list update --force --security-list-id "${private_security_list_ocid}" --ingress-security-rules file://${ingress_security_list} )
	ERR=$?
	if [ $ERR -ne 0 ] ; then
		echo "$(date) - ERROR - Issues during security list update ($MSG)" |tee -a ${log_file}
	fi
	echo "$(date) - INFO - Delete temporary files" |tee -a ${log_file}
	rm ${new_rules}
	rm ${ingress_security_list}

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR

}



lab2c_detailed_installation () {
	ERR=0

	server=$1
	server=${server:='mysql1'}

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo "$(date) - INFO - Install ncurses-compat-libs on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -o "StrictHostKeyChecking=no" -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo yum install -y ncurses-compat-libs")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during the installation of ncurses-compat-libs (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Create OS group mysqlgrp on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo groupadd mysqlgrp")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during OS group mysqlgrp creation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Create OS user mysqluser on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo useradd -r -g mysqlgrp -s /bin/false mysqluser")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during OS user mysqluser creation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Assign mysqlgrp to opc user on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo usermod -a -G mysqlgrp opc")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during group assignment to opc (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Create directoy structure on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo mkdir /mysql/ /mysql/etc /mysql/data /mysql/log /mysql/temp /mysql/binlog")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during Directoy structure creation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Extract MySQL Enterprise tar on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "cd /mysql/ ; sudo tar xf ${tar_for_installation}")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Enterprise tar extraction (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Create symbolic link to MySQL Enterprise installation on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "cd /mysql/ ; sudo ln -s $( basename -s .tar.xz ${tar_for_installation} ) mysql-latest")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during symbolic link creation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Copy my.cnf for commercial installation on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo cp ${workshop_directory}/support/my.cnf.${server} /mysql/etc/my.cnf")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during my.cnf copy (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Set ownerships to MySQL Enterprise directories on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo chown -R mysqluser:mysqlgrp /mysql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues ownerships set (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Set permissions to MySQL Enterprise directories for script purposes on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo chmod -R 770 /mysql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during permissions set (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Initialize MySQL Enterprise on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo /mysql/mysql-latest/bin/mysqld --defaults-file=/mysql/etc/my.cnf --initialize --user=mysqluser")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL initialize (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Configure systemd startup for MySQL Enterprise on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo cp ${workshop_directory}/support/mysqld-advanced.service /usr/lib/systemd/system/ ; sudo chmod 644 /usr/lib/systemd/system/mysqld-advanced.service ; sudo systemctl enable mysqld-advanced.service")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during systemd configuration (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Start MySQL Enterprise on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo systemctl start mysqld-advanced.service")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL startup (${MSG})" |tee -a ${log_file} ; return $ERR ; fi



	echo "$(date) - INFO - Create script to setup MySQL Enterprise server accounts on ${server}" |tee -a ${log_file}

	enterprise_configuration=$(mktemp --tmpdir=${TEMP_DIR} enterprise_configuration_XXXXX)
cat << EOF > ${enterprise_configuration}
#|/bin/bash
root_pwd=${root_pwd}
ERR=0

tmp_pwd=\$(sudo awk '/temporary password/ {print \$NF}' /mysql/log/err_log.log)
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Root temporary password not found"; exit \$ERR ; fi

mysql -uroot -uroot -h127.0.0.1 -P3307 --connect-expired-password -p\${tmp_pwd} -e "ALTER USER root@localhost IDENTIFIED BY '\${root_pwd}'"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Verify MySQL root password set" ; exit \$ERR ; fi

mysql -uroot -h127.0.0.1 -P3307 -p\${root_pwd} -e "CREATE USER admin@'%' IDENTIFIED BY '\${root_pwd}'"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Verify MySQL admin user creation" ; exit \$ERR ; fi

mysql -uroot -h127.0.0.1 -P3307 -p\${root_pwd} -e "GRANT ALL PRIVILEGES ON *.* TO admin@'%' WITH GRANT OPTION"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Verify MySQL admin grants" ; exit \$ERR ; fi

mysql -uroot -h127.0.0.1 -P3307 -p\${root_pwd} -e 'INSTALL PLUGIN validate_password SONAME "validate_password.so"';
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Verify validate_password plugin installation" ; exit \$ERR ; fi

echo "OK"
exit \$ERR
EOF

	echo "$(date) - INFO - Copying the script ${enterprise_configuration} to ${server}" |tee -a ${log_file}
	MSG=$( scp -i /home/opc/sshkeys/id_rsa_${server} ${enterprise_configuration} opc@${server}:/tmp/ 2>&1 )
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during the copy of the file ${enterprise_configuration} to ${server} (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Execute the script ${enterprise_configuration} on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sh /tmp/$(basename ${enterprise_configuration}) 2>&1")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during execution of the file ${enterprise_configuration} on ${server} (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Remove the script ${enterprise_configuration} from local temporary directory" |tee -a ${log_file}
	rm -f ${enterprise_configuration}

	echo "$(date) - INFO - Update PATH on server {server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "echo 'export PATH=/mysql/mysql-latest/bin:\$PATH' >> /home/opc/.bashrc")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during PATH update(${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Set MySQL client prompt with MYSQL_PS1 variable" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "echo 'export MYSQL_PS1=\"\\\\u on \\\\h>\\\\_\"' >> /home/opc/.bashrc")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL client prompt set (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab2d_verify_installation_and_install_test_databases () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo "$(date) - INFO - Load example databases (world)" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -P3307 -h ${server} < ${workshop_directory}/databases/world/world.sql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during load of world database (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Load example databases (employees)" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "cd ${workshop_directory}/databases/employees ; mysql -uadmin -p${root_pwd} -P3307 -h ${server} < ./employees.sql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during load of world employees database (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Remove community server and client" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo yum remove -y mysql-server mysql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during remove of community server and client (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab2e_MySQL_Shell () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo "$(date) - INFO - Install MySQL Shell" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo sudo yum install -y ${mysql_shell_installation_file}")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during remove of community server and client (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab3a_database_design () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Some queries" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -P3307 -h ${server} -P 3307 -e 'use world; CREATE TABLE if not exists poi (x Int, y INT, z INT); alter table poi add id bigint; ALTER TABLE poi ADD PRIMARY KEY (id); create table city_part as select * from city'")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during some queries execution (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Create indexes" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -P3307 -h ${server} -P 3307 -e 'use world; CREATE INDEX myidindex ON city_part (ID); CREATE INDEX myccindex ON city_part (CountryCode)'")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during create indexes (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Delete some data" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -P3307 -h ${server} -P 3307 -e 'use world; ALTER TABLE city_part DROP COLUMN Population; ALTER TABLE city_part DROP COLUMN CountryCode'")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during delete some data (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Optimize table" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -P3307 -h ${server} -P 3307 -e 'use world; OPTIMIZE TABLE city_part'")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during optimize table (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Analyze table" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -P3307 -h ${server} -P 3307 -e 'use world; ANALYZE TABLE city_part'")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during analyze table (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "use world; ALTER TABLE world.city_part PARTITION BY HASH (id) PARTITIONS 5"

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab3b_MySQL_JSON_datatype () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo "$(date) - INFO - Create script for json lab" |tee -a ${log_file}

	json_lab=$(mktemp --tmpdir=${TEMP_DIR} json_lab_XXXXX)

	cat << EOF > ${json_lab}
#|/bin/bash
root_pwd=${root_pwd}
ERR=0

mysql -uadmin -p\${root_pwd} -P3307 -h ${server} -e "CREATE DATABASE json_test; CREATE TABLE json_test.jtest (id bigint NOT NULL AUTO_INCREMENT, doc JSON, PRIMARY KEY (id))"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during json_test database and jtest table creation" ; exit \$ERR ; fi

printf "INSERT INTO json_test.jtest(doc) VALUE('{\"A\": \"hello\", \"b\": \"test\", \"c\": {\"hello\": 1}}')" | mysql -uadmin -h ${server} -P3307 -p${root_pwd}
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during first json documents insert" ; exit \$ERR ; fi
printf "INSERT INTO json_test.jtest(doc) VALUE('{\"b\": \"hello\"}'),('{\"c\": \"help\"}')" | mysql -uadmin -h${server} -P3307 -p${root_pwd}
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during second json documents insert" ; exit \$ERR ; fi

mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e 'alter table json_test.jtest add column gencol CHAR(7) AS (doc->"$.b")'
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during alter table json_test" ; exit \$ERR ; fi

mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE INDEX myvirtindex ON json_test.jtest(gencol)"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during CREATE INDEX on json_test.jtest" ; exit \$ERR ; fi

exit \$ERR
EOF

	echo "$(date) - INFO - Copying the script ${json_lab} to ${server}" |tee -a ${log_file}
	MSG=$( scp -i /home/opc/sshkeys/id_rsa_${server} ${json_lab} opc@${server}:/tmp/ 2>&1 )
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during the copy of the file ${json_lab} to ${server} (${MSG})" |tee -a ${log_file} ; return $EERR ; fi

	echo "$(date) - INFO - Execute the script ${json_lab} on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sh /tmp/$(basename ${json_lab})")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during execution of the file ${json_lab} on ${server} (${MSG})" |tee -a ${log_file} ; return $$ERR ; fi

	echo "$(date) - INFO - Remove the script ${json_lab} from local temporary directory" |tee -a ${log_file}
	rm -f ${json_lab}

	echo
	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab3c_MySQL_Document_Store () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo "$(date) - INFO - Create script for document store lab" |tee -a ${log_file}

	docstore_lab=$(mktemp --tmpdir=${TEMP_DIR} docstore_lab_XXXXX)

	cat << EOF > ${docstore_lab}
#|/bin/bash
root_pwd=${root_pwd}
ERR=0

mysqlsh admin@${server}:33070 -p${root_pwd} -e "session.createSchema('test')"
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during schema creation" ; exit \$ERR ; fi

mysqlsh admin@${server}:33070 -p${root_pwd} -i -e 'var db = session.getSchema("test"); db.createCollection("posts"); db.posts.add({"title":"MySQL 8.0 rocks", "text":"My first post!", "code": "42"}); db.posts.add({"title":"Polyglot database", "text":"Developing both SQL and NoSQL applications"})'
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during collection creation and insert of some docs" ; exit \$ERR ; fi

mysqlsh admin@${server}:33070 -p${root_pwd} -i -e 'var db = session.getSchema("test"); db.posts.modify("title = '\''MySQL 8.0 rocks'\''").set("title", " MySQL 8.0 rocks!!!"); db.posts.createIndex('\''myIndex'\'', {fields: [{field: "$.title", type: "TEXT(20)"}]} )'
ERR=\$?
if [ \$ERR -ne 0 ] ; then echo "Problems during some queries execution" ; exit \$ERR ; fi

exit \$ERR
EOF

	echo "$(date) - INFO - Copying the script ${docstore_lab} to ${server}" |tee -a ${log_file}
	MSG=$( scp -i /home/opc/sshkeys/id_rsa_${server} ${docstore_lab} opc@${server}:/tmp/ 2>&1 )
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during the copy of the file ${docstore_lab} to ${server} (${MSG})" |tee -a ${log_file} ; return $EERR ; fi

	echo "$(date) - INFO - Execute the script ${docstore_lab} on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sh /tmp/$(basename ${docstore_lab})")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during execution of the file ${docstore_lab} on ${server} (${MSG})" |tee -a ${log_file} ; return $$ERR ; fi

	echo "$(date) - INFO - Remove the script ${docstore_lab} from local temporary directory" |tee -a ${log_file}
	rm -f ${docstore_lab}

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab4a_users_management () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo "$(date) - INFO - Install MySQL client and Shell" |tee -a ${log_file}
	sudo yum -y install ${workshop_directory}/linux/client/*.rpm

	echo
	echo "$(date) - INFO - Create user appuser@'${local_ip}'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE USER 'appuser'@'${local_ip}' IDENTIFIED BY '${user_pwd}'"

	echo
	echo "$(date) - INFO - Grant privileges to appuser@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "GRANT ALL PRIVILEGES ON world.* TO 'appuser'@'${local_ip}'"

	echo
	echo "$(date) - INFO - Revoke select on world from appuser@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "REVOKE SELECT ON world.* FROM 'appuser'@'${local_ip}'"

	echo
	echo "$(date) - INFO - Revoke usage from appuser@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "REVOKE USAGE ON *.* FROM 'appuser'@'${local_ip}'"

	echo
	echo "$(date) - INFO - Revoke all privileges from appuser@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'appuser'@'${local_ip}'"

	echo
	echo "$(date) - INFO - Grant all privileges to appuser@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "GRANT ALL PRIVILEGES ON world.* TO 'appuser'@'${local_ip}'"

	echo
	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab4b_MySQL_roles () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Create user appuser2@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE USER 'appuser2'@'%' IDENTIFIED BY '${user_pwd}'"

	echo
	echo "$(date) - INFO - Create role app_read" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE ROLE 'app_read'"

	echo
	echo "$(date) - INFO - Grant privileges to role app_read" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e 'GRANT SELECT ON world.* TO "app_read"'

	echo
	echo "$(date) - INFO - Assign role app_read to appuser2@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "GRANT 'app_read' TO 'appuser2'@'%'"

	echo
	echo "$(date) - INFO - Set default role for appuser2@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "ALTER USER 'appuser2'@'%' DEFAULT ROLE 'app_read'"

	echo
	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab4c_MySQL_Enterprise_Firewall_account_profiles () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Load MySQL Firewall" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -h ${server} -P 3307 < /mysql/mysql-latest/share/linux_install_firewall.sql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Firewall load (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Create user fwtest@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE USER 'fwtest'@'%' IDENTIFIED BY '${user_pwd}'"

	echo
	echo "$(date) - INFO - Grant privileges to fwtest@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "GRANT ALL PRIVILEGES ON world.* TO 'fwtest'@'%'"

	echo
	echo "$(date) - INFO - Firewall in recording mode" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_set_firewall_mode('fwtest@%', 'RECORDING')"

	echo
	echo "$(date) - INFO - Some queries..." |tee -a ${log_file}
	mysql -ufwtest -p${user_pwd} -h ${server} -P 3307 -e "USE world; SELECT * FROM city limit 25; SELECT Code, Name, Region FROM country WHERE population > 200000" 1> /dev/null

	echo
	echo "$(date) - INFO - Firewall in protecting mode" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_set_firewall_mode('fwtest@%', 'PROTECTING')"

	echo
	echo "$(date) - INFO - Some queries..." |tee -a ${log_file}
	mysql -ufwtest -p${user_pwd} -h ${server} -P 3307 -e "USE world; SELECT * FROM city limit 25; SELECT Code, Name, Region FROM country WHERE population > 200000; SELECT * FROM countrylanguage; SELECT Code, Name, Region FROM coun
try WHERE population > 500000; SELECT Code, Name, Region FROM country WHERE population > 200000 or 1=1" 1> /dev/null

	echo
	echo "$(date) - INFO - Firewall in detecting (and log verbosity changed)" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_set_firewall_mode('fwtest@%', 'DETECTING'); SET GLOBAL log_error_verbosity=3"

	echo
	echo "$(date) - INFO - Some queries..." |tee -a ${log_file}
	mysql -ufwtest -p${user_pwd} -h ${server} -P 3307 -e "SELECT Code, Name, Region FROM world.country WHERE population > 200000 or 1=1" 1> /dev/null

	echo
	echo "$(date) - INFO - Firewall off for fwtest@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_set_firewall_mode('fwtest@%', 'OFF')"


	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab4d_MySQL_Enterprise_Firewall_group_profiles () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Create user fwtest2@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE USER 'fwtest2'@'%' IDENTIFIED BY '${user_pwd}'"

	echo
	echo "$(date) - INFO - Grant privileges to fwtest2@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "GRANT ALL PRIVILEGES ON world.* TO 'fwtest'@'%'"

	echo
	echo "$(date) - INFO - Grant FIREWALL_ADMIN and FIREWALL_EXEMPT privileges to admin@'%'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "GRANT FIREWALL_ADMIN, FIREWALL_EXEMPT on *.* to admin@'%'"

	echo
	echo "$(date) - INFO - Create group profile fwgrp in recording mode" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_set_firewall_group_mode('fwgrp', 'RECORDING')"

	echo
	echo "$(date) - INFO - Assign fwtest2 to fwgrp group" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_firewall_group_enlist('fwgrp', 'fwtest@%')"

	echo
	echo "$(date) - INFO - Some queries..." |tee -a ${log_file}
	mysql -ufwtest -p${user_pwd} -h ${server} -P 3307 -e "USE world; SELECT * FROM city limit 25; SELECT Code, Name, Region FROM country WHERE population > 200000" 1> /dev/null

	echo
	echo "$(date) - INFO - Firewall in protecting mode" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_set_firewall_group_mode('fwgrp', 'PROTECTING')"

	echo
	echo "$(date) - INFO - Some queries..." |tee -a ${log_file}
	mysql -ufwtest -p${user_pwd} -h ${server} -P 3307 -e "USE world; SELECT * FROM city limit 25; SELECT Code, Name, Region FROM country WHERE population > 200000; SELECT * FROM countrylanguage; SELECT Code, Name, Region FROM coun
try WHERE population > 500000; SELECT Code, Name, Region FROM country WHERE population > 200000 or 1=1" 1> /dev/null

	echo
	echo "$(date) - INFO - Firewall off for fwgrp" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CALL mysql.sp_set_firewall_group_mode('fwgrp', 'OFF')"


	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab4e_MySQL_Enterprise_Audit () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Set audit in my.cnf" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sed -i 's/plugin-load=thread_pool.so/plugin-load=thread_pool.so;audit_log.so/g' /mysql/etc/my.cnf")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Audit set inside my.cnf (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Set audit variables in my.cnf" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "echo 'audit_log=FORCE_PLUS_PERMANENT' >> /mysql/etc/my.cnf ; echo 'audit_log_rotate_on_size=20971520' >> /mysql/etc/my.cnf ; echo 'audit_log_policy=Login' >> /mysql/etc/my.cnf")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during audit variables set inside my.cnf (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Set audit variables in my.cnf" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo systemctl restart mysqld-advanced")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during audit variables set inside my.cnf (${MSG})" |tee -a ${log_file} ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab4f_data_Masking_and_de_identification () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Install data masking plugin" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "INSTALL PLUGIN data_masking SONAME 'data_masking.so'"

	echo "$(date) - INFO - Install data masking functions" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE FUNCTION gen_range RETURNS INTEGER SONAME 'data_masking.so'; CREATE FUNCTION gen_rnd_email RETURNS STRING SONAME 'data_masking.so'; CREATE FUNCTION gen_rnd_us_phone RETURNS STRING SONAME 'data_masking.so'; CREATE FUNCTION mask_inner RETURNS STRING SONAME 'data_masking.so'; CREATE FUNCTION mask_outer RETURNS STRING SONAME 'data_masking.so';"

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab5a_logical_backup___mysqldump () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Create export directory on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo mkdir -p /mysql/exports ; sudo chown mysqluser:mysqlgrp /mysql/exports/ ; sudo chmod 770 /mysql/exports/")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during export directory (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Export all databases" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysqldump -uadmin -p${root_pwd} -h${server} -P3307 --single-transaction --events --routines --flush-logs --all-databases > /mysql/exports/full.sql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during export (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Export employees database" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysqldump -uadmin -p${root_pwd} -h${server} -P3307 --single-transaction --set-gtid-purged=OFF --databases employees > /mysql/exports/employees.sql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during employees database export (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Drop and create employees database" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "DROP DATABASE employees; CREATE DATABASE employees"

	echo
	echo "$(date) - INFO - Import employees database" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysql -uadmin -p${root_pwd} -h ${server} -P 3307 employees < /mysql/exports/employees.sql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during import of employees database (${MSG})" |tee -a ${log_file} ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab5c_MySQL_Enterprise_Backup () {
	ERR=0
	server='mysql1'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	
	echo
	echo "$(date) - INFO - Create backup directory on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo mkdir -p /backupdir/full /backupdir/compressed")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during backup directory creation (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Change ownership of backup directory on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo chown -R mysqluser:mysqlgrp /backupdir")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during ownership change of backup directory (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Set permissions of backup directory on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo chmod 770 -R /backupdir")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during set permissions of backup directory (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Create backup user" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 -e "CREATE USER 'mysqlbackup'@'%' IDENTIFIED BY '${user_pwd}'"
	mysql -uadmin -p${root_pwd} -h ${server} -P 3307 < ${workshop_directory}/support/mysqlbackup_user_grants.sql

	echo
	echo "$(date) - INFO - Full backup" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=mysqlbackup --password=${user_pwd} --backup-dir=/backupdir/full backup-and-apply-log")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during full backup (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Change ownership of full backup" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo chown -R mysqluser:mysqlgrp /backupdir/full")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during full backup change ownership (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Compressed backup" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=mysqlbackup --password=${user_pwd} --backup-dir=/backupdir/compressed --compress backup-and-apply-log")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during compressed backup (${MSG})" |tee -a ${log_file} ; fi

	echo
	echo "$(date) - INFO - Change ownership of compressed backup" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo chown -R mysqluser:mysqlgrp /backupdir/compressed")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during compressed backup change ownership (${MSG})" |tee -a ${log_file} ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}




lab6a_MySQL_prepare_replica_server_mysql2 () {
	ERR=0
	server='mysql2'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Execute script mysql2_prepare_replica_server.sh" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "/workshop/support/mysql2_prepare_replica_server.sh")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during execution of the script mysql2_prepare_replica_server.sh (${MSG})" |tee -a ${log_file} ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}

	

lab6b_MySQL_create_replica () {
	ERR=0
	source='mysql1'
	replica='mysql2'

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Full backup of ${source} for replica" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${source} opc@${source} "mysqlbackup --port=3307 --host=127.0.0.1 --protocol=tcp --user=mysqlbackup --password=${user_pwd} --backup-dir=/workshop/backups/${source}_source backup")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during full backup (${MSG})" |tee -a ${log_file} ; fi
	
	echo
	echo "$(date) - INFO - Copy my.cnf for commercial installation on ${replica}" |tee -a ${log_file}
	MSG=$(ssh -o StrictHostKeyChecking=no -t -i /home/opc/sshkeys/id_rsa_${replica} opc@${replica} "sudo cp ${workshop_directory}/support/my.cnf.${replica} /mysql/etc/my.cnf")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during my.cnf copy (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Set ownerships to my.cnf on ${replica}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${replica} opc@${replica} "sudo chown -R mysqluser:mysqlgrp /mysql/etc/my.cnf")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues ownerships set (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Restore backup on ${replica}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${replica} opc@${replica} "sudo /mysql/mysql-latest/bin/mysqlbackup --defaults-file=/mysql/etc/my.cnf --backup-dir=/workshop/backups/${source}_source --datadir=/mysql/data --log-bin=/mysql/binlog/binlog copy-back-and-apply-log")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues ownerships set (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Set ownerships to restored MySQL Enterprise directories on ${replica}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${replica} opc@${replica} "sudo chown -R mysqluser:mysqlgrp /mysql")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues ownerships set (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Set systemd startup for MySQL Enterprise on ${replica}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${replica} opc@${replica} "sudo systemctl start mysqld-advanced.service")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL initialize (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Create user 'repl'@'%' on ${source}" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${source} -P 3307 -e "CREATE USER 'repl'@'%' IDENTIFIED BY '${user_pwd}' REQUIRE SSL"
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during replication user cration (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Grant replication privilege to repl user on ${source}'" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${source} -P 3307 -e "GRANT REPLICATION SLAVE ON *.* TO 'repl'@'%'"
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during replication grant to repl user (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Create replication channel" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${replica} -P 3307 -e "CHANGE REPLICATION SOURCE TO SOURCE_HOST='${source}', SOURCE_PORT=3307, SOURCE_USER='repl', SOURCE_PASSWORD='${user_pwd}', SOURCE_AUTO_POSITION=1, MASTER_SSL=1"
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during replication channel creation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - STart replica" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${replica} -P 3307 -e "START REPLICA"
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during replication start (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo
	echo "$(date) - INFO - Make some change on source (${source})" |tee -a ${log_file}
	mysql -uadmin -p${root_pwd} -h ${source} -P 3307 -e "CREATE DATABASE newdb; USE newdb; CREATE TABLE t1 (c1 int primary key); INSERT INTO t1 VALUES(1); INSERT INTO t1 VALUES(2); DROP DATABASE employees;"
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during replication start (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab7a_open_subnet_ports_for_innodb_cluster () {
	ERR=0

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	echo "$(date) - INFO - Create new rules file" |tee -a ${log_file}
	new_rules=$( mktemp -t new_rules_XXXXX )

	echo "$(date) - INFO - Retrive private subnet ocid" |tee -a ${log_file}
	vnic_ocid=$( oci-metadata -g vnicId | awk '/ocid1/ {print $NF}' )
	this_subnet_ocid=$( oci network vnic get --vnic-id ${vnic_ocid} --raw-output --query data.\"subnet-id\" )
	vcn_ocid=$( oci network subnet get --subnet-id ${this_subnet_ocid} --raw-output --query data.\"vcn-id\" )
	compartment_ocid=$( oci-metadata -g "compartmentId" | awk '/ocid1/ {print $NF}' )
	private_subnet_ocid=$( oci network subnet list --compartment-id ${compartment_ocid} --vcn-id ${vcn_ocid} --raw-output --query "max_by(data[?starts_with(\"display-name\", 'Private')].{ocid:id}, &ocid)" | jq -r '.ocid' )

	echo "$(date) - INFO - Private subnet: $private_subnet_ocid" >> ${log_file}
	echo "$(date) - INFO - Retrive private subnet security list ocid" |tee -a ${log_file}
	existing_security_lists_ocid=$( oci network subnet get --subnet-id ${private_subnet_ocid} --raw-output --query 'data."security-list-ids"' | sed 's/[[,"]//g' | sed 's/\]//g' )

	seclist_found=0
	for private_security_list_ocid in $( echo ${existing_security_lists_ocid} )
	do
		name=$( oci network security-list get --security-list-id "$private_security_list_ocid" --raw-output --query data.\"display-name\")
		if [ "$name" == "Security List for Private Subnet-mysqlvcn" ] ; then
			seclist_found=1
			break
		fi
	done
	if [ ${seclist_found} -eq 0 ] ; then
		ERR=1
		echo "$(date) - ERROR - Security list \"Security List for Private Subnet-mysqlvcn\" not found" |tee -a ${log_file}
		return $ERR
	fi
	
	echo "$(date) - INFO - Security list OCID ${private_security_list_ocid}" >> ${log_file}
	echo "$(date) - INFO - Save existing rules inside local file" |tee -a ${log_file}
	oci network security-list get --security-list-id ${private_security_list_ocid} --query data.\"ingress-security-rules\" > ${new_rules}

	echo "$(date) - INFO - Add new rules to local file" |tee -a ${log_file}

	cat << EOF >> ${new_rules}
[
      {
        "description": "MySQL Group Replication",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "source": "10.0.1.0/24",
        "source-type": "CIDR_BLOCK",
        "tcp-options": {
          "destination-port-range": {
            "max": 33071,
            "min": 33071
          },
          "source-port-range": null
        },
        "udp-options": null
      }
]
EOF

	echo "$(date) - INFO - Create ingress file" |tee -a ${log_file}
	ingress_security_list=$( mktemp -t ingress_security_list_XXXXX )
	cat $new_rules |jq -s 'add' > ${ingress_security_list}

	echo "$(date) - INFO - Update private security list with new rules" |tee -a ${log_file}
	MSG=$( oci network security-list update --force --security-list-id "${private_security_list_ocid}" --ingress-security-rules file://${ingress_security_list} )
	ERR=$?
	if [ $ERR -ne 0 ] ; then
		echo "$(date) - ERROR - Issues during security list update ($MSG)" |tee -a ${log_file}
	fi
	echo "$(date) - INFO - Delete temporary files" |tee -a ${log_file}
	rm ${new_rules}
	rm ${ingress_security_list}


	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR

}



lab7b_innodb_cluster () {
	ERR=0
	admin_user='admin'
	server1='mysql1'
	server1_port='3307'
	server2='mysql2'
	server2_port='3307'
	server3='mysql3'
	server3_port='3307'

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	echo "$(date) - INFO - Drop table world.city_part" |tee -a ${log_file}
	mysql -u${admin_user} -p${root_pwd} -h${server1} -P${server1_port} -e 'DROP TABLE world.city_part' 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Stop replica on mysql2" |tee -a ${log_file}
	mysql -u${admin_user} -p${root_pwd} -h${server2} -P${server1_port} -e 'stop replica' 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Reset replica on mysql2" |tee -a ${log_file}
	mysql -u${admin_user} -p${root_pwd} -h${server2} -P${server1_port} -e 'reset replica all' 2>&1 |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Execute script mysql3_prepare_secondary.sh" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server3} opc@${server3} "/workshop/support/mysql3_prepare_secondary.sh")
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during execution of the script mysql3_prepare_secondary.sh (${MSG})" |tee -a ${log_file} ; fi

	echo "$(date) - INFO - Configure ${server1} for InnoDB Cluster" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server1} -P${server1_port} -- dba configure-instance --interactive=0 --restart=1 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Configure ${server2} for InnoDB Cluster" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server2} -P${server2_port} -- dba configure-instance --interactive=0 --restart=1 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Configure ${server3} for InnoDB Cluster" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server3} -P${server3_port} -- dba configure-instance --interactive=0 --restart=1 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Create cluster" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server1} -P${server1_port} -- dba create-cluster testCluster --interactive=0 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Show cluster status" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server1} -P${server1_port} -- cluster status 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Add ${server2} instance to cluster" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server1} -P${server1_port} -- cluster add-instance ${admin_user}@${server2}:${server2_port} --recoveryMethod=clone --interactive=0 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Add ${server3} instance to cluster" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server1} -P${server1_port} -- cluster add-instance ${admin_user}@${server3}:${server3_port} --recoveryMethod=clone --interactive=0 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Show cluster status" |tee -a ${log_file}
	mysqlsh -u${admin_user} -p${root_pwd} -h${server1} -P${server1_port} -- cluster status 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Install MySQL Router on app-srv" |tee -a ${log_file}
	sudo yum install -y ${router_installation_file} 2>&1 |tee -a ${log_file}
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MySQL Router installation (${MSG})" |tee -a ${log_file} ; return $ERR ; fi

	echo "$(date) - INFO - Bootstrap mysqlrouter" |tee -a ${log_file}
	echo "$(date) - INFO - Please insert ${admin_user} password" |tee -a ${log_file}
	sudo mysqlrouter --bootstrap ${admin_user}@${server1}:${server1_port} --user=mysqlrouter 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - Start mysqlrouter" |tee -a ${log_file}
	sudo systemctl start mysqlrouter 2>&1 |tee -a ${log_file}

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR

}



lab8a_open_subnet_ports_for_mysql_enterprise_monitor () {
	ERR=0

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	echo "$(date) - INFO - Create new rules file" |tee -a ${log_file}
	new_rules=$( mktemp -t new_rules_XXXXX )

	echo "$(date) - INFO - Retrive private subnet ocid" |tee -a ${log_file}
	vnic_ocid=$( oci-metadata -g vnicId | awk '/ocid1/ {print $NF}' )
	this_subnet_ocid=$( oci network vnic get --vnic-id ${vnic_ocid} --raw-output --query data.\"subnet-id\" )
	vcn_ocid=$( oci network subnet get --subnet-id ${this_subnet_ocid} --raw-output --query data.\"vcn-id\" )
	compartment_ocid=$( oci-metadata -g "compartmentId" | awk '/ocid1/ {print $NF}' )

	echo "$(date) - INFO - Public subnet: ${this_subnet_ocid}" >> ${log_file}
	echo "$(date) - INFO - Retrieve private subnet app-srv_sl security list ocid" |tee -a ${log_file}
	existing_security_lists_ocid=$( oci network subnet get --subnet-id ${this_subnet_ocid} --raw-output --query 'data."security-list-ids"' | sed 's/[[,"]//g' | sed 's/\]//g' )

	seclist_found=0
	for app_srv_sl_ocid in $( echo ${existing_security_lists_ocid} )
	do
		name=$( oci network security-list get --security-list-id "${app_srv_sl_ocid}" --raw-output --query data.\"display-name\")
		if [ "$name" == "app-srv_sl" ] ; then
			seclist_found=1
			break
		fi
	done
	if [ ${seclist_found} -eq 0 ] ; then
		ERR=1
		echo "$(date) - ERROR - Security list \"Security List for Private Subnet-mysqlvcn\" not found" |tee -a ${log_file}
		return $ERR
	fi
	
	
	echo "$(date) - INFO - Security list OCID ${app_srv_sl_ocid}" >> ${log_file}
	echo "$(date) - INFO - Save existing rules inside local file" |tee -a ${log_file}
	oci network security-list get --security-list-id ${app_srv_sl_ocid} --query data.\"ingress-security-rules\" > ${new_rules}

	echo "$(date) - INFO - Add new rules to local file" |tee -a ${log_file}

	cat << EOF >> ${new_rules}
[
      {
        "description": "MySQL Enterprise Monitor",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "source": "0.0.0.0/0",
        "source-type": "CIDR_BLOCK",
        "tcp-options": {
          "destination-port-range": {
            "max": 18443,
            "min": 18443
          },
          "source-port-range": null
        },
        "udp-options": null
      }
]
EOF

	echo "$(date) - INFO - Create ingress file" |tee -a ${log_file}
	ingress_security_list=$( mktemp -t ingress_security_list_XXXXX )
	cat $new_rules |jq -s 'add' > ${ingress_security_list}

	echo "$(date) - INFO - Update security list with new rules" |tee -a ${log_file}
	MSG=$( oci network security-list update --force --security-list-id "${app_srv_sl_ocid}" --ingress-security-rules file://${ingress_security_list} )
	ERR=$?
	if [ $ERR -ne 0 ] ; then
		echo "$(date) - ERROR - Issues during security list update ($MSG)" |tee -a ${log_file}
	fi
	echo "$(date) - INFO - Delete temporary files" |tee -a ${log_file}
	rm ${new_rules}
	rm ${ingress_security_list}


	return $ERR

}



lab8b_MySQL_Enterprise_Monitor___install_service_manager () {
	ERR=0

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Install MEM Service Manager. Please wait..." |tee -a ${log_file}
	sudo ${monitorpackage} --mode "unattended" --unattendedmodeui "minimal" --adminuser "service_manager" --adminpassword "${user_pwd}" --system_size "small" 2>$1 |tee -a ${log_file}

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}



lab8c_MySQL_Enterprise_Monitor___install_agent () {
	ERR=0

	server=$1
	server=${server:='mysql1'}

	echo "$(date) - INFO - Start $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	echo
	echo "$(date) - INFO - Install MEM agent on ${server}" |tee -a ${log_file}
	MSG=$(ssh -t -i /home/opc/sshkeys/id_rsa_${server} opc@${server} "sudo ${agentpackage} --mode unattended --unattendedmodeui minimal --agent_installtype standalone --managerhost ${local_ip} --managerport 18443 --agentuser agent --agentpassword ${user_pwd}") 2>$1 |tee -a ${log_file}
	ERR=$?
	if [ $ERR -ne 0 ] ; then echo "$(date) - ERROR - Issues during MEM agent installation (${MSG})" |tee -a ${log_file} ; fi

	echo "$(date) - INFO - End $(echo ${FUNCNAME[0]})" |tee -a ${log_file}

	return $ERR

}




# Don\'t delete this line
#___END_LABS_FUNCTIONS___




#####################################################
# STATIC VARIABLES
#####################################################
ERR=0

# Define the dialog exit status codes
: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}


#####################################################
# FUNCTIONS
#####################################################

# Exit from errors
stop_execution_for_error () {
# first parameter is the exiut code
# second parameter is the error message

	ERR=$1	
	ERR=${ERR:=1}

	MSG=$2
	MSG=${MSG:="Generic error"}
	echo "$(date) - ERROR - ${MSG}" |tee -a ${log_file}
	echo "$(date) - INFO - End" >> ${log_file}

	exit $ERR
}


#######
# Set timezone for crontab
#######
set_timezone() {
	ERR=0

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	echo "$(date) - INFO - Configure timezone" |tee -a ${log_file}
	unset tz_list; tz_list+=(`for i in $(timedatectl list-timezones)
		do
			echo "$i off"
		done`)

	while true
	do
		# Duplicate (make a backup copy of) file descriptor 1 on descriptor 3
		exec 3>&1

		# Generate the dialog box while running dialog in a subshell
		selection=$(dialog \
			--backtitle "Timezone set" \
			--title "Timezone list" \
			--clear  \
			--cancel-label "Exit" \
			--no-items \
			--radiolist "Choose your timezone: " 0 0 30 ${tz_list[@]} \
			2>&1 1>&3)

		# Get dialog's exit status
		exit_status=$?

		# Close file descriptor 3
		exec 3>&-

		# Act on the exit status
		case $exit_status in
		$DIALOG_CANCEL)
			clear
			echo "$(date) - INFO - Scripts menu end" >> ${log_file}
			return $ERR
			;;
		$DIALOG_ESC)
			clear
			echo "$(date) - INFO - Scripts menu cancelled" >> ${log_file}
			return $ERR
			;;
		esac

		if [ "X$selection" != 'X' ] ; then break ; fi

	done

	echo $selection
	sudo timedatectl set-timezone $selection

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}
	return $ERR

}



#######
# Install and configure settings for the lab purposes
#######
setup_app_srv () {
	ERR=0

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}


	echo "$(date) - INFO - Installing required software" |tee -a ${log_file}
	echo

	# ncurses-compat-libs are required by dialog
	echo "$(date) - INFO - Installing ncurses-compat-libs and nfs-utils" |tee -a ${log_file}
	sudo yum -y -q install ncurses-compat-libs nfs-utils 2>&1 >> ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "Issues during ncurses-compat-libs and nfs-utils installation"
	fi

	# Disable firewall and selinux to simplify NFS and MySQL software configuration
	echo
	echo "$(date) - INFO - Disabling firewall for the matter of the lab (not recommended in production>" |tee -a ${log_file}
	sudo systemctl stop firewalld
	sudo systemctl disable firewalld
	echo
	echo "$(date) - INFO - Set selinux in permissive mode to simplify the lab (not recommended in production)" |tee -a ${log_file}
	sudo setenforce 0

	echo
	echo "$(date) - INFO - Now configuring /etc/resolv.conf to resolve hostnames in private subnet" |tee -a ${log_file}
	# Update resolv.conf with the private subnet domain, to simplify mysql instances access
	compartment_ocid=$( oci-metadata -g "compartmentId" | awk '/ocid1/ {print $NF}' )
	vnic_ocid=$( oci-metadata -g vnicId | awk '/ocid1/ {print $NF}' )
	this_subnet_ocid=$( oci network vnic get --vnic-id ${vnic_ocid} --raw-output --query data.\"subnet-id\" )
	vcn_ocid=$( oci network subnet get --subnet-id ${this_subnet_ocid} --raw-output --query data.\"vcn-id\" )
	subnet_ocid=$( oci network subnet list --compartment-id ${compartment_ocid} --vcn-id ${vcn_ocid} --raw-output --query "max_by(data[?starts_with(\"display-name\", 'Private')].{ocid:id}, &ocid)" | jq -r '.ocid' )
	subnet_domain_name=$(oci network subnet get --subnet-id ${subnet_ocid} --raw-output --query 'data."subnet-domain-name"')
	sudo sed -i '/^search/ s/$/ '${subnet_domain_name}'/' /etc/resolv.conf

	# Prevent resolv.conf change every reboot as for KB 2507035.1
	sudo chattr -R +i /etc/resolv.conf

	# Configure and enable NFS server to share lab software to all nodes
	echo
	echo "$(date) - INFO - Now configuring and enablig NFS server" |tee -a ${log_file}
	vcn_cidr=$(oci network vcn get --vcn-id ${vcn_ocid} --raw-output --query 'data."cidr-block"')
	sudo sh -c "echo \"${WORKSHOP_DIRECTORY} ${vcn_cidr}(rw,sync,no_root_squash,no_all_squash)\" >> /etc/exports"
	sudo systemctl enable nfs-server
	sudo systemctl start nfs-server
	sudo exportfs -a
	
	# Set vim colorscheme to be compatible with WIndows Powershell
	echo "colorscheme ron" >> /home/opc/.vimrc

	# Set MySQL prompt to a more readable one
	echo "export MYSQL_PS1=\"\\\\u on \\\\h>\\\\_\"" >> /home/opc/.bash_profile
	
	echo "$(date) - INFO - NFS server configured" |tee -a ${log_file}
	echo

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}
	return $ERR

}



#######
# Create first security list with NFS to app-srv and ping in the vcn
#######
app_srv_security_list () {
	ERR=0
	
	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}


	echo "$(date) - INFO - Create ingress file" >> ${log_file}
	ingress_security_list=$( mktemp -t ingress_security_list_XXXXX )

	cat << EOF > ${ingress_security_list}
[
      {
        "description": "NFS",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": {
          "destination-port-range": {
            "max": 2050,
            "min": 2048
          },
          "source-port-range": null
        },
        "udp-options": null
      },
      {
        "description": "NFS",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "17",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": null,
        "udp-options": {
          "destination-port-range": {
            "max": 111,
            "min": 111
          },
          "source-port-range": null
        }
      },
      {
        "description": "NFS",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "17",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": null,
        "udp-options": {
          "destination-port-range": {
            "max": 2048,
            "min": 2048
          },
          "source-port-range": null
        }
      },
      {
        "description": "ping",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "1",
        "source": "10.0.0.0/16",
        "source-type": "CIDR_BLOCK",
        "tcp-options": null,
        "udp-options": null
      }
]
EOF

	echo "$(date) - INFO - Create egress file" >> ${log_file}
	egress_security_list=$( mktemp -t egress_security_list_XXXXX )

	cat << EOF > ${egress_security_list}
[
      {
        "description": "NFS",
        "destination": "10.0.0.0/16",
        "destination-type": "CIDR_BLOCK",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "tcp-options": {
          "destination-port-range": {
            "max": 111,
            "min": 111
          },
          "source-port-range": null
        },
        "udp-options": null
      },
      {
        "description": "NFS",
        "destination": "10.0.0.0/16",
        "destination-type": "CIDR_BLOCK",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "6",
        "tcp-options": {
          "destination-port-range": {
            "max": 2050,
            "min": 2048
          },
          "source-port-range": null
        },
        "udp-options": null
      },
      {
        "description": "NFS",
        "destination": "10.0.0.0/16",
        "destination-type": "CIDR_BLOCK",
        "icmp-options": null,
        "is-stateless": false,
        "protocol": "17",
        "tcp-options": null,
        "udp-options": {
          "destination-port-range": {
            "max": 111,
            "min": 111
          },
          "source-port-range": null
        }
      }
]
EOF

	echo "$(date) - INFO - Retriving compartment OCID" |tee -a ${log_file}
	compartment_ocid=$( oci-metadata -g "compartmentId" | awk '/ocid1/ {print $NF}' )

	# Find required ocids
	echo "$(date) - INFO - Finding the subnet of app-srv" |tee -a ${log_file}
	vnic_ocid=$( oci-metadata -g vnicId | awk '/ocid1/ {print $NF}' )
	subnet_ocid=$( oci network vnic get --vnic-id ${vnic_ocid} --raw-output --query data.\"subnet-id\" )
	vcn_ocid=$( oci network subnet get --subnet-id ${subnet_ocid} --raw-output --query data.\"vcn-id\" )
	
	app_srv_security_list=$( oci network security-list create --compartment-id ${compartment_ocid} --vcn-id ${vcn_ocid} --ingress-security-rules file://${ingress_security_list} --egress-security-rules file://${egress_security_list} --display-name="app-srv_sl" )

	app_srv_security_list_ocid=$( echo ${app_srv_security_list} | jq -r '.data.id' )
	existing_security_lists_ocid=$( oci network subnet get --subnet-id ${subnet_ocid} --raw-output --query 'data."security-list-ids"' )
	full_security_list=$( echo ${existing_security_lists_ocid} | jq ' . |= . + [ "'"$app_srv_security_list_ocid"'" ]' )

	echo "$(date) - INFO - Apply the new security list" |tee -a ${log_file}
	final_security_lists=$( oci network subnet update --force --subnet-id ${subnet_ocid} --security-list-ids "${full_security_list}" )


	rm ${ingress_security_list}
	rm ${egress_security_list}

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR
}



#######
# Create servers for the mysql instances
#######
create_mysql_servers () {
	ERR=0
	# The input is a subfix to "mysql" (e.g. a number) used to generate the display name and hostname

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	# Create ssh key files for mysql instances
	mkdir -p /home/opc/sshkeys
	chmod go-rwx /home/opc/sshkeys

	if [[ $1 =~ [1-9] ]]; then

		echo "$(date) - INFO - (1/11) Creating SSH keys in case are not already created" |tee -a ${log_file}
		if [ ! -f "/home/opc/sshkeys/id_rsa_mysql$1" ] ; then
			ssh-keygen -b 2048 -t rsa -q -N '' -f /home/opc/sshkeys/id_rsa_mysql"$1"
		fi

		public_ssh_key=/home/opc/sshkeys/id_rsa_mysql"$1".pub

		echo "$(date) - INFO - (2/11) Retriving compartment OCID" |tee -a ${log_file}
		compartment_ocid=$( oci-metadata -g "compartmentId" | awk '/ocid1/ {print $NF}' )

		echo "$(date) - INFO - (3/11) Retriving Region" |tee -a ${log_file}
		region=$( oci-metadata -g region | awk '/Region/ {print $NF}' )

		echo "$(date) - INFO - (4/11) Retriving Availability domains for region ${region}" |tee -a ${log_file}
		unset ad_list
		for i in $( oci iam availability-domain list --query data[].{name:name} |awk '/name/ {gsub("\"",""); print $NF}' )
		do
			ad_list=("${ad_list[@]}" "$i")
		done
		availability_domain=${ad_list[$(( ( $1 -1 ) % ${#ad_list[@]} ))]}

		echo "$(date) - INFO - (5/11) Setting instance shape" |tee -a ${log_file}
		shape="VM.Standard2.1"

		echo "$(date) - INFO - (6/11) Retriving the correct image for OL8" |tee -a ${log_file}
		image_ocid=$( oci compute image list --compartment-id ${compartment_ocid} --operating-system 'Oracle Linux' --operating-system-version 8 --shape $shape --query "(max_by(data[?!(\"base-image-id\" != null)].{name:\"display-name\", OCID:id },&name)).{ocid:OCID}" --all |jq -r '.ocid' )

		# Find the subnet
		echo "$(date) - INFO - (7/11) Finding the subnet where create the instance" |tee -a ${log_file}
		vnic_ocid=$( oci-metadata -g vnicId | awk '/ocid1/ {print $NF}' )
		this_subnet_ocid=$( oci network vnic get --vnic-id ${vnic_ocid} --raw-output --query data.\"subnet-id\" )
		vcn_ocid=$( oci network subnet get --subnet-id ${this_subnet_ocid} --raw-output --query data.\"vcn-id\" )
		subnet_ocid=$( oci network subnet list --compartment-id ${compartment_ocid} --vcn-id ${vcn_ocid} --raw-output --query "max_by(data[?starts_with(\"display-name\", 'Private')].{ocid:id}, &ocid)" | jq -r '.ocid' )

		echo "$(date) - INFO - (8/11) Setting instance display name" |tee -a ${log_file}
		display_name="mysql$1"

		echo "$(date) - INFO - (9/11) Setting instance hostname name" |tee -a ${log_file}
		hostname_label="mysql$1"

		# Create a bootstrap file
		user_data_file=$(mktemp  -t user_data_file_XXXXXX)
		echo "$(date) - INFO - (10/11) Creating bootstrap file (${user_data_file}) for the instance basic configuration" |tee -a ${log_file}
		local_ip=$( oci-metadata -g privateIp | awk '/Private IP address:/ {print $NF}' )
		tz=$(timedatectl | awk '/Time zone/ {print $3}')
		cat << EOF > ${user_data_file}
#!/bin/bash
echo "\$(date) - INFO - START LOG" >> /root/bootstrap.log
echo "\$(date) - INFO - Set vi colorscheme" >> /root/bootstrap.log
echo "colorscheme ron" >> /home/opc/.vimrc
echo "\$(date) - INFO - Set the timezone" >> /root/bootstrap.log
timedatectl set-timezone $tz
echo "\$(date) - INFO - Install nfs-utils" >> /root/bootstrap.log
yum install nfs-utils -y
echo "\$(date) - INFO - Create ${WORKSHOP_DIRECTORY} directory" >> /root/bootstrap.log
mkdir -p ${WORKSHOP_DIRECTORY}
echo "\$(date) - INFO - Change ${WORKSHOP_DIRECTORY} directory ownership" >> /root/bootstrap.log
chown opc:opc ${WORKSHOP_DIRECTORY}
echo "\$(date) - INFO - Set ${WORKSHOP_DIRECTORY} nfs mount in /etc/fstab" >> /root/bootstrap.log
echo "${local_ip}:${WORKSHOP_DIRECTORY} ${WORKSHOP_DIRECTORY} nfs defaults,nofail,nosuid,resvport 0 0" >> /etc/fstab
echo "\$(date) - INFO - Force nfs mount" >> /root/bootstrap.log
mount -a
echo "\$(date) - INFO - Stop firewalld" >> /root/bootstrap.log
systemctl stop firewalld.service
echo "\$(date) - INFO - Disable firewalld" >> /root/bootstrap.log
systemctl disable firewalld
echo "Disable selinux to simplify the lab (not recommended in production)" >> /root/bootstrap.log
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
echo "\$(date) - INFO - END" >> /root/bootstrap.log
echo "\$(date) - INFO - now reboot" >> /root/bootstrap.log
reboot
EOF

		echo "$(date) - INFO - (11/11) Creating the instance ${display_name}" |tee -a ${log_file}
		mysql1_details=$( oci compute instance launch \
--availability-domain ${availability_domain} \
--compartment-id ${compartment_ocid} \
--shape ${shape} \
--display-name ${display_name} \
--hostname-label ${hostname_label} \
--image-id ${image_ocid} \
--ssh-authorized-keys-file ${public_ssh_key} \
--subnet-id ${subnet_ocid} \
--user-data-file ${user_data_file} )
		ERR=$?
		if [ $ERR -ne 0 ] ; then
			echo "$(date) - ERROR - Problems during create instance command" >> ${log_file}
			return $ERR 
		fi

	else
		ERR=1
		"wrong instance number (please choose a nuimber between 1 and 9)"
	fi

	rm ${user_data_file}

	#sleep 10
	# read -p "Press ENTER to continue"

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR

}



#######
# Create servers for the mysql instances
# These servers are on public subnet and used only for advancd/non standard bootcamps
#######
create_mysql_servers_on_public () {
	ERR=0
	# The input is a subfix to "mysql" (e.g. a number) used to generate the display name and hostname

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	# Create ssh key files for mysql instances
	mkdir -p /home/opc/sshkeys
	chmod go-rwx /home/opc/sshkeys

	if [[ $1 =~ [1-9] ]]; then

		echo "$(date) - INFO - (1/11) Creating SSH keys in case are not already created" |tee -a ${log_file}
		if [ ! -f "/home/opc/sshkeys/id_rsa_mysql$1" ] ; then
			ssh-keygen -b 2048 -t rsa -q -N '' -f /home/opc/sshkeys/id_rsa_mysql"$1"
		fi

		public_ssh_key=/home/opc/sshkeys/id_rsa_mysql"$1".pub

		echo "$(date) - INFO - (2/11) Retriving compartment OCID" |tee -a ${log_file}
		compartment_ocid=$( oci-metadata -g "compartmentId" | awk '/ocid1/ {print $NF}' )

		echo "$(date) - INFO - (3/11) Retriving Region" |tee -a ${log_file}
		region=$( oci-metadata -g region | awk '/Region/ {print $NF}' )

		echo "$(date) - INFO - (4/11) Retriving Availability domains for region ${region}" |tee -a ${log_file}
		unset ad_list
		for i in $( oci iam availability-domain list --query data[].{name:name} |awk '/name/ {gsub("\"",""); print $NF}' )
		do
			ad_list=("${ad_list[@]}" "$i")
		done
		availability_domain=${ad_list[$(( ( $1 -1 ) % ${#ad_list[@]} ))]}

		echo "$(date) - INFO - (5/11) Setting instance shape" |tee -a ${log_file}
		shape="VM.Standard2.1"

		echo "$(date) - INFO - (6/11) Retriving the correct image for OL8" |tee -a ${log_file}
		image_ocid=$( oci compute image list --compartment-id ${compartment_ocid} --operating-system 'Oracle Linux' --operating-system-version 8 --shape $shape --query "(max_by(data[?!(\"base-image-id\" != null)].{name:\"display-name\", OCID:id },&name)).{ocid:OCID}" --all |jq -r '.ocid' )

		# Find the subnet
		echo "$(date) - INFO - (7/11) Finding the subnet where create the instance" |tee -a ${log_file}
		vnic_ocid=$( oci-metadata -g vnicId | awk '/ocid1/ {print $NF}' )
		this_subnet_ocid=$( oci network vnic get --vnic-id ${vnic_ocid} --raw-output --query data.\"subnet-id\" )

		echo "$(date) - INFO - (8/11) Setting instance display name" |tee -a ${log_file}
		display_name="mysql$1"

		echo "$(date) - INFO - (9/11) Setting instance hostname name" |tee -a ${log_file}
		hostname_label="mysql$1"

		# Create a bootstrap file
		user_data_file=$(mktemp  --tmpdir=${TEMP_DIR} user_data_file_XXXXXX)
		echo "$(date) - INFO - (10/11) Creating bootstrap file (${user_data_file}) for the instance basic configuration" |tee -a ${log_file}
		local_ip=$( oci-metadata -g privateIp | awk '/Private IP address:/ {print $NF}' )
		cat << EOF > ${user_data_file}
#!/bin/bash
echo "$(date) - INFO - START LOG" >> /root/bootstrap.log
echo "$(date) - INFO - Install nfs-utils" >> /root/bootstrap.log
yum install nfs-utils -y
echo "$(date) - INFO - Create ${WORKSHOP_DIRECTORY} directory" >> /root/bootstrap.log
mkdir -p {WORKSHOP_DIRECTORY}
echo "$(date) - INFO - Change ${WORKSHOP_DIRECTORY} directory ownership" >> /root/bootstrap.log
chown opc:opc {WORKSHOP_DIRECTORY}
echo "$(date) - INFO - Set ${WORKSHOP_DIRECTORY} nfs mount in /etc/fstab" >> /root/bootstrap.log
echo "${local_ip}:${WORKSHOP_DIRECTORY} ${WORKSHOP_DIRECTORY} nfs defaults,nofail,nosuid,resvport 0 0" >> /etc/fstab
echo "$(date) - INFO - Force nfs mount" >> /root/bootstrap.log
mount -a
echo "$(date) - INFO - Stop firewalld" >> /root/bootstrap.log
systemctl stop firewalld.service
echo "$(date) - INFO - Disable firewalld" >> /root/bootstrap.log
systemctl disable firewalld
echo "$(date) - INFO - Disable selinux" >> /root/bootstrap.log
sed -i s/SELINUX=enforcing/SELINUX=disabled/g /etc/selinux/config
echo "$(date) - INFO - END" >> /root/bootstrap.log
echo "$(date) - INFO - now reboot" >> /root/bootstrap.log
reboot
EOF

		echo "$(date) - INFO - (11/11) Creating the instance ${display_name}" |tee -a ${log_file}
		mysql1_details=$( oci compute instance launch \
--availability-domain ${availability_domain} \
--compartment-id ${compartment_ocid} \
--shape ${shape} \
--display-name ${display_name} \
--hostname-label ${hostname_label} \
--image-id ${image_ocid} \
--ssh-authorized-keys-file ${public_ssh_key} \
--subnet-id ${this_subnet_ocid} \
--user-data-file ${user_data_file} )

	else
		ERR=1
		"wrong instance number (please choose a nuimber between 1 and 9)"
	fi

	rm ${user_data_file}

	#sleep 10
	# read -p "Press ENTER to continue"

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR

}



#######
# Download the software for the labs and put it in the right place for the NFS sharing
#######
download_software () {
	ERR=0

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	# Download load all the software

	# Retrive links from local wget.sh
	echo
	
	if [ -f ${working_dir}/wget.sh ] ; then
		export WGET_FILE=${working_dir}/wget.sh
	else
		read -p "Please insert the wget file to use to download MySQL software [${working_dir}/wget.sh]: " WGET_FILE
	fi

	if [ ! -r "${WGET_FILE}" ] ; then
		ERR=1
		stop_execution_for_error $ERR "wget file not found (${WGET_FILE})"
	fi


	SRV_TAR_PKG_DOWNLOAD=$( grep -i ${SRV_TAR} ${WGET_FILE} | sed 's/\$WGET/wget --progress=dot:giga/g' | sed 's/>>.*$/ -a ${log_file}/g' | sed 's/OUTPUT_DIR/TEMP_DIR/g' )
	REP_RPM_PKG_DOWNLOAD=$( grep -i ${REP_RPM} ${WGET_FILE} | sed 's/\$WGET/wget --progress=dot:giga/g' | sed 's/>>.*$/ -a ${log_file}/g' | sed 's/OUTPUT_DIR/TEMP_DIR/g' )
	MEM_SRV_PKG_DOWNLOAD=$( grep -i ${MEM_SRV} ${WGET_FILE} | sed 's/\$WGET/wget --progress=dot:giga/g' | sed 's/>>.*$/ -a ${log_file}/g' | sed 's/OUTPUT_DIR/TEMP_DIR/g' )
	MEM_AGT_PKG_DOWNLOAD=$( grep -i ${MEM_AGT} ${WGET_FILE} | sed 's/\$WGET/wget --progress=dot:giga/g' | sed 's/>>.*$/ -a ${log_file}/g' | sed 's/OUTPUT_DIR/TEMP_DIR/g' )

	if [ "X${SRV_TAR_PKG_DOWNLOAD}" == 'X' ] || [ "X${REP_RPM_PKG_DOWNLOAD}" == 'X' ] || [ "X${MEM_SRV_PKG_DOWNLOAD}" == 'X' ] || [ "X${MEM_AGT_PKG_DOWNLOAD}" == 'X' ] ; then
		ERR=1
		stop_execution_for_error $ERR "missing donwload line for required packages from ${WGET_FILE} (${SRV_TAR}, ${REP_RPM_SRV}, ${MEM_AGT})"
	fi


	# Cookie file for the authentication
	export COOKIE_FILE=$(mktemp  --tmpdir=${TEMP_DIR} wget_sh_XXXXXX)
	if [ $? -ne 0 ] || [ -z "$COOKIE_FILE" ]
	then
		ERR=1
		stop_execution_for_error $ERR "Temporary cookie file creation failed."
	fi



	# Authentication on edelivery
	read -p 'Edelivery Username: ' EDELIVERY_USERNAME
	
	wget  --secure-protocol=auto --save-cookies="${COOKIE_FILE}" --keep-session-cookies  --http-user "${EDELIVERY_USERNAME}" --ask-password  "https://edelivery.oracle.com/osdc/cliauth" -O /dev/null -a ${log_file}

	# Verify if authentication is successful
	if [ $? -ne 0 ]
	then
		ERR=1
		stop_execution_for_error $ERR "Authentication failed with the given credentials."
	fi

	echo
	echo "$(date) - INFO - Authentication is successful. Proceeding now with downloads" |tee -a ${log_file}


	# Start downloads
	echo "$(date) - INFO - Download of MySQL Server tar... please wait..." |tee -a ${log_file}
	bash -c "${SRV_TAR_PKG_DOWNLOAD}" 2>&1 >> ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "error during the download of ${SRV_TAR}"
	fi

	# Check the first download, if it's fine I assume all are fine
	echo "$(date) - INFO - Check MySQL Server tar... please wait..." |tee -a ${log_file}
	unzip -t -qq ${TEMP_DIR}/${SRV_TAR} 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "Corrupted zip file (${SRV_TAR})"
	fi

	echo "$(date) - INFO - Download of MySQL rpms repo... please wait..." |tee -a ${log_file}
	bash -c "${REP_RPM_PKG_DOWNLOAD}" 2>&1 >> ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "error during the download of ${REP_RPM}"
	fi

	echo "$(date) - INFO - Download of MySQL MEM Service Monitor... please wait..." |tee -a ${log_file}
	bash -c "${MEM_SRV_PKG_DOWNLOAD}" 2>&1 >> ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "error during the download of ${MEM_SRV}"
	fi

	echo "$(date) - INFO - Download of MySQL MEM agent... please wait..." |tee -a ${log_file}
	bash -c "${MEM_AGT_PKG_DOWNLOAD}" 2>&1 >> ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "error during the download of ${MEM_AGT}"
	fi

	echo "$(date) - INFO - Download of MySQL Community yum repo... please wait..." |tee -a ${log_file}
	wget --progress=dot:giga ${COMMUNITY_YUM_REPO} -P "${TEMP_DIR}/" -a ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "error during the download of ${SRV_TAR}"
	fi

	echo "$(date) - INFO - Download of sample database (world)... please wait..." 2>&1 |tee -a ${log_file}
	wget --progress=dot:giga ${WORLD_DB} -P "${TEMP_DIR}/" -a ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "error during the download of ${WORLD_DB}"
	fi

	echo "$(date) - INFO - Download of sample database (employees)... please wait..." |tee -a ${log_file}
	wget --progress=dot:giga ${EMPLOYEES_DB} -P "${TEMP_DIR}/" -a ${log_file}
	if [ $? -ne 0 ] ; then
		ERR=1
		stop_execution_for_error $ERR "error during the download of ${EMPLOYEES_DB}"
	fi

	# Cleanup
	rm -f "$COOKIE_FILE"
	echo
	echo "$(date) - INFO - All downloads completed" |tee -a ${log_file}

	echo "$(date) - INFO - Now install required packages" |tee -a ${log_file}

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR
}



#######
# Extract downloaded software, create directory structure and copy software in the destination
extract_software () {
	ERR=0

	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	# Verify that all required packages are already downloaded

	# Check MySQL Commercial Server 8.0.xx TAR for Generic Linux x87 (64bit)
	if [ ! -r ${TEMP_DIR}/${SRV_TAR} ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find required software (MySQL Commercial Server tar: ${TEMP_DIR}/${SRV_TAR})"
	fi

	# Check MySQL Database/Components 8.0.xx Yum Repository TAR for Oracle Linux / RHEL 8 x86 (64bit)
	if [ ! -r ${TEMP_DIR}/${REP_RPM} ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find required software (MySQL Database/Components Yum Repository TAR: ${TEMP_DIR}/${REP_RPM})"
	fi

	# Check MySQL Enterprise Monitor Service Manager 8.0.xx for Linux x86 (64-bit)
	if [ ! -r ${TEMP_DIR}/${MEM_SRV} ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find required software (MySQL Enterprise Monitor Service Manager: ${TEMP_DIR}/${MEM_SRV})" 
	fi

	# Check MySQL Enterprise Monitor Agent 8.0.xx for Linux x86 (64-bit)
	if [ ! -r ${TEMP_DIR}/${MEM_AGT} ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find required software (MySQL Enterprise Monitor Agent: ${TEMP_DIR}/${MEM_AGT})"
	fi

	# Check world database
	if [ ! -r ${TEMP_DIR}/$( basename ${WORLD_DB} ) ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find required software (MySQL world database: ${TEMP_DIR}/${WORLD_DB})"
	fi

	# Check employees database
	if [ ! -r ${TEMP_DIR}/$( basename ${EMPLOYEES_DB} ) ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find required software (Employees database: ${TEMP_DIR}/${EMPLOYEES_DB})"
	fi

	# Check OL8 mysql community repository rpm
	if [ ! -r ${TEMP_DIR}/$( basename ${COMMUNITY_YUM_REPO} ) ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find required software (OL8 mysql community repository rpm: ${TEMP_DIR}/${COMMUNITY_YUM_REPO})"
	fi



	# EMBEDDED FILE MANAGEMENT
	#find last line +1
 
	SCRIPT_END=$( awk '
  BEGIN { err=1; } 
  /^\w*___END_OF_SHELL_SCRIPT___\w*$/ { print NR+1; err=0; exit 0; } 
  END { if (err==1) print "?"; }
' "$0" )
 
	# check for errors
 
	if [ "$SCRIPT_END" == '?' ] ; then
		ERR=1
		stop_execution_for_error $ERR "Can't find embedded file with required support scripts"
	fi

	# ENVIRONMENT CHECKS
	if [ ! -d ${TEMP_DIR} ] ; then
		mkdir ${TEMP_DIR}
		if [ $? -ne 0 ] ; then
			ERR=1
			stop_execution_for_error $ERR "Error with temporary directory"
		fi
	fi


	# To create the new zip file
	# delete all lines after ___END_OF_SHELL_SCRIPT___
	# zip the content of the /workshop/support directory
	# eg.
	#   shell> cd /workshop/support
	#   shell> zip /home/opc/support.zip *
	# Then add the support.zip file to this script with nbase64 encoding
	# e.g.
	#   shell> base64 /home/opc/support.zip >> /home/opc/configure_labs.sh

	# Extract embedded file with support scripts
	tail -n +$SCRIPT_END $0 | base64 -d > ${TEMP_DIR}/support.zip
	unzip -qq -t ${TEMP_DIR}/support.zip &>/dev/null
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "corrupted embedded file with support scripts"; fi

	# Unzip sw
	echo
	echo "$(date) - INFO - Unzip of MySQL Server tar" |tee -a ${log_file}
	unzip -d ${TEMP_DIR}/MySQL_Server_tar ${TEMP_DIR}/${SRV_TAR} 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Corrupted file ${TEMP_DIR}/${SRV_TAR}"; fi

	echo "$(date) - INFO - Unzip of MySQL RPMs" |tee -a ${log_file}
	unzip -d ${TEMP_DIR}/MySQL_rpms_repo ${TEMP_DIR}/${REP_RPM} 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Corrupted file ${TEMP_DIR}/${REP_RPM}"; fi

	# Extract from tar the rpms
	tar xf ${TEMP_DIR}/MySQL_rpms_repo/mysql-commercial-8*.el*.gz -C ${TEMP_DIR}/MySQL_rpms_repo

	echo "$(date) - INFO - Unzip of MySQL MEM Service Monitor and agent" |tee -a ${log_file}
	unzip -d ${TEMP_DIR}/MEM_Service_Monitor ${TEMP_DIR}/${MEM_SRV} 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Corrupted file ${TEMP_DIR}/${MEM_SRV}"; fi
	unzip -d ${TEMP_DIR}/MEM_agent ${TEMP_DIR}/${MEM_AGT} 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Corrupted file ${TEMP_DIR}/${MEM_AGT}"; fi

	echo "$(date) - INFO - Unzip world database" |tee -a ${log_file}
	unzip -d ${TEMP_DIR} ${TEMP_DIR}/$( basename ${WORLD_DB} ) 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Corrupted file ${TEMP_DIR}/${WORLD_DB}"; fi

	echo "$(date) - INFO - Unzip employees database" |tee -a ${log_file}
	unzip -d ${TEMP_DIR} ${TEMP_DIR}/$( basename ${EMPLOYEES_DB} ) 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Corrupted file ${TEMP_DIR}/${EMPLOYEES_DB}"; fi



	# Create directory structure for lab software
	echo
	echo "$(date) - INFO - Now creating ${BACKUP_DIR} directory structure" |tee -a ${log_file}
	mkdir -p ${BACKUP_DIR}/backups
	mkdir -p ${BACKUP_DIR}/databases/world
	mkdir -p ${BACKUP_DIR}/databases/employees
	mkdir -p ${BACKUP_DIR}/linux/agent
	mkdir -p ${BACKUP_DIR}/linux/client
	mkdir -p ${BACKUP_DIR}/linux/monitor
	mkdir -p ${BACKUP_DIR}/support/



	echo
	echo "$(date) - INFO - Creating workshop content inside ${BACKUP_DIR}" |tee -a ${log_file}
	echo

	

	unzip -d ${BACKUP_DIR}/support ${TEMP_DIR}/support.zip 2>&1 >>${log_file}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Corrupted file ${TEMP_DIR}/support.zip"; fi

	# Create a directory with rpms to install the commercial server, usable for customized labs
	mv ${TEMP_DIR}/MySQL_rpms_repo/mysql-8.0/8.*/ ${TEMP_DIR}/MySQL_server_rpms
	rm -rf ${TEMP_DIR}/MySQL_server_rpms/repodata
	rm -rf ${TEMP_DIR}/MySQL_server_rpms/mysql-workbench-commercial*
	rm -rf ${TEMP_DIR}/MySQL_server_rpms/mysql-commercial-test-8.0.26-1.1.el8.x86_64.rpm

	# Create a directory with rpms to install the commercial connectors, usable for customized labs
	mkdir ${TEMP_DIR}/MySQL_connectors_rpms
	mv ${TEMP_DIR}/MySQL_server_rpms/mysql-connector* ${TEMP_DIR}/MySQL_connectors_rpms/

	echo "$(date) - INFO - Move or copy files for oficial labs in the right positions" |tee -a ${log_file}

	cp ${TEMP_DIR}/$( basename ${COMMUNITY_YUM_REPO} ) ${BACKUP_DIR}/linux/
	
	mv ${TEMP_DIR}/MySQL_Server_tar/mysql-commercial-8*-x86_64.tar.xz ${BACKUP_DIR}/linux/

	mv ${TEMP_DIR}/MySQL_server_rpms/mysql-router-commercial-8*.el*.x86_64.rpm ${BACKUP_DIR}/linux/

	mv ${TEMP_DIR}/MySQL_server_rpms/mysql-shell-commercial-8*.el*.rpm ${BACKUP_DIR}/linux/

	mv ${TEMP_DIR}/MySQL_server_rpms/mysql-commercial-client-8*.rpm ${BACKUP_DIR}/linux/client/
	cp ${TEMP_DIR}/MySQL_server_rpms/mysql-commercial-common-8*.rpm ${BACKUP_DIR}/linux/client/
	cp ${TEMP_DIR}/MySQL_server_rpms/mysql-commercial-libs-8*.rpm ${BACKUP_DIR}/linux/client/
	mv ${TEMP_DIR}/MySQL_server_rpms/mysql-commercial-client-plugins-8*.rpm ${BACKUP_DIR}/linux/client/
	cp ${BACKUP_DIR}/linux/mysql-shell-commercial-8*.el*.rpm ${BACKUP_DIR}/linux/client/

	mv ${TEMP_DIR}/MEM_Service_Monitor/* ${BACKUP_DIR}/linux/monitor
	mv ${TEMP_DIR}/MEM_agent/* ${BACKUP_DIR}/linux/agent

	mv ${TEMP_DIR}/world-db/world.sql ${BACKUP_DIR}/databases/world/
	mv ${TEMP_DIR}/test_db-master/* ${BACKUP_DIR}/databases/employees/

	echo "$(date) - INFO - Create MySQL Server repo" |tee -a ${log_file}
	mv ${TEMP_DIR}/MySQL_server_rpms ${working_dir}/

	echo "$(date) - INFO - Create MySQL connector repo" |tee -a ${log_file}
	mv ${TEMP_DIR}/MySQL_connectors_rpms ${working_dir}/

	# Set premissions
	echo
	echo "$(date) - INFO - Set permissions to critical files" |tee -a ${log_file}
	chmod ug+x ${BACKUP_DIR}/linux/monitor/*.bin
	chmod ug+x ${BACKUP_DIR}/linux/agent/*.bin



	echo "$(date) - INFO - Clean up temporary directory" |tee -a ${log_file}
	rm -rf ${TEMP_DIR}/MySQL_Server_tar ${TEMP_DIR}/MySQL_rpms_repo ${TEMP_DIR}/MEM_Service_Monitor ${TEMP_DIR}/MEM_agent ${TEMP_DIR} ${TEMP_DIR}/$( basename ${WORLD_DB} ) ${TEMP_DIR} ${TEMP_DIR}/$( basename ${EMPLOYEES_DB} )


	# Copy files inside ${WORKSHOP_DIRECTORY} directory
	echo
	echo "$(date) - INFO - Create ${WORKSHOP_DIRECTORY} directory" |tee -a ${log_file}
	if [ ! -d ${WORKSHOP_DIRECTORY} ] ; then
		sudo mkdir ${WORKSHOP_DIRECTORY}
		sudo chown opc:opc ${WORKSHOP_DIRECTORY}
	fi
	sudo chown -R opc:opc ${WORKSHOP_DIRECTORY}

	echo "$(date) - INFO - Copying files inside ${WORKSHOP_DIRECTORY} directory" |tee -a ${log_file}
	cp -r ${BACKUP_DIR}/* ${WORKSHOP_DIRECTORY}/

	echo "$(date) - INFO - ${WORKSHOP_DIRECTORY} directory ready" |tee -a ${log_file}

	echo "$(date) - INFO - Script finished without errors. Please reboot the server before start with the labs" |tee -a ${log_file}


	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

	return $ERR

}



menu_execute_labs_scripts () {
	ERR=0
	unset items_list
	
	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}
	

	# Retrieve all the functions in the section
	lab_functions=(`for i in $(sed -n '/^\#___START_LABS_FUNCTIONS___/,/^\#___END_LABS_FUNCTIONS___/ {p;/^\#___END_LABS_FUNCTIONS___/q}' $0 | awk '/^lab/ {print $1}'); do echo $i; done`)

	items_list+=(`for (( i = 0 ; i < ${#lab_functions[@]}; i++)) ; do echo "$i ${lab_functions[$i]} " ; done`)


   while true
   do
   # Duplicate (make a backup copy of) file descriptor 1 on descriptor 3
   exec 3>&1

   # Generate the dialog box while running dialog in a subshell
   selection=$(dialog \
      --backtitle "MySQL Bootcamp Configuration" \
      --title "Scripts to automatically execute labs" \
      --clear  \
      --cancel-label "Exit" \
      --menu "\nThese options execute the script labs when you have no time to do it manually:" 0 0 ${#lab_functions[@]} \
      ${items_list[@]} \
      2>&1 1>&3)

      # Get dialog's exit status
      exit_status=$?

      # Close file descriptor 3
      exec 3>&-

      # Act on the exit status
      case $exit_status in
      $DIALOG_CANCEL)
         clear
         echo "$(date) - INFO - Scripts menu end" >> ${log_file}
         return $ERR
         ;;
      $DIALOG_ESC)
         clear
         echo "$(date) - INFO - Scripts menu cancelled" >> ${log_file}
         return $ERR
         ;;
      esac

		${lab_functions[$selection]}

		read -p "Press ENTER to continue"
   done


	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

   return $ERR


}



#####################################################
# FUNCTIONS TO EXECUTE THE LABS
#####################################################
#
# In case of lab change, rename a function, create a new function or update the content of the existing functions
# The menu will be changed automatically
#
# Format name of the function "lab<number>_<description_with_underscore_for_spaces>"
#

# Don't delete this line
#___START_MENU_ADVANCED___

create_additional_mysql_servers_on_private_subnet () {
	ERR=0
	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	while true
	do
		read -p "Please insert the subfix used to generate the new server (please use only numbers, letters or dash): " mysql_subfix
	
		if [[ ${mysql_subfix} =~ ^[a-zA-Z0-9\-]+$ ]] ; then break ; fi

	done

	create_mysql_servers ${mysql_subfix}

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

   return $ERR
}

create_mysql_servers_on_public_subnet () {
	ERR=0
	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	while true
	do
		read -p "Please insert the subfix used to generate the new server (please use only numbers, letters or dash): " mysql_subfix
	
		if [[ ${mysql_subfix} =~ ^[a-zA-Z0-9\-]+$ ]] ; then break ; fi

	done

	create_mysql_servers_on_public ${mysql_subfix}

	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

   return $ERR
}

#___END_MENU_ADVANCED___



menu_advanced () {
	ERR=0
	unset items_list
	echo "$(date) - INFO - Start function ${FUNCNAME[0]}" >> ${log_file}

	

	# Retrieve all the functions in the section
	advanced_options=(`for i in $(sed -n '/^\#___START_MENU_ADVANCED___/,/^\#___END_MENU_ADVANCED___/ {p;/^\#___END_MENU_ADVANCED___/q}' $0 | awk '/ \(\) \{$/ {print $1}'); do echo $i; done`)

	items_list+=(`for (( i = 0 ; i < ${#advanced_options[@]}; i++)) ; do echo "$i ${advanced_options[$i]} " ; done`)

   # Define the dialog exit status codes
   : ${DIALOG_OK=0}
   : ${DIALOG_CANCEL=1}
   : ${DIALOG_HELP=2}
   : ${DIALOG_EXTRA=3}
   : ${DIALOG_ITEM_HELP=4}
   : ${DIALOG_ESC=255}

   while true
   do
   # Duplicate (make a backup copy of) file descriptor 1 on descriptor 3
   exec 3>&1

   # Generate the dialog box while running dialog in a subshell
   selection=$(dialog \
      --backtitle "MySQL Bootcamp Configuration" \
      --title "Advanced menu" \
      --clear  \
      --cancel-label "Exit" \
      --menu "\nOptions for non standard bootcamps" 0 0 ${#advanced_options[@]} \
      ${items_list[@]} \
      2>&1 1>&3)

      # Get dialog's exit status
      exit_status=$?

      # Close file descriptor 3
      exec 3>&-

      # Act on the exit status
      case $exit_status in
      $DIALOG_CANCEL)
         clear
         echo "$(date) - INFO - Advanced menu end" >> ${log_file}
         return $ERR
         ;;
      $DIALOG_ESC)
         clear
         echo "$(date) - INFO - Advanced menu cancelled" >> ${log_file}
         return $ERR
         ;;
      esac

		${advanced_options[$selection]}

		read -p "Press ENTER to continue"

   done


	echo "$(date) - INFO - End function ${FUNCNAME[0]}" >> ${log_file}

   return $ERR


}


#####################################################
# DYNAMIC VARIABLES
#####################################################

export working_dir="$( dirname $0 )"
if [[ ! ${working_dir} =~ ^/ ]]; then
	working_dir="$( pwd)/${working_dir}"
fi

export log_file="${working_dir}/$(basename -s .sh $0).log"
if [ $? -ne 0 ] ; then
	ERR=1
	echo "$(date) - ERROR - Unable to create log file ${log_file}" ;
	exit $ERR
fi

# File that control if the script is at its first run or not
already_executed_file="${working_dir}/.$(basename -s .sh $0)_executed"

#export TEMP_DIR=$( mktemp -d )
export TEMP_DIR="$HOME/tmp_$(basename -s .sh $0)"
if [ ! -d "${TEMP_DIR}" ] ; then
	mkdir ${TEMP_DIR}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Unable to create temporary dir ${TEMP_DIR}" ; fi
fi

export BACKUP_DIR="$HOME/bck_$(basename -s .sh $0)"
if [ ! -d "${BACKUP_DIR}" ] ; then
	mkdir ${BACKUP_DIR}
	if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "Unable to create backup dir ${BACKUP_DIR}" ; fi
fi



####################################################################################################################
# MAIN
####################################################################################################################

# Print help
help_asked=$1
help_asked=$(echo ${help_asked} |  tr '[:lower:]' '[:upper:]' )
if [ "X${help_asked}" == 'XHELP' ] ; then
	echo
	echo "Usage:"
	echo "This script download the software for MySQL Bootcamp from https://edelivery.oracle.com"
	echo "and configure this server as application server for MySQL Bootcamps"
	echo
	echo "This script assume that you are running in an empty compute machine inside OCI with"
	echo ". you have an account on edelivery"
	echo ". you already uploaded here the wget.sh file provided by edelivery for MySQL sw inside linux_x64"
	echo ". 10 GB of free space"
	echo ". no ${WORKSHOP_DIRECTORY} directory"
	echo
	exit $ERR
fi

echo "$(date) - INFO - Start" >> ${log_file}
echo "$(date) - INFO - Script version ${VERSION}" >> ${log_file}

echo "$(date) - INFO - Check and if needed install pre-requisites" |tee -a ${log_file}

sudo yum -y -q install dialog wget unzip jq 2>&1 >>${log_file}
ERR=$?
if [ $ERR -ne 0 ] ; then
	stop_execution_for_error $ERR "Issues during required software installation"
fi


# Check OCI installation
command -v oci 2>&1 >/dev/null
if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "OCI CLI not installed" ; fi

# Check OCI configuration
oci os ns get --max-retries 3 >/dev/null 2>&1
if [ $? -ne 0 ] ; then ERR=1 ; stop_execution_for_error $ERR "check OCI CLI configuration" ; fi


# Check oci-metadata
command -v oci-metadata 2>&1 >/dev/null
if [ $? -ne 0 ] ; then
	ERR=1
	stop_execution_for_error $ERR "oci-metadata is required to execute this script and was not possible to install it"
fi

# Check presence of wget file


# If the script is executed without options, do everything in one shot
# If the script is executed with -i option, start with menu
# If the script is executed with -h option, print a short help and exit
# All other options prints an error message


while getopts ":ia" option
do
	case "${option}" in
	i)
		echo "Interactive mode"
		
		echo "$(date) - INFO - Interactive mode" >> ${log_file}
		;;
	h)
		echo "$(date) - INFO - Print help" >> ${log_file}
		echo "Print help"
		exit $ERR
		;;
	*)
		ERR=1
		stop_execution_for_error $ERR "Wrong parameter"
		;;
	esac
done

if [ $OPTIND -eq 1 ]; then
	echo "$(date) - INFO - Automatic mode" >> ${log_file}


	echo "$(date) - INFO - Check if this is the first time executed or it was already started" >> ${log_file}

	if [ -f ${already_executed_file} ] ; then
		ERR=2
		echo "$(date) - WARNING - Script already execute and completed download" | tee -a ${log_file}
		echo "It's strongly suggested to call the instructor to re-execute or run the script with option -i"

		read -p "Do you want to continue [y/N]?" answer
		answer=${answer:='N'}
		answer=$(echo $answer |  tr '[:lower:]' '[:upper:]' )

		if [ $answer != 'Y' ] ; then
			echo "$(date) - WARNING - Script interrupted by user" | tee -a ${log_file}
			exit $ERR
		fi
	fi
	


	set_timezone
	ERR=$?
	if [ $ERR -ne 0 ] ; then stop_execution_for_error $ERR "Problems during timezone set" ; fi
	echo
	echo
	download_software
	ERR=$?
	if [ $ERR -ne 0 ] ; then stop_execution_for_error $ERR "Problems during software download" ; fi

	# Create an hidden file to mark that at least one time the download was completed
	touch ${already_executed_file}


	extract_software
	ERR=$?
	if [ $ERR -ne 0 ] ; then stop_execution_for_error $ERR "Problems during software extraction" ; fi

	setup_app_srv
	ERR=$?
	if [ $ERR -ne 0 ] ; then stop_execution_for_error $ERR "Problems during app-srv configuration" ; fi

	app_srv_security_list
	ERR=$?
	if [ $ERR -ne 0 ] ; then
		echo "$(date) - ERROR - Problems during security list creation" | tee -a ${log_file}
		echo "$(date) - ERROR - Inform your trainer about the error" | tee -a ${log_file}
	fi

	create_mysql_servers 1
	ERR=$?
	if [ $ERR -ne 0 ] ; then
		echo "$(date) - ERROR - Problems during mysql1 instance creation" | tee -a ${log_file}
		echo "$(date) - ERROR - Inform your trainer about the error" | tee -a ${log_file}
	fi

	create_mysql_servers 2
	ERR=$?
	if [ $ERR -ne 0 ] ; then
		echo "$(date) - ERROR - Problems during mysql1 instance creation" | tee -a ${log_file}
		echo "$(date) - ERROR - Inform your trainer about the error" | tee -a ${log_file}
	fi

	create_mysql_servers 3
	ERR=$?
	if [ $ERR -ne 0 ] ; then
		echo "$(date) - ERROR - Problems during mysql1 instance creation" | tee -a ${log_file}
		echo "$(date) - ERROR - Inform your trainer about the error" | tee -a ${log_file}
	fi

else
	echo "$(date) - INFO - Interactive mode" >> ${log_file}

	while true
	do
	# Duplicate (make a backup copy of) file descriptor 1
	# on descriptor 3
	exec 3>&1

	# Generate the dialog box while running dialog in a subshell
	selection=$(dialog \
		--backtitle "MySQL Bootcamp Configuration" \
		--title "Configuration script" \
		--clear  \
		--cancel-label "Exit" \
		--menu "\nPlease follow your trainer instructions to use these commands" 0 0 0\
		"1" "Set timezone on app-srv" \
		"2" "Download the software to use in the labs" \
		"3" "Extract software" \
		"4" "Setup app-srv software and configurations" \
		"5" "Create and apply first security list" \
		"6" "Create server mysql1" \
		"7" "Create server mysql2" \
		"8" "Create server mysql3" \
		"l" "LAB EXECUTION" \
		"a" "Additional options (not for standard bootcamps)" \
		2>&1 1>&3)

		# Get dialog's exit status
		exit_status=$?

		# Close file descriptor 3
		exec 3>&-

		# Act on the exit status
		case $exit_status in
		$DIALOG_CANCEL)
			clear
			echo "$(date) - INFO - Interactive menu end" >> ${log_file}
			exit $ERR
			;;
		$DIALOG_ESC)
			clear
			echo "$(date) - INFO - Interactive menu cancelled" >> ${log_file}
			exit $ERR
			;;
		esac

		case $selection in
		1 )
			set_timezone
			read -p "Press ENTER to continue"
			;;
		2 )
			download_software
			read -p "Press ENTER to continue"
			;;
		3 )
			extract_software
			read -p "Press ENTER to continue"
			;;
		4 )
			setup_app_srv
			read -p "Press ENTER to continue"
			;;
		5 )
			app_srv_security_list
			read -p "Press ENTER to continue"
			;;
		6 )
			create_mysql_servers 1
			read -p "Press ENTER to continue"
			;;
		7 )
			create_mysql_servers 2
			read -p "Press ENTER to continue"
			;;
		8 )
			create_mysql_servers 3
			read -p "Press ENTER to continue"
			;;
		l )
			menu_execute_labs_scripts
			#read -p "Press ENTER to continue"
			;;
		a )
			menu_advanced
			#read -p "Press ENTER to continue"
			;;
		esac
	done
fi

echo "$(date) - INFO - End" >> ${log_file}

exit $ERR


___END_OF_SHELL_SCRIPT___
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
LU15U1FMX0lubm9EQl9DbHVzdGVyX19fUHJlcGFyZV9zZWNvbmRhcnktMi5zaFVUBQADV9DzYXV4
CwABBOgDAAAE6AMAAFBLAQIeAxQAAAAIAOVtOlTgIlCQNQIAACsEAAANABgAAAAAAAEAAAC0gY0I
AABteS5jbmYubXlzcWwxVVQFAAPNQvFhdXgLAAEE6AMAAAToAwAAUEsBAh4DFAAAAAgA5W06VKSR
00VwAgAAkAQAAA0AGAAAAAAAAQAAALCBCQsAAG15LmNuZi5teXNxbDJVVAUAA81C8WF1eAsAAQTo
AwAABOgDAABQSwECHgMUAAAACADlbTpUa08tdD4CAAA4BAAADQAYAAAAAAABAAAAsIHADQAAbXku
Y25mLm15c3FsM1VUBQADzULxYXV4CwABBOgDAAAE6AMAAFBLAQIeAxQAAAAIAOVtOlT6AE2N3gEA
AAAEAAAbABgAAAAAAAEAAAC0gUUQAABteXNxbGJhY2t1cF91c2VyX2dyYW50cy5zcWxVVAUAA81C
8WF1eAsAAQToAwAABOgDAABQSwECHgMUAAAACADlbTpUb5nZcusBAABLAwAAFwAYAAAAAAABAAAA
tIF4EgAAbXlzcWxkLWFkdmFuY2VkLnNlcnZpY2VVVAUAA81C8WF1eAsAAQToAwAABOgDAABQSwUG
AAAAAAcABwCpAgAAtBQAAAAA

# What are essential environment variables that I need to specify in .bash_profile?
Duration: 2 minutes

## Edit the .bash_profile file

1. In Oracle Enterprise Linux, the .bash_profile file is located in the users' home directory. 

      Open the file in edit mode

      ```
      <copy> 
      vi ~/.bash_profile
      </copy>
      ```

      Define the essential variables that are required in the .bash_profile file. The below example shows how you can set environment variables for your database installation. please note some of the variable values might vary according to your database installation

      ```
      <copy>   
      # Get the aliases and functions
      if [ -f ~/.bashrc ]; then
        . ~/.bashrc
      fi

      # User specific environment and startup programs

      export TMP=/tmp
      export TMPDIR=$TMP
      export ORACLE_BASE=/u01/app/oracle
      export DB_HOME=$ORACLE_BASE/product/19c/db_1
      export ORACLE_HOME=$DB_HOME
      export ORACLE_SID=orcl
      export BASE_PATH=/usr/sbin:$PATH
      export ORACLE_PATH=$ORACLE_HOME/bin:$BASE_PATH
      export LD_LIBRARY_PATH=$ORACLE_HOME/lib:/lib:/usr/lib
    
      PATH=$PATH:$HOME/.local/bin:$HOME/bin

      export PATH
      . ~/.set-env.sh 
      </copy>
      ```

2. set the .bash_profile variables
      ```
      <copy>
      source ~/.bash_profile
      </copy>
      ```

## Learn More

* [How to Start, Stop, and Check the Status of the Oracle Database Listeners](https://docs.oracle.com/cd/E97665_01/html/rpm_81_installation_12c/GUID-21D99D16-AAB3-4AF0-A942-26C78D73AB89.htm)

  **Setup**

  **Introduction**
  
  In this lab, we will provision and setup the resources to execute Oracle AQ in your tenancy.

    Estimated Time: 5 minutes


**Objectives**

   - Clone the setup and oracleAQ code
   
   - Execute setup
   
**Task 1: Log in to the Oracle Cloud Console and launch the Cloud Shell**

  If you haven't already, sign in to your account.

**Task 2: Select the Home Region**

  Be sure to select the home region of your tenancy. Setup will only work in the home region.



**Task 3: Check Your Tenancy Service Limits**

  If you have a fresh free trial account with credits then you can be sure that you have enough quota and you can proceed to the next step.

  If, however, you have already used up some quota on your tenancy, perhaps while completing other workshops, there may be insufficient quota left to run this workshop. The most likely quota limits you may reach are summarized in the following table.

          Service	        Scope	        Resources                                          Available   Free Account Limit

          Compute	        AD-1	        Cores for Standard.E2 based VM and BM Instances	        3	6

          Container Engine  Region	        Cluster Count	                                        1	1

          Database	        Region	        Autonomous Transaction Processing Total Storage (TB)	2	2

                            Region	        Autonomous Transaction Processing OCPU Count	        4	8

          LbaaS	        Region	        100Mbps Load Balancer Count	                        3	3
  
  Quota usage and limits can be check through the console: Limits, Quotas and Usage in the Governance & Administration section , For example:



  The Tenancy Explorer is used to locate existing resources: Governance & Administration --> Governance --> Tenancy Explorer. Use the "Show resources in subcompartments" feature to locate all the resources in your tenancy:



  It may be necessary to delete some resources to make space to run the workshop. Once you have enough space you may proceed to the next step.

**Task 4: Launch Cloud Shell**

  Cloud Shell is a small virtual machine running a "bash" shell which you access through the Oracle Cloud Console. Cloud Shell comes with a pre-authenticated command line interface in the tenancy region. It also provides up-to-date tools and utilities.

   1. Click the Cloud Shell icon in the top-right corner of the Console.


  NOTE: Cloud Shell uses websockets to communicate between your browser and the service. If your browser has websockets disabled or uses a corporate proxy that has websockets disabled you will see an error message ("An unexpected error occurred") when attempting to start Cloud Shell from the console. You also can change the browser cookies settings for a specific site to allow the traffic from *.oracle.com

**Task 5: Make a Clone of the Workshop Setup Script and Source Code**

  1. To work with the application code, you need to make a clone from the GitHub repository using the following command.

            

            git clone https://github.com/matayal/microservices-datadriven.git;
            
            cp -r ./microservices-datadriven/oracleAQ $HOME;
            
            rm -r -f microservices-datadriven;

            

  2. Run the following command to edit your .bashrc file so that you will return to the workshop directory when you connect to cloud shell in the future.
   
            

            sed -i.bak '/oracleAQ/d' ~/.bashrc

            

 **Task 6: Start the Setup**
 
  1. Execute the following sequence of commands to start the setup.

            

            source oracleAQ/setup.sh

            
    
  Note, cloud shell may disconnect after a period of inactivity. If that happens, you can reconnect and then run this command to resume the setup:

            

            source setup.sh

            
    
  The setup process will typically take around 5 minutes to complete.

            sed -i.bak '/oracleAQ/d' ~/.bashrc
  
  Once the setup has completed you are ready to move on to Lab 1.







  **Acknowledgements**
  
  **Authors -** Mayank Tayal, Developer Advocate
 
  **Last Updated By/Date -** Mayank Tayal, December 2021

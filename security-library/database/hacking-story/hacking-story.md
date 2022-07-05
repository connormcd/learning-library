# Oracle DB Security - Story of a hack

## Introduction
Cybercriminals are becoming more and more equipped and prepared. So, they now have a huge technological arsenal that allows them to launch their attacks against you from almost everywhere if you are not prepared to deal with them.

Through the example of a Ransomware attack, we will explore in this Livelabs how they operate and what features you should use to prevent, detect and mitigate the risks.

*Estimated Lab Time:* 60 minutes

*Version tested in this lab:* Oracle DB EE 19.13

### Video Preview
None for the moment

### Objectives
- Mitigate a SQL Injection
- Assess DB vulnerabilities
- Detect, prevent and mitigate data exfiltration
- Detect and prevent abuses of high privileges

### Prerequisites
This lab assumes you have:
- A Free Tier, Paid or LiveLabs Oracle Cloud account
- You have completed:
    - Lab: Prepare Setup (*Free-tier* and *Paid Tenants* only)
    - Lab: Environment Setup
    - Lab: Initialize Environment

### Lab Timing (estimated)

| Step No. | Feature | Approx. Time | Details |
|--|------------------------------------------------------------|-------------|--------------------|
| 1| Mitigate a SQL Injection | <10 minutes||
| 2| Prevent exploitation of DB vulnerabilities | <10 minutes||
| 3| Prevent a data exfiltration from the network | <10 minutes||
| 4| Detect and mitigate a data exfiltration from the App | <10 minutes||
| 5| Prevent a data exfiltration from the disk | <10 minutes||
| 6| Prevent a data exfiltration from the non-prod env | <10 minutes||
| 7| Prevent abuses of high privileges | <10 minutes||
| 8| Secure your backup/restore steps | <5 minutes||

## Foreword
Before starting, let us explain why we chose to use the **Ransomware attack (1)** as an example to demonstrate Oracle's DB Security solutions.

First of all, because this is one of the main threats in the world today according to the latest [ENISA report](https://www.enisa.europa.eu/publications/enisa-threat-landscape-2021) (the number of attacks is increasing every day and all sectors are affected without exception), but also because it has greatly metamorphosed since its beginnings to become today the preferred attack to exfiltrate the sensitive data of a company.

Indeed, if we refer to the first uses of Ransomware attacks, they were majoritarely limited to DDOS (Distributed Denial of Service) only and were defined a few years ago as "**a type of malicious attack where the attackers encrypt the organization's data and demand payment to restore access**" (NIST definition). True or false, encrypted data was a pretext to impose the payment of the ransom!

From then on, the only 2 options available to you were :
- **pay the ransom** to hope to eventually obtain the decryption key and thus recover your data... but with no guarantee that it will work, or even that the attackers will not try again later.
- **don't pay the ransom** and restore your system from your backups... hoping that they are still physically available, consistent and restorable quickly enough to preserve your business.

But in any case, if you are not prepared for this eventuality and have not anticipated anything, then the threat that this type of attack poses to your business is enormous and seeing this message below will put you in a state of extreme stress!

![](./images/hack-001.png "Concept")

Unfortunately, according the [MS-ISAC Ransomware definition in 2020](https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&ved=2ahUKEwjAo9Wi_fX3AhUG_IUKHVTIDcUQFnoECBUQAQ&url=https%3A%2F%2Fwww.cisa.gov%2Fsites%2Fdefault%2Ffiles%2Fpublications%2FCISA_MS-ISAC_Ransomware%2520Guide_S508C.pdf&usg=AOvVaw1T7xwLzdEx9zlCoNSNytU0), "**malicious actors have adjusted their Ransomware tactics over time to include pressuring victims to pay by threatening to release stolen data if they refuse to pay and publicly naming and shaming victims as secondary forms of extortion.**"
And be careful, because these new pressure tactics are formidable and terribly effective!

In short, even if you have a good backup or a redundant system, and you are sure you can restore everything quickly, attackers threaten to disclose publicly all your secrets and sensitive data if you persist in not wanting to pay.

In other words, before encrypting your system to make it unavailable with the Ransomware, the attackers make sure that they have exfiltrated and set aside all your sensitive data beforehand to stand ready to leak and sell it if you refuse to pay the ransom!
And if you have not been able to prevent this exfiltration beforehand, or simply detect it to stop it, then the trap is inexorably closing in on you.

From now, the Ransomware attack is no longer an end in itself, but rather the final step in a much more sophisticated attack, allowing to erase its traces and creating a diversion.

Fortunately for you, the Oracle database is one of the best equipped databases on the market in terms of prevention, detection and analysis of cyberthreats.

Let's walk through the protocols that attackers use to exfiltrate your data before encrypting your system to make it inoperable.
Once you understand how they do it, it will be easier for you to understand how to prevent them from harming you.

>(1) To know more about Ransomware attack protocol, please read the "**Appendix:** About the Ransomware attack protocol" below

## Task 1: Mitigate a SQL Injection

## Task 2: Prevent exploitation of DB vulnerabilities

## Task 3: Prevent a data exfiltration from the network

## Task 4: Detect and mitigate a data exfiltration from the App

## Task 5: Prevent a data exfiltration from the disk

## Task 6: Prevent a data exfiltration from the non-prod env

## Task 7: Prevent abuses of high privileges

## Task 8: Secure your backup/restore steps


You may now proceed to the next lab!

## **Appendix**: About the Ransomware attack protocol
### **Overview**
Privilege analysis increases the security of your applications and database operations by helping you to implement least privilege best practices for database roles and privileges.

## Want to Learn More?
To discover in more detail all the features described in this workshop and to know how to set them up, you can do their dedicated workshop:
- [DB Security Basics](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=698)
- [DB Security Advanced](https://apexapps.oracle.com/pls/apex/dbpm/r/livelabs/view-workshop?wid=726)

## Acknowledgements
- **Author** - Hakim Loumi, Database Security PM
- **Contributors** - Peter Wahl, Rene Fontcha
- **Last Updated By/Date** - Hakim Loumi, Database Security PM - May 2022

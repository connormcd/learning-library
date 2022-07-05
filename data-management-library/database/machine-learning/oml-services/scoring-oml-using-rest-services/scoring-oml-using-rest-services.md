# Score Data using OML Services

In this lab we will learn about accessing our deployed machine learning model using the OML Services REST API.  We will use Postman and cURL to invoke the REST API, the required software is pre-installed on the virtual machine assigned.


Estimated Time: 15 minutes

### Objectives
* Use POSTMAN to invoke a REST endpoint to get the Authentication Token
* Use the model to score data using POSTMAN
* Run the cURL command to get the Authentication Token
* Use the model to score data using CURL

### Prerequisites
* The OML model deployed to OML Services.
* POSTMAN and cURL available on your working environment

##  

## Task 1: Access the model using REST APIs using POSTMAN

### Task 1.1: Prepare the REST calls


* Open a terminal and launch the Postman Application by running
    ````
    <copy>./OML-Services/Postman/Postman</copy>
    ````

    ![Launch Postman](images/automl-screenshot-20.jpg)

  Postman registration is not necessary for this workshop therefore you can choose Skip on the login page.

     ![Launch Postman](images/automl-screenshot-20a.jpg)
  You can close the scratchpad banner and hide the sidebar for a cleaner view.

  ![Launch Postman](images/automl-screenshot-21.jpg)


### Task 1.2: Authorize OML Services User

  To access OML Services using the REST API, you must provide an access token. To authenticate and obtain an access token, use the following POST command and the header to pass the user name and password for your Oracle Machine Learning Services account against the OML User Management Cloud Service REST endpoint /oauth2/v1/token.

  The access token has a life span of one hour and can be refreshed before it expires.
    - A token can be refreshed up to 8 hours.
    - A token can be revoked, and a revoked token cannot be refreshed.
    - Each token can be used many times.
    - The token is tied to the user who authenticates using the database credential.

  Use the following URL structure to access the REST endpoints:

  ````
  https://**<oml-cloud-service-location-url>**.oraclecloudapps.com
  ````

  Where:
     - `<oml-cloud-service-location-url>`: is a variable containing the REST server portion of the Oracle Machine Learning User Management Cloud Service instance URL that includes the tenancy ID, region and database name.

#### Obtain the `oml-cloud-service-location-url` URL

  * In the Autonomous Database instance details page. Click on the Service Console button.
  ![ADB-instance-home](images/prerequisites-screenshot-22.jpg)

  * The service console is opened. Go to the Development section in the left side.
  ![ADB-service-console](images/prerequisites-screenshot-23.jpg)

  * In the Development section, notice the **Oracle Machine Learning RESTful services** section.
  ![ADB-service-console](images/prerequisites-screenshot-X23.jpg)

    The 2 important URLs from this section:
      + The URL to obtain a REST authentication token for OML-provided REST APIs:
      `https://<oml-cloud-service-location-url>.oraclecloudapps.com/omlusers/`

      + All OML Services REST APIs use the following common base URL:
      `https://<oml-cloud-service-location-url>.oraclecloudapps.com/omlmod/`

#### Generate Access Token

  To generate the access token we will need the following details:

  ````
  Operation: POST

  URI endpoint:
  <copy>https://<oml-cloud-service-location-url>.oraclecloudapps.com/omlusers/api/oauth2/v1/token</copy>

  ````

  > Replace **`<oml-cloud-service-location-url>`** with your URL.


  In the header Tab enter the details:

  ````
  --header 'Content-Type: application/json'
  --header 'Accept: application/json'
  ````

  ![Postman token headers](images/automl-screenshot-22.jpg)

  In the Body tab, pick RAW format and enter the following:

  ````
  <copy>
  {
     "grant_type":"password",
     "username":"OMLUSER",
     "password":"Welcome12345"
  }
  </copy>
  ````
  ![Postman token body](images/automl-screenshot-23.jpg)

  Click **Send**

  The response in JSON format and it contains the access token:

  ![Postman token](images/automl-screenshot-24.jpg)

  Choose the display format in RAW and copy the token starting from ``:"``  up until ``==``. In the above example the token is:

  >{"accessToken":"**eyJhbGci....6zIw==**","expiresIn":3600,"tokenType":"Bearer"}

  ![Postman token copy](images/automl-screenshot-25.jpg)


### Task 1.3:  Use REST calls to predict customer classification

  In this Task we can test our prediction for 3 distinct customers from the CUSTOMER\_INSURANCE table:
   - ``CUST_ID = CU12350`` , ``LAST = FRAN``, ``FIRST = HOBBS``
   - ``CUST_ID = CU12331`` , ``LAST = AL`` , ``FIRST = FRANK``
   - ``CUST_ID = CU12286`` , ``LAST = ELLIOT`` , ``FIRST = PADGETT``


  Open a new POSTMAN tab.

  ![New Postman Tab](images/automl-screenshot-26.jpg)

  Enter the following details:

    ````
    Operation: POST

    URI endpoint:
    <copy>https://<oml-cloud-service-location-url>.oraclecloudapps.com/omlmod/v1/deployment/<model_URI>/score</copy>

    ````

   - Replace **`<oml-cloud-service-location-url>`** with your URL.
   - Replace **`<model_URI>`** with the model URI that we defined in Task 3: **``classsvmg``**

  ![Postman Model Score](images/automl-screenshot-27.jpg)

  In the header Tab enter the details:

    ````
    --header 'Content-Type: application/json'

    ````

  ![Postman Model Score Header](images/automl-screenshot-28.jpg)

  In the Authorization tab pick **Bearer Token** and paste the token copied above in the field.

  ![Postman Model Score Access](images/automl-screenshot-29.jpg)

  In the Body tab enter the Fran Hobs data in RAW format.

    ````
    <copy>
    {
       "inputRecords":[
          {
             "CUST_ID":"CU12350",
             "LAST":"FRAN",
             "FIRST":"HOBBS",
             "STATE":"NV",
             "REGION":"Southwest",
             "SEX":"F",
             "PROFESSION":"Programmer/Developer",
             "BUY_INSURANCE":"No",
             "AGE":21,
             "HAS_CHILDREN":0,
             "SALARY":66180,
             "N_OF_DEPENDENTS":5,
             "CAR_OWNERSHIP":1,
             "HOUSE_OWNERSHIP":0,
             "TIME_AS_CUSTOMER":5,
             "MARITAL_STATUS":"SINGLE",
             "CREDIT_BALANCE":0,
             "BANK_FUNDS":500,
             "CHECKING_AMOUNT":185,
             "MONEY_MONTLY_OVERDRAWN":53.21,
             "T_AMOUNT_AUTOM_PAYMENTS":197,
             "MONTHLY_CHECKS_WRITTEN":4,
             "MORTGAGE_AMOUNT":0,
             "N_TRANS_ATM":3,
             "N_MORTGAGES":0,
             "N_TRANS_TELLER":2,
             "CREDIT_CARD_LIMITS":2500,
             "N_TRANS_KIOSK":4,
             "N_TRANS_WEB_BANK":0
          }
       ]
    }
    </copy>
    ````

  ![Postman Model Score Fran Hobs](images/automl-screenshot-30.jpg)

  Click **Send**.

  ![Postman Model Score Fran Hobs Result](images/automl-screenshot-31.jpg)

  Notice the result in JSON format shows the probability for this customer to be in each group:
  + For HIGH is ``6.998515445640917E-4``  therefore it is  ``0.0006998515445640917`` which is 0.0006% a very small probability.
  + For **LOW** is ``0.9990535462218914``  which is 99% very close to 100%.
  + For MEDIUM is ``1.284866588349918E-4``  which is 0.00012% a very small probability.
  + For VERY HIGH is ``1.1811557470959117E-4``  which is 0.001% a very small probability.


  We can test now our second candidate:  AL FRANK. Copy the following Json data in the Body tab and click **Send**.

      ````
      <copy>
      {
         "inputRecords":[
            {
               "CUST_ID":"CU12331",
               "LAST":"AL",
               "FIRST":"FRANK",
               "STATE":"WA",
               "REGION":"West",
               "SEX":"M",
               "PROFESSION":"Programmer/Developer",
               "BUY_INSURANCE":"No",
               "AGE":21,
               "HAS_CHILDREN":0,
               "SALARY":75415,
               "N_OF_DEPENDENTS":3,
               "CAR_OWNERSHIP":1,
               "HOUSE_OWNERSHIP":0,
               "TIME_AS_CUSTOMER":3,
               "MARITAL_STATUS":"SINGLE",
               "CREDIT_BALANCE":0,
               "BANK_FUNDS":250,
               "CHECKING_AMOUNT":25,
               "MONEY_MONTLY_OVERDRAWN":53.06,
               "T_AMOUNT_AUTOM_PAYMENTS":257,
               "MONTHLY_CHECKS_WRITTEN":0,
               "MORTGAGE_AMOUNT":0,
               "N_TRANS_ATM":0,
               "N_MORTGAGES":0,
               "N_TRANS_TELLER":2,
               "CREDIT_CARD_LIMITS":1500,
               "N_TRANS_KIOSK":4,
               "N_TRANS_WEB_BANK":0
            }
         ]
      }
      </copy>
      ````

  ![Postman Model Score Al Frank Result](images/automl-screenshot-32.jpg)


  Notice the result in JSON format shows the probability for this customer to be in each group:
  - For HIGH is ``0.11283194843494257`` which is 1,1% a very small probability.
  - For LOW is ``7.999161383001122E-7``  which is 0.0000007% a very small probability.
  - For **MEDIUM** is ``0.8871672012998799``  which is 88.7%  close to 100%.
  - For VERY HIGH is ``5.034903924262419E-8``  which is 0.00000005% a very small probability.


  We can test now our third candidate: ELLIOT PADGETT. Copy the following Json data in the Body tab and click **Send**.

    ````
    <copy>
    {
       "inputRecords":[
          {
             "CUST_ID":"CU12286",
             "LAST":"ELLIOT",
             "FIRST":"PADGETT",
             "STATE":"NV",
             "REGION":"Southwest",
             "SEX":"M",
             "PROFESSION":"Programmer/Developer",
             "BUY_INSURANCE":"Yes",
             "AGE":23,
             "HAS_CHILDREN":0,
             "SALARY":69724,
             "N_OF_DEPENDENTS":3,
             "CAR_OWNERSHIP":1,
             "HOUSE_OWNERSHIP":1,
             "TIME_AS_CUSTOMER":3,
             "MARITAL_STATUS":"SINGLE",
             "CREDIT_BALANCE":0,
             "BANK_FUNDS":500,
             "CHECKING_AMOUNT":81,
             "MONEY_MONTLY_OVERDRAWN":52.96,
             "T_AMOUNT_AUTOM_PAYMENTS":164,
             "MONTHLY_CHECKS_WRITTEN":4,
             "MORTGAGE_AMOUNT":250,
             "N_TRANS_ATM":2,
             "N_MORTGAGES":1,
             "N_TRANS_TELLER":2,
             "CREDIT_CARD_LIMITS":1500,
             "N_TRANS_KIOSK":4,
             "N_TRANS_WEB_BANK":250
          }
       ]
    }
    </copy>
    ````

  ![Postman Model Score ELLIOT PADGETT Result](images/automl-screenshot-33.jpg)


  Notice the result in JSON format shows the probability for this customer to be in each group:
  - For **HIGH** is ``0.9973930279636027`` which is 99.7% very close to 100%.
  - For LOW is ``1.5931860729876854E-6``  which is 0.00001% a very small probability.
  - For MEDIUM is ``0.0026053528320562043``  which is 0.2% a very small probability.
  - For VERY HIGH is ``2.601826805465904E-8``  which is 0.00000002% a very small probability.



## Task 2: Access the model using REST APIs using cURL

### Task 2.1: Prepare the REST calls

To access OML Services using the REST API, you must provide an access token. To authenticate and obtain an access token, use cURL with the -d option to pass the user name and password for your OML Services account against the Oracle Machine Learning User Management Cloud Service REST endpoint /oauth2/v1/token.

* In the VM open a terminal and export the environment

    ````
    <copy>
    export omlserver=https://<oml-cloud-service-location-url>.oraclecloudapps.com
    export username=OMLUSER
    export password=Welcome12345
    </copy>
    ````

  - Replace **`<oml-cloud-service-location-url>`** with your URL.



* Run this statement to get the token to be used later  (replace what is needed)

    ````
    $<copy>curl -X POST --header 'Content-Type: application/json' --header 'Accept: application/json' -d '{"grant_type":"password", "username":"'${username}'", "password":"'${password}'"}' "${omlserver}/omlusers/api/oauth2/v1/token"</copy>

    {"accessToken":"eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJPTUxVU0VSIiwidGVuYW50X25hbWUiOiJPQ0lEMS5URU5BTkNZLk9DMS4uQUFBQUFBQUFGSjM3TVlUWDIyT1FVT1JDWk5MRlVINzdDRDQ1SU5UN1RUN0ZPMjdUVUVKU0ZRQllCWlJRIiwiZGF0YWJhc2VfbmFtZSI6IkFUUDA0Iiwicm9sZXMiOiJbe1wicm9sZVwiOlwiT01MX0RFVkVMT1BFUlwiLFwiY29tbW9uXCI6ZmFsc2V9XSIsImlzcyI6IkIxOTBDQUJBMEY3ODYxQUFFMDUzNkYxODAwMEE1M0JDIiwiZXhwIjoxNjI2NzkwNTMyLCJpYXQiOjE2MjY3ODY5MzJ9.V61pqfjXRWe4v-nqaxSPGvdCLWDvrUszLOCc_GWdKNJWXaNAsxR_b_BgwbrSBY2rJJJ0XchlDP9khFX1vhBVgHxUJfHGW9sdYPyu5KgGozRENldjte57E2XeupUqNkQot7APTu0mmpMufF_HOSW__I65TpXxPrB9Rv3EHkT9gaOhFQTj_xByAXTqZI7inSxxa5p6AOszoEuylF7wikO1WAT_GcJaCmUqLevsoc8QNNQFCUo3g_918wgiJWYqtf5qw6ZuxNi6HOjUCR8Pi722PP6H7Q1E5WwIIl9qSnMPQTeYcMO34wD58MngkJ9N0D51BK5QS6K0Da4QLPrLmDFACQ!NL/okRBiTH9JfS2eeuG+mRlNUOwD4Qxq6/VGDYIBuQrYN4E+8en/OmEjKEdduFcJZe+747aXXrVfA61zJ38AjIvWOCdS7WnoJ156Ohx541/a28+vpBbwXhkCxogyDXphpqE63oKP75hCKgKPDZWWhPKhJaWeMcFy2xpRq1bt0Vz4zthhv7XHANx2TZDs1oj684PiPSAXX1seJSy4TFgyV9OrOgCThkZe5rPs7LIlR46bKCuYb4mXs47i8crqu71Jv2bit7dgtMetrwlgVywz9PZSl3WPrHEzxeqH9iF82DEIa6tlH/EUy0B9OC6Fc5LB4WeeQfUwiumoXMr0iEdACA==","expiresIn":3600,"tokenType":"Bearer"}
    ````
    Copy the token starting from ``:"``  up until ``==``. In the above example the token is:
    `` eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJPTUxVU0VSIiwidGVuYW50X25hbWUiOiJPQ0lEMS5URU5BTkNZLk9DMS4uQUFBQUFBQUFGSjM3TVlUWDIyT1FVT1JDWk5MRlVINzdDRDQ1SU5UN1RUN0ZPMjdUVUVKU0ZRQllCWlJRIiwiZGF0YWJhc2VfbmFtZSI6IkFUUDA0Iiwicm9sZXMiOiJbe1wicm9sZVwiOlwiT01MX0RFVkVMT1BFUlwiLFwiY29tbW9uXCI6ZmFsc2V9XSIsImlzcyI6IkIxOTBDQUJBMEY3ODYxQUFFMDUzNkYxODAwMEE1M0JDIiwiZXhwIjoxNjI2NzkwNTMyLCJpYXQiOjE2MjY3ODY5MzJ9.V61pqfjXRWe4v-nqaxSPGvdCLWDvrUszLOCc_GWdKNJWXaNAsxR_b_BgwbrSBY2rJJJ0XchlDP9khFX1vhBVgHxUJfHGW9sdYPyu5KgGozRENldjte57E2XeupUqNkQot7APTu0mmpMufF_HOSW__I65TpXxPrB9Rv3EHkT9gaOhFQTj_xByAXTqZI7inSxxa5p6AOszoEuylF7wikO1WAT_GcJaCmUqLevsoc8QNNQFCUo3g_918wgiJWYqtf5qw6ZuxNi6HOjUCR8Pi722PP6H7Q1E5WwIIl9qSnMPQTeYcMO34wD58MngkJ9N0D51BK5QS6K0Da4QLPrLmDFACQ!NL/okRBiTH9JfS2eeuG+mRlNUOwD4Qxq6/VGDYIBuQrYN4E+8en/OmEjKEdduFcJZe+747aXXrVfA61zJ38AjIvWOCdS7WnoJ156Ohx541/a28+vpBbwXhkCxogyDXphpqE63oKP75hCKgKPDZWWhPKhJaWeMcFy2xpRq1bt0Vz4zthhv7XHANx2TZDs1oj684PiPSAXX1seJSy4TFgyV9OrOgCThkZe5rPs7LIlR46bKCuYb4mXs47i8crqu71Jv2bit7dgtMetrwlgVywz9PZSl3WPrHEzxeqH9iF82DEIa6tlH/EUy0B9OC6Fc5LB4WeeQfUwiumoXMr0iEdACA==``

    Don't forget to add a single quote at the beginning and at the end.

    ````
    $<copy> export token='eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiJPTUxVU0VSIiwidGVuYW50X25hbWUiOiJPQ0lEMS5URU5BTkNZLk9DMS4uQUFBQUFBQUFGSjM3TVlUWDIyT1FVT1JDWk5MRlVINzdDRDQ1SU5UN1RUN0ZPMjdUVUVKU0ZRQllCWlJRIiwiZGF0YWJhc2VfbmFtZSI6IkFUUDA0Iiwicm9sZXMiOiJbe1wicm9sZVwiOlwiT01MX0RFVkVMT1BFUlwiLFwiY29tbW9uXCI6ZmFsc2V9XSIsImlzcyI6IkIxOTBDQUJBMEY3ODYxQUFFMDUzNkYxODAwMEE1M0JDIiwiZXhwIjoxNjI2NzkwNTMyLCJpYXQiOjE2MjY3ODY5MzJ9.V61pqfjXRWe4v-nqaxSPGvdCLWDvrUszLOCc_GWdKNJWXaNAsxR_b_BgwbrSBY2rJJJ0XchlDP9khFX1vhBVgHxUJfHGW9sdYPyu5KgGozRENldjte57E2XeupUqNkQot7APTu0mmpMufF_HOSW__I65TpXxPrB9Rv3EHkT9gaOhFQTj_xByAXTqZI7inSxxa5p6AOszoEuylF7wikO1WAT_GcJaCmUqLevsoc8QNNQFCUo3g_918wgiJWYqtf5qw6ZuxNi6HOjUCR8Pi722PP6H7Q1E5WwIIl9qSnMPQTeYcMO34wD58MngkJ9N0D51BK5QS6K0Da4QLPrLmDFACQ!NL/okRBiTH9JfS2eeuG+mRlNUOwD4Qxq6/VGDYIBuQrYN4E+8en/OmEjKEdduFcJZe+747aXXrVfA61zJ38AjIvWOCdS7WnoJ156Ohx541/a28+vpBbwXhkCxogyDXphpqE63oKP75hCKgKPDZWWhPKhJaWeMcFy2xpRq1bt0Vz4zthhv7XHANx2TZDs1oj684PiPSAXX1seJSy4TFgyV9OrOgCThkZe5rPs7LIlR46bKCuYb4mXs47i8crqu71Jv2bit7dgtMetrwlgVywz9PZSl3WPrHEzxeqH9iF82DEIa6tlH/EUy0B9OC6Fc5LB4WeeQfUwiumoXMr0iEdACA=='</copy>
    ````
### Task 2.2: Use REST calls to predict customer classification

* We will check the predicted classification for 3 distinct customers

    ````
    <copy>curl -X POST "${omlserver}/omlmod/v1/deployment/classsvmg/score" \
    --header "Authorization: Bearer ${token}" \
    --header 'Content-Type: application/json' \
    -d '{
     "inputRecords":[
        {
           "CUST_ID":"CU12350",
           "LAST":"FRAN",
           "FIRST":"HOBBS",
           "STATE":"NV",
           "REGION":"Southwest",
           "SEX":"F",
           "PROFESSION":"Programmer/Developer",
           "BUY_INSURANCE":"No",
           "AGE":21,
           "HAS_CHILDREN":0,
           "SALARY":66180,
           "N_OF_DEPENDENTS":5,
           "CAR_OWNERSHIP":1,
           "HOUSE_OWNERSHIP":0,
           "TIME_AS_CUSTOMER":5,
           "MARITAL_STATUS":"SINGLE",
           "CREDIT_BALANCE":0,
           "BANK_FUNDS":500,
           "CHECKING_AMOUNT":185,
           "MONEY_MONTLY_OVERDRAWN":53.21,
           "T_AMOUNT_AUTOM_PAYMENTS":197,
           "MONTHLY_CHECKS_WRITTEN":4,
           "MORTGAGE_AMOUNT":0,
           "N_TRANS_ATM":3,
           "N_MORTGAGES":0,
           "N_TRANS_TELLER":2,
           "CREDIT_CARD_LIMITS":2500,
           "N_TRANS_KIOSK":4,
           "N_TRANS_WEB_BANK":0
        }
     ]
    }'
    </copy>
    ````

  The results for the customer with ``CUST_ID = CU12350`` , ``LAST = FRAN``, ``FIRST = HOBBS`` are similar to:
    ```
    {"scoringResults":[{"classifications":[{"label":"HIGH","probability":6.998515445640917E-4},{"label":"LOW","probability":0.9990535462218914},{"label":"MEDIUM","probability":1.284866588349918E-4},{"label":"VERY HIGH","probability":1.1811557470959117E-4}]}]}
    ```

   Notice the probability for this customer to be in each group:
   + For HIGH is ``6.998515445640917E-4``  therefore it is  ``0.0006998515445640917`` which is 0.0006% a very small probability.
   + For **LOW** is ``0.9990535462218914``  which is 99% very close to 100%.
   + For MEDIUM is ``1.284866588349918E-4``  which is 0.00012% a very small probability.
   + For VERY HIGH is ``1.1811557470959117E-4``  which is 0.001% a very small probability.

   Now we will score all 3 customers in the same command:

    ````
    <copy>
    curl -X POST "${omlserver}/omlmod/v1/deployment/classsvmg/score" \
    --header "Authorization: Bearer ${token}" \
    --header 'Content-Type: application/json' \
    -d '{
     "inputRecords":[
        {
           "CUST_ID":"CU12331",
           "LAST":"AL",
           "FIRST":"FRANK",
           "STATE":"WA",
           "REGION":"West",
           "SEX":"M",
           "PROFESSION":"Programmer/Developer",
           "BUY_INSURANCE":"No",
           "AGE":21,
           "HAS_CHILDREN":0,
           "SALARY":75415,
           "N_OF_DEPENDENTS":3,
           "CAR_OWNERSHIP":1,
           "HOUSE_OWNERSHIP":0,
           "TIME_AS_CUSTOMER":3,
           "MARITAL_STATUS":"SINGLE",
           "CREDIT_BALANCE":0,
           "BANK_FUNDS":250,
           "CHECKING_AMOUNT":25,
           "MONEY_MONTLY_OVERDRAWN":53.06,
           "T_AMOUNT_AUTOM_PAYMENTS":257,
           "MONTHLY_CHECKS_WRITTEN":0,
           "MORTGAGE_AMOUNT":0,
           "N_TRANS_ATM":0,
           "N_MORTGAGES":0,
           "N_TRANS_TELLER":2,
           "CREDIT_CARD_LIMITS":1500,
           "N_TRANS_KIOSK":4,
           "N_TRANS_WEB_BANK":0
        },
        {
           "CUST_ID":"CU12350",
           "LAST":"FRAN",
           "FIRST":"HOBBS",
           "STATE":"NV",
           "REGION":"Southwest",
           "SEX":"F",
           "PROFESSION":"Programmer/Developer",
           "BUY_INSURANCE":"No",
           "AGE":21,
           "HAS_CHILDREN":0,
           "SALARY":66180,
           "N_OF_DEPENDENTS":5,
           "CAR_OWNERSHIP":1,
           "HOUSE_OWNERSHIP":0,
           "TIME_AS_CUSTOMER":5,
           "MARITAL_STATUS":"SINGLE",
           "CREDIT_BALANCE":0,
           "BANK_FUNDS":500,
           "CHECKING_AMOUNT":185,
           "MONEY_MONTLY_OVERDRAWN":53.21,
           "T_AMOUNT_AUTOM_PAYMENTS":197,
           "MONTHLY_CHECKS_WRITTEN":4,
           "MORTGAGE_AMOUNT":0,
           "N_TRANS_ATM":3,
           "N_MORTGAGES":0,
           "N_TRANS_TELLER":2,
           "CREDIT_CARD_LIMITS":2500,
           "N_TRANS_KIOSK":4,
           "N_TRANS_WEB_BANK":0
        },
        {
           "CUST_ID":"CU12286",
           "LAST":"ELLIOT",
           "FIRST":"PADGETT",
           "STATE":"NV",
           "REGION":"Southwest",
           "SEX":"M",
           "PROFESSION":"Programmer/Developer",
           "BUY_INSURANCE":"Yes",
           "AGE":23,
           "HAS_CHILDREN":0,
           "SALARY":69724,
           "N_OF_DEPENDENTS":3,
           "CAR_OWNERSHIP":1,
           "HOUSE_OWNERSHIP":1,
           "TIME_AS_CUSTOMER":3,
           "MARITAL_STATUS":"SINGLE",
           "CREDIT_BALANCE":0,
           "BANK_FUNDS":500,
           "CHECKING_AMOUNT":81,
           "MONEY_MONTLY_OVERDRAWN":52.96,
           "T_AMOUNT_AUTOM_PAYMENTS":164,
           "MONTHLY_CHECKS_WRITTEN":4,
           "MORTGAGE_AMOUNT":250,
           "N_TRANS_ATM":2,
           "N_MORTGAGES":1,
           "N_TRANS_TELLER":2,
           "CREDIT_CARD_LIMITS":1500,
           "N_TRANS_KIOSK":4,
           "N_TRANS_WEB_BANK":250
        }
     ],
     "topN":1
    }'
    </copy>
    ````
    Here, topN filters the classification result showing the N highest probabilities, in our case only the highest probability.
    The results should be similar to:

    ```
     {"scoringResults":[{"classifications":[{"label":"MEDIUM","probability":0.8871672012998799}]},{"classifications":[{"label":"LOW","probability":0.9990535462218914}]},{"classifications":[{"label":"HIGH","probability":0.9973930279636027}]}]}
    ```

    For "AL FRANK", the highest probability is "MEDIUM" with 0.8871672012998799.

    For "FRAN HOBBS"", the highest probability is "LOW" with :0.9990535462218914.

    For "ELLIOT PADGETT", the highest probability is "HIGH" with 0.9973930279636027.


> Notice the predictions made using the CURL calls are the same as using POSTMAN or using SQL in the OML Notebooks.

## Acknowledgements
* **Authors** -  Andrei Manoliu, Milton Wan
* **Contributors** - Rajeev Rumale
* **Last Updated By/Date** -  Andrei Manoliu, December 2021

## Need Help?
Please submit feedback or ask for help using our [LiveLabs Support Forum](https://community.oracle.com/tech/developers/categories/livelabsdiscussions). Please click the **Log In** button and login using your Oracle Account. Click the **Ask A Question** button to the left to start a *New Discussion* or *Ask a Question*.  Please include your workshop name and lab name.  You can also include screenshots and attach files.  Engage directly with the author of the workshop.

If you do not have an Oracle Account, click [here](https://profile.oracle.com/myprofile/account/create-account.jspx) to create one.

# Introduction to Oracle Machine Learning for Python

## Introduction

This lab walks you through the steps to create a database table, create a proxy object, explore and prepare data, build and evaluate models, and use those models to score data using OML4Py. This will use a classification example available in OML Notebooks. For illustrative purposes, Task 1 and Task 2 of this lab use iris data set from sklearn datasets to create a database table. The rest of the steps take you through the example that uses the SH schema and is available in OML Notebooks. In Oracle Autonomous Database (ADB), the SH schema and associated data sets are easily accessible.

Estimated Time: 30 minutes

### About Oracle Machine Learning for Python(OML4Py)

Oracle Machine Learning for Python (OML4Py) is a component of Oracle Autonomous (ADB), which includes Oracle Autonomous Data Warehouse (ADW), Oracle Autonomous Transaction Processing (ATP), and Oracle Autonomous JSON Database (AJD). OML4Py is also included with on-premise Oracle Database and Database Cloud Service with separate installation. By using OML Notebooks, you can use standard Python syntax and overloaded Python functions, use a natural Python API to load in-database machine learning algorithms, call user-defined Python functions in database-spawned and controlled Python engines, and leverage automated machine learning (AutoML).

### Objectives

In this lab, you will learn how to:
* Create a temporary table using the `oml.push` function
* Create a persistent table using the `oml.create` function
* Create a proxy object from a table
* Explore the data
*	Prepare the data
*	Build your model
*	Evaluate your model using standard classification metrics
*	Score data for deployment
* Save and load python objects in a datastore instance

### Prerequisites

This lab assumes you have:
* An Oracle Machine Learning account
* Completed Lab 1: Oracle Machine Learning Notebooks

## Task 1: Create a Database Table

With OML4Py, you can create Python proxy objects that can be used to access, analyze, and manipulate data that reside in the database. OML4Py uses these proxy objects and transparently translates many standard Python functions into SQL. First access the OML4Py Classification DT (1) notebook and then create the database table.

### Access the OML4Py Classification DT (1) notebook

This step illustrates how you can access the OML4Py Classification DT (1) notebook available on the Notebook page which was created in Lab 1. The OML4Py Classification DT (1) notebook was created based on the example template of the OML4Py Classification Decision Tree.

1. Click the hamburger icon ![Hamburger Icon](images/hamburger.png) on the top left corner of the page to open the left navigation menu. Click **Notebooks** to proceed to the Notebook page. Alternatively, you can click **Notebooks** on the home page to go directly to the Notebooks page.

	![Left pane navigation to Notebooks through hamburger icon.](images/hamburger-notebooks.png)

2. The Notebook page opens with the list of notebooks available. Click the OML4Py Classification DT (1) notebook to open it.

	![List of Notebooks available.](images/list-notebooks-available.png)

3. The OML4Py Classification DT (1) notebook opens up in the notebook editor. Click the gear icon ![Gear Icon](images/gear-icon.png) on the top right corner of the notebook to view and set the interpreter binding order.

	![Illustration for getting the configuration for interpreter](images/getting-configuration-interpreter.png)

	You can change the order of the interpreter bindings by clicking and dragging an entry above or below others (turns from white to blue). You can also deselect a binding to disable it (turns from blue to white). This does not require dragging the enabled interpreters above the disabled ones.

	![Illustration for configuring interpreter](images/configuring-interpreter.png)

	Click **Save** to set the interpreter bindings.

4. Click the play icon next to the title of the notebook to run all paragraphs.

	![Illustration for running all paragraph](images/run-all-paragraphs.png)

5. Click **OK** to confirm in the confirmation dialogue.

	![Confirmation for running all paragraph](images/confirmation-run-all-paragraphs.png)

6. The paragraphs start running one by one and display the status next to the paragraph titles. When the paragraph is running, the status displays **PENDING** and when it finishes, it displays **FINISHED**.

	![Illustration for pending on a paragraph](images/pending-paragraph.png)

	![Illustration for finished on a paragraph](images/finished-paragraph.png)

In this step, the iris data set is used for illustrative purposes to load the data into a temporary database table. Such temporary tables are automatically deleted when the OML Notebook connection to the database ends unless you have saved its proxy object to a datastore, which we'll discuss in step 10, before disconnecting.
To use OML4Py, you must first import the `oml` module and the Pandas library. Use the `oml.push` function to create a temporary table.

1. Run the following scripts to import the `oml` package, the Pandas library, and set the display options:

	```
	<copy>
	%python

	import pandas as pd
	import oml

	pd.set_option('display.max_rows', 500)
	pd.set_option('display.max_columns', 500)
	pd.set_option('display.width', 1000)
	</copy>
	```

2. Load the iris data into a single DataFrame. Use the `oml.push` function to load this Pandas DataFrame into the database, which creates a temporary table and returns a proxy object that you can use for IRIS_TMP.

	```
	<copy>
	%python
	from sklearn.datasets import load_iris
	import pandas as pd

	iris = load_iris()

	x = pd.DataFrame(iris.data, columns = ['SEPAL_LENGTH','SEPAL_WIDTH', 'PETAL_LENGTH','PETAL_WIDTH'])
	y = pd.DataFrame(list(map(lambda x: {0: 'setosa', 1: 'versicolor', 2:'virginica'}[x], iris.target)), columns = ['SPECIES'])

	iris_df = pd.concat([x, y], axis=1)
	IRIS_TMP = oml.push(iris_df)

	z.show(IRIS_TMP.head())
	</copy>
	```

  You use the zeppelin-context z.show method to display Python objects and proxy object content. Here, you display the first few rows of IRIS_TMP using z.show.

	![Top rows of IRIS_TMP.](images/rows-iris-temp.png)

## Task 2: Create a Persistent Database Table

1. You can also create a persistent table using the create function and specifying a table name, IRIS as done below. The `oml.create` function creates a table in the database schema and returns an `oml.DataFrame` object. This table is now accessible both within OML4Py and directly from SQL. Use the z.show function to display the desired data in the notebook. To create the persistent table IRIS, run the following script.

	```
	<copy>
	%python
	try:
		oml.drop(table='IRIS')
	except:
		pass
	IRIS = oml.create(iris_df, table = 'IRIS')
	print(IRIS.columns)

	print("Shape:",IRIS.shape)
	z.show(IRIS.head(10))
	</copy>
	```

	The output is as follows:
	![Columns,Shape and Top rows of IRIS.](images/description-iris.png)

## Task 3: Create a Proxy Object for a Database Object

1. Use the `oml.sync` function to create a Python object as a proxy for a database table or view. The `oml.sync` function returns an `oml.DataFrame` object or a dictionary of `oml.DataFrame` objects. The `oml.DataFrame` object returned by `oml.sync` is a proxy for the database object.  

	```
	<copy>
	%python

	DEMO = oml.sync(table = "SUPPLEMENTARY_DEMOGRAPHICS", schema = "SH")
	z.show(DEMO.head())
	</copy>
	```
	In this step, you are viewing a few rows from the SUPPLEMENTARY_DEMOGRAPHICS table using the overloaded head function.
	![Top rows of DEMO.](images/rows-demo.png)

## Task 4: Explore the Data

In this example, use shape, describe and crosstab functions to explore and view the data.
1. Run the shape function to view the rows and columns of an `oml.DataFrame`.

	```
	<copy>
	%python

	DEMO.shape
	</copy>

	```
	```
	The output is (4500, 14).
	```

2. Use the transparency layer function `describe()` to calculate descriptive statistics that summarize the central tendency, dispersion, and shape of the DEMO table in each numeric column.Note that all computations are computed in the database and only the summary results are returned to the Python client, in this case, the notebook. Eliminating the need to move data greatly increases scalability.A few rows of the output are displayed using the `z.show` function.

		```
		<copy>
		%python
		summary_df = DEMO.describe()
		summary_df = summary_df.reset_index()
		summary_df = summary_df.rename(columns = {'index': 'statistics'})
		z.show(summary_df.head())
		</copy>
		```

	![Statistical details of DEMO.](images/statistical-data-demo.png)

3. Use the crosstab function to perform cross-column analysis of an `oml.DataFrame` object. The crosstab method computes a cross-tabulation of two or more columns. By default, it computes a frequency table for the columns unless a column and an aggregation function have been passed to it.  In this example, the crosstab function displays the distribution of `AFFINITY_CARD` responders.

	```
	<copy>
	%python

	z.show(DEMO.crosstab('AFFINITY_CARD'))
	</copy>
	```

	![Crosstab of attribute AFFINITY_CARD.](images/crosstab-affinity-card.png)

4. Run the following script to view the distribution of `HOUSEHOLD_SIZE` according to `AFFINITY_CARD` responders with the following setting. Click on the **Bar chart**, then click on **settings**. Drag the fields to titles as `HOUSEHOLD_SIZE` to **keys**, `AFFINITY_CARDS`  to **groups**, and count to **values**. Click on **Stacked** to get the required view.

	```
	<copy>
	%python

	z.show(DEMO.crosstab(['HOUSEHOLD_SIZE', 'AFFINITY_CARD']))
	</copy>
	```

	![Crosstab of attributes HOUSEHOLD_SIZE and AFFINITY_CARD.](images/crosstab-householdsize-affinitycard.png)

## Task 5: Prepare the Data

In this step, you will create a `DEMO_DF` DataFrame, select the necessary columns for further analysis, display a few rows of the `DEMO_DF` DataFrame, and split your data into TRAIN and TEST sets.
1. Use the DEMO proxy object to create a new proxy object `DEMO_DF` by selecting the necessary columns. Run the following script:

	```
	<copy>
	%python

	DEMO_DF = DEMO[["CUST_ID", 'AFFINITY_CARD', "BOOKKEEPING_APPLICATION", "BULK_PACK_DISKETTES", "EDUCATION",
	 "FLAT_PANEL_MONITOR", "HOME_THEATER_PACKAGE", "HOUSEHOLD_SIZE", "OCCUPATION", "OS_DOC_SET_KANJI",
	 "PRINTER_SUPPLIES", "YRS_RESIDENCE", "Y_BOX_GAMES"]]
	 </copy>

	```
2. To display the first few records of `DEMO_DF`, run the following script:

	```
	<copy>
	%python

	z.show(DEMO_DF.head())
	</copy>
	```

	![Top rows of DEMO_DF.](images/rows-demo-df.png)

3. In this example, you are splitting the `DEMO_DF` data with 60 percent of the records for the TRAIN data set and 40 percent for the TEST data set. The split method splits the data referenced by DataFrame proxy object `DEMO_DF` into two new DataFrame proxy objects, TRAIN, and TEST.

	```
	<copy>
	%python

	TRAIN, TEST = DEMO_DF.split(ratio = (0.6,0.4))
	TRAIN_X = TRAIN.drop('AFFINITY_CARD')
	TRAIN_Y = TRAIN['AFFINITY_CARD']
	TEST_X = TEST
	TEST_Y = TEST['AFFINITY_CARD']
	</copy>
	```

Since we’ll be using automatic data preparation provided by the in-database algorithms, no further data preparation is required.

## Task 6: Build Your Model

Use the `oml.dt` class to build a Decision Tree model. You can build a model with default settings or specify custom model settings.

1. To build a Decision Tree model with the default settings, run the following script:

	```
	<copy>
	%python

	try:
	    oml.drop(model = 'DT_CLAS_MODEL')
	except:
	    print("No such model")

	setting = dict()
	dt_mod = oml.dt(**setting)
	dt_mod.fit(TRAIN_X, TRAIN_Y, case_id = 'CUST_ID', model_name = 'DT_CLAS_MODEL')
	</copy>

	```

	The `oml.dt` class uses the Decision Tree algorithm for classification and a model object `dt_mod` is created with the default parameter settings.  The **fit** function builds the Decision Tree model according to the training data and parameter settings.

	```

	Model Name: DT_CLAS_MODEL

	Model Owner: OMLUSER

	Algorithm Name: Decision Tree

	Mining Function: CLASSIFICATION

	Target: AFFINITY_CARD

	Settings:
	                    setting name            setting value
	0                      ALGO_NAME       ALGO_DECISION_TREE
	1              CLAS_MAX_SUP_BINS                       32
	2          CLAS_WEIGHTS_BALANCED                      OFF
	3                   ODMS_DETAILS              ODMS_ENABLE
	4   ODMS_MISSING_VALUE_TREATMENT  ODMS_MISSING_VALUE_AUTO
	5                  ODMS_SAMPLING    ODMS_SAMPLING_DISABLE
	6                      PREP_AUTO                       ON
	7           TREE_IMPURITY_METRIC       TREE_IMPURITY_GINI
	8            TREE_TERM_MAX_DEPTH                        7
	9          TREE_TERM_MINPCT_NODE                      .05
	10        TREE_TERM_MINPCT_SPLIT                       .1
	11         TREE_TERM_MINREC_NODE                       10
	12        TREE_TERM_MINREC_SPLIT                       20

	Global Statistics:
	  attribute name  attribute value
	0       NUM_ROWS             2725

	Attributes:
	EDUCATION
	HOME_THEATER_PACKAGE
	HOUSEHOLD_SIZE
	OCCUPATION
	YRS_RESIDENCE
	Y_BOX_GAMES

	Partition: NO

	Distributions:

	    NODE_ID  TARGET_VALUE  TARGET_COUNT
	0         0             0          2088
	1         0             1           637
	2         1             0           676
	3         1             1           549
	4         2             0           108
	5         2             1           252
	6         3             0           568
	7         3             1           297
	8         4             0          1412
	9         4             1            88
	10        5             0            50
	11        5             1            23
	12        6             0          1362
	13        6             1            65
	14        7             0            89
	15        7             1           244
	16        8             0            19
	17        8             1             8
	18        9             0           188
	19        9             1            38
	20       10             0           380
	21       10             1           259
	22       11             0            20
	23       12             0            30
	24       12             1            23
	25       13             0           826
	26       13             1             6
	27       14             0           536
	28       14             1            59

	Nodes:

	    parent  node.id  row.count  prediction                                              split                                          surrogate                                        full.splits
	0      0.0        1       1225           0                   (HOUSEHOLD_SIZE IN ("3" "4-5"))                          YRS_RESIDENCE >(3.5E+000))                    (HOUSEHOLD_SIZE IN ("3" "4-5"))
	1      0.0        4       1500           0          (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+"))                         YRS_RESIDENCE <=(3.5E+000))           (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+"))
	2      1.0        2        360           1       (OCCUPATION IN ("Armed-F" "Exec." "Prof."))   (EDUCATION IN( ("Bach." "Masters" "PhD" "Profs...  (HOUSEHOLD_SIZE IN ("3" "4-5")) AND (OCCUPATIO...
	3      1.0        3        865           0  (OCCUPATION IN ("?" "Cleric." "Crafts" "Farmin...  (EDUCATION IN( ("10th" "11th" "12th" "1st-4th"...  (HOUSEHOLD_SIZE IN ("3" "4-5")) AND (OCCUPATIO...
	4      2.0        7        333           1                         (Y_BOX_GAMES <=(5.0E-001))                         YRS_RESIDENCE >(2.5E+000))  (HOUSEHOLD_SIZE IN ("3" "4-5")) AND (OCCUPATIO...
	5      2.0        8         27           0                          (Y_BOX_GAMES >(5.0E-001))                        YRS_RESIDENCE <=(2.5E+000))  (HOUSEHOLD_SIZE IN ("3" "4-5")) AND (OCCUPATIO...
	6      3.0        9        226           0                       (YRS_RESIDENCE <=(3.5E+000))                 HOME_THEATER_PACKAGE <=(5.0E-001))  (HOUSEHOLD_SIZE IN ("3" "4-5")) AND (OCCUPATIO...
	7      3.0       10        639           0                        (YRS_RESIDENCE >(3.5E+000))                  HOME_THEATER_PACKAGE >(5.0E-001))  (HOUSEHOLD_SIZE IN ("3" "4-5")) AND (OCCUPATIO...
	8      4.0        5         73           0         (EDUCATION IN ("Masters" "PhD" "Profsc"))                                                None  (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+")) AND (...
	9      4.0        6       1427           0  (EDUCATION IN ("10th" "11th" "12th" "1st-4th" ...                                               None  (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+")) AND (...
	10     5.0       11         20           0                (HOME_THEATER_PACKAGE <=(5.0E-001))                           Y_BOX_GAMES >(5.0E-001))  (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+")) AND (...
	11     5.0       12         53           0                 (HOME_THEATER_PACKAGE >(5.0E-001))                          Y_BOX_GAMES <=(5.0E-001))  (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+")) AND (...
	12     6.0       13        832           0                       (YRS_RESIDENCE <=(3.5E+000))                 HOME_THEATER_PACKAGE <=(5.0E-001))  (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+")) AND (...
	13     6.0       14        595           0                        (YRS_RESIDENCE >(3.5E+000))                  HOME_THEATER_PACKAGE >(5.0E-001))  (HOUSEHOLD_SIZE IN ("1" "2" "6-8" "9+")) AND (...
	14     NaN        0       2725           0                                               None                                               None    
	                                              (
		```

2. To specify model settings and build a Decision Tree model, run the following script :

	```
	<copy>
	%python

	try:
	    oml.drop(model = 'DT_CLAS_MODEL')
	except:
	    print("No such model")

	settings = {'TREE_IMPURITY_METRIC': 'TREE_IMPURITY_GINI',
	            'TREE_TERM_MAX_DEPTH': '7',
	            'TREE_TERM_MINPCT_NODE': '0.05',
	            'TREE_TERM_MINPCT_SPLIT': '0.1',
	            'TREE_TERM_MINREC_NODE': '10',
	            'TREE_TERM_MINREC_SPLIT': '20',
	            'CLAS_MAX_SUP_BINS': '32'}


	dt_mod = oml.dt(**settings)
	dt_mod.fit(TRAIN_X, TRAIN_Y, case_id = 'CUST_ID', model_name = 'DT_CLAS_MODEL')
	</copy>
	```

	The following is the list of model settings that are applied in the example:
* `TREE_IMPURITY_METRIC`: Specifies tree impurity metric for a Decision Tree model. Tree algorithms seek the best column/attribute and values for splitting data at each node. The best splitter and split value are those that result in the largest increase in target value homogeneity (purity) for the entities in the node. Purity in the decision trees algorithm can use either gini (`TREE_IMPURITY_GINI`) or entropy (`TREE_IMPURITY_ENTROPY`) as the purity metric. By default, the algorithm uses `TREE_IMPURITY_GINI`.
* `TREE_TERM_MAX_DEPTH`: Specifies the criteria for splits: maximum tree depth (the maximum number of nodes between the root and any leaf node, including the leaf node). The default is 7.
* `TREE_TERM_MINPCT_NODE`: Specifies the minimum number of training rows in a node expressed as a percentage of the rows in the training data. The default value is 0.05, indicating 0.05%.
* `TREE_TERM_MINPCT_SPLIT`: Specifies the minimum number of rows required to consider splitting a node expressed as a percentage of the training rows. The default value is 0.1, indicating 0.1%.
`TREE_TERM_MINREC_NODE`: Specifies the minimum number of rows in a node. The default value is 10.
* `TREE_TERM_MINREC_SPLIT`: Specifies the criteria for splits: minimum number of records in a parent node expressed as a value. No split is attempted if the number of records is below this value. The default value is 20.
* `CLAS_MAX_SUP_BINS`: Specifies the maximum number of bins for each attribute. The default value is 32.

## Task 7: Evaluate Your Model

To evaluate your model you need to score the test data using the model and then evaluate the model using various metrics.
1. In this step, you will make predictions on the test case and add the `CASE_ID` as a supplemental column so that you can uniquely associate scores with the original data. To do so run the below script:

	```
	<copy>
	%python

	# Set the case ID attribute
	case_id = 'CUST_ID'
	# Gather the Predictions
	RES_DF = dt_mod.predict(TEST_X, supplemental_cols = TEST_X)
	# Additionally collect the PROBABILITY_OF_0 and PROBABILITY_OF_1
	RES_PROB = dt_mod.predict_proba(TEST_X, supplemental_cols = TEST_X[case_id])
	# Join the entire result into RES_DF
	RES_DF = RES_DF.merge(RES_PROB, how = "inner", on = case_id, suffixes = ["", ""])
	</copy>
	```

2. To evaluate the model, pass a proxy `oml.Dataframe` containing predictions and the target columns in a user-defined function named evaluate_model. Evaluate your model using standard metrics. For a classification example, you can evaluate your model using Confusion Matrix, Lift Chart, Gains Chart, and ROC curve chart. The Confusion Matrix displays the number of correct and incorrect predictions made with respect to the actual classification in the test data. It is an **n**-by-**n** matrix where **n** is the number of classes. A lift chart applies only to binary classifications requiring the designation of the positive class. It measures the degree to which the predictions of a classification model are better than randomly generated predictions. The ROC curve also applies to binary classification and requires the designation of the positive class. These are metrics for comparing predicted and actual target values in a classification model.

	Here is a custom script to generate the metrics and charts as described above. Run the below script:

	```
	<copy>
	%python

	def evaluate_model(pred_data='',settings_name={''},name='',target=''):
	    import numpy as np
	    import matplotlib.pyplot as plt
	    from sklearn.metrics import auc
	    from sklearn.metrics import roc_curve

	    #Creating the confucion matrix using crosstab function.
	    conf_matrix = pred_data.crosstab(target,'PREDICTION',pivot=True)

	    # Extract Statistics from the Confusion Matrix
	    cf_local = conf_matrix.pull()
	    TN = int(cf_local[cf_local[target]==0]['count_(0)'])
	    FN = int(cf_local[cf_local[target]==0]['count_(1)'])
	    TP = int(cf_local[cf_local[target]==1]['count_(1)'])
	    FP = int(cf_local[cf_local[target]==1]['count_(0)'])
	    TPR = TP/(TP+FN)
	    FPR = FP/(FP+TN)
	    TNR = TN/(TN+FP)
	    FNR = FN/(FN+TP)
	    Precision = TP/(TP+FP)
	    Accuracy = (TP+TN)/(TP+TN+FP+FN)
	    NPV = TN/(FN+TN)
	    DetectionRate = TN/(FN+TN)
	    BalancedAccuracy = (TPR+TNR)/2

	    # Estimated AUC
	    pred_local = pred_data.pull()
	    fpr, tpr, _ = roc_curve(pred_local[[target]],pred_local[['PROBABILITY_OF_1']])
	    AUC = auc(fpr, tpr)
	    opt_index = np.argmax(tpr - fpr)
	    FPR_OPT = fpr[opt_index]
	    TPR_OPT = tpr[opt_index]
	    F1Score = 2*Precision*TPR/(Precision+TPR)
	    MathewsCorrCoef = ((TP*TN)-(FP*FN))/((TP+FP)*(TP+FN)*(TN+FP)*(TN+FN))**0.5

	    # Store all statistics to export
	    statistics = {'Algorithm' : name,
	                  'Algorithm_setting' : settings_name,
	                  'TN' : TN,
	                  'TP' : TP,
	                  'FP' : FP,
	                  'FN' : FN,
	                  'TPR' : TPR,
	                  'FPR' : FPR,
	                  'TNR' : TNR,
	                  'FNR' : FNR,
	                  'Precision' : Precision,
	                  'Accuracy' : Accuracy,
	                  'NPV' : NPV,
	                  'DetectionRate' : DetectionRate,
	                  'BalancedAccuracy' : BalancedAccuracy,
	                  'AUC' : AUC,
	                  'F1Score' : F1Score,
	                  'MathewsCorrCoef' : MathewsCorrCoef
	                  }
	    # Nice round stats for printing to screen
	    TOTAL = TP+TN+FP+FN
	    TN_P = round((TN/TOTAL*100),2)
	    FP_P = round((FP/TOTAL*100),2)
	    FN_P = round((FN/TOTAL*100),2)
	    TP_P = round((TP/TOTAL*100),2)
	    # Print the output nicely on Zeppelin native Table
	    print("%table CONFUSION MATRIX\tPREDICTED 0\tPREDICTED 1\nACTUAL 0\t"+
	          "True Negative: "+str(TN)+" ("+str(TN_P)+"%)\t"+
	          "False Positive: "+str(FP)+" ("+str(FP_P)+"%)\nACTUAL 1\t"+
	          "False Negative: "+str(FN)+" ("+str(FN_P)+"%)\t"+
	          "True Positive: "+str(TP)+" ("+str(TP_P)+"%)\n"+
	          "Accuracy: "+str(round(Accuracy*100,4))+"%\t"+
	          "AUC: "+str(round(AUC,4))+"\t"+
	          "F1Score: "+str(round(F1Score,4))
	          )

	    # Multiple Charts for Evaluation
	    fig, axes = plt.subplots(nrows=1, ncols=4,figsize=[22,5])
	    ax1, ax2, ax3, ax4 = axes.flatten()
	    fig.suptitle('Evaluation of the '+str(name)+' Model, with settings: '+str(settings_name), size=16)

	    # Statistics
	    ax1.axis('off')

	    # Function to return rounded numbers if the string is float, return
	    # integers otherwise and return characters if not a number
	    def round_if_float(content):
	        try:
	            val = float(content)
	        except ValueError:
	            return(content)
	        else:
	            if val.is_integer():
	                return(int(content))
	            else:
	                return(round(float(content),4))

	    for num, name in enumerate(statistics):
	        ax1.text(0.01,
	        (-num*0.06+0.94),
	        "{0}: {1}".format(name,round_if_float(statistics[name])),
	        ha='left',
	        va='bottom',
	        fontsize=12)

	    # Produce Lift Chart
	    ax2.set_title('Lift Chart')
	    data = pred_local.sort_values(by='PROBABILITY_OF_1', ascending=False)
	    data['row_id'] = range(0,0+len(data))
	    data['decile'] = ( data['row_id'] / (len(data)/10) ).astype(int)
	    lift = data.groupby('decile')[target].agg(['count','sum'])
	    lift.columns = ['count', target]
	    lift['decile'] = range(1,11)

	    data_ideal = pred_local.sort_values(by=target, ascending=False)
	    data_ideal['row_id'] = range(0,0+len(data))
	    data_ideal['decile'] = ( data_ideal['row_id'] / (len(data_ideal)/10) ).astype(int)
	    lift_ideal = data_ideal.groupby('decile')[target].agg(['count','sum'])
	    lift_ideal.columns = ['count', 'IDEAL']
	    lift['IDEAL']=lift_ideal['IDEAL']

	    ax2.bar(lift['decile'],lift['IDEAL']/lift['count'],
	    color='darkorange', label='Ideal')
	    ax2.bar(lift['decile'],lift[target]/lift['count'],
	    color='blue', alpha=0.6, label='Model')
	    ax2.axhline((lift[target]/lift['count']).mean(),
	    color='grey', linestyle='--', label='Avg TARGET')
	    ax2.set_ylim(0,1.15)
	    ax2.set_xlabel('Decile', size=13)
	    ax2.set_ylabel('Percent of Actual Targets', size=13)
	    # Print labels.
	    for dec in lift['decile']:
	        ax2.text(dec, lift[lift.decile==dec][target]/lift[lift.decile==dec]['count'] + 0.05,
	        ("%.0f" % int(round((lift[(lift.decile==dec)][target]/lift[lift.decile==dec]['count'])*100,0)))+"%",
	        ha='center', va='bottom')
	    ax2.legend(loc="upper right")

	    # Produce Gains Chart
	    ax3.set_title('Distributions of Predictions')
	    pred_local[pred_local[target]==1]['PROBABILITY_OF_1'].rename("Target = 1").plot(kind='density', bw_method=0.1, grid=True, ax=ax3)
	    pred_local[pred_local[target]==0]['PROBABILITY_OF_1'].rename("Target = 0").plot(kind='density', bw_method=0.1, grid=True, ax=ax3)
	    ax3.axvline(.5, color='grey', linestyle='--', label='Cutoff at 0.5')
	    ax3.set_xlim([0,1])
	    ax3.set_xlabel('Probability of 1', size=13)
	    ax3.set_ylabel('Density', size=13)
	    ax3.legend(loc="upper right")

	    # ROC curve Chart
	    ax4.set_title('ROC Curve')
	    ax4.plot(fpr, tpr, color='blue', lw=2, label='ROC curve')
	    ax4.plot(FPR_OPT, TPR_OPT, 'bo', color='orange', markersize=6)
	    ax4.plot([0, 1], [0, 1], lw=2, linestyle='--', color='grey', label='Random guess')
	    ax4.annotate('Optimal Cutoff:\nTPR: '+str(round(TPR_OPT,2))+' FPR: '+str(round(FPR_OPT,2)),
	                 fontsize=11, xy=(FPR_OPT, TPR_OPT), xycoords='data', xytext=(0.98, 0.54),
	                 textcoords='data',
	                 arrowprops=dict(facecolor='gray', shrink=0.1, width=2,
	                                 connectionstyle='arc3, rad=0.3'),
	                 horizontalalignment='right', verticalalignment='top')
	    ax4.annotate('AUC ='+str(round(AUC,4)), xy=(0.5, 0.35),
	                 xycoords='axes fraction', size=13)
	    ax4.annotate('Precision ='+str(round(Precision,4)), xy=(0.45, 0.3),
	                 xycoords='axes fraction', size=13)
	    ax4.annotate('Recall ='+str(round(TPR,4)), xy=(0.4, 0.25),
	                 xycoords='axes fraction', size=13)
	    ax4.annotate('Accuracy ='+str(round(Accuracy,4)), xy=(0.35, 0.2),
	                 xycoords='axes fraction', size=13)
	    ax4.annotate('F1 Score ='+str(round(F1Score,4)), xy=(0.3, 0.15),
	                 xycoords='axes fraction', size=13)
	    ax4.set_xlim([-0.02, 1.02])
	    ax4.set_ylim([0.0, 1.02])
	    ax4.set_xlabel('False Positive Rate', size=13)
	    ax4.set_ylabel('True Positive Rate', size=13)
	    ax4.legend(loc="lower right")

	    return(statistics, pred_local)
	_ = evaluate_model(pred_data=RES_DF, settings_name='Gini,Max Depth:7,Min%Node:0.05,Min%Split:0.1', name='Decision Tree', target='AFFINITY_CARD')
	</copy>
	```

	![Confusion Matrix.](images/confusion-matrix.png)

	![Evaluation of Decision Tree Model.](images/decision-tree-model.png)

3. You can also call the score function to get the model accuracy computed on the TEST data provided.

	```
	<copy>
	%python
	dt_mod.score(TEST_X, TEST_Y)
	</copy>

	```

	```
	The output is 0.824789
	```

	You obtain an accuracy of 0.824789 or approximately 82.5% of the result are correctly predicted.

## Task 8: Score Data for Deployment Using Your Model

Having built and evaluated the model, you will now filter scores computed above. Such results can be computed in batch and materialized as a table for static lookup by applications and dashboards or results can be computed dynamically using in-database models using OML4Py functions or SQL queries.

1. You can also display results of customers responding to affinity card with a probability greater than 0.5. You can also select the columns from the `RES_DF` dataset to display. To do so, run the following script.

	```
	<copy>
	%python  
	z.show(RES_DF[RES_DF['PROBABILITY_OF_1'] > 0.5][['PREDICTION', 'PROBABILITY_OF_1', 'CUST_ID', 'AFFINITY_CARD','EDUCATION','OCCUPATION', 'HOUSEHOLD_SIZE', 'YRS_RESIDENCE', 'OS_DOC_SET_KANJI','BULK_PACK_DISKETTES']])
	</copy>
	```

	The output is as follows:
	![Filtering result from RES_DF dataset on the basics of customers having an affinity greater than 50%.](images/prediction-result-res-df.png)

2. Now use the model to make predictions again on the test data by using the predict function, but also specify to retrieve prediction details using the `topN_attrs` parameter. To do so run the below script.

	```
	<copy>
	%python

	RES_DF = dt_mod.predict(TEST_X, supplemental_cols = TEST_X[['CUST_ID']], topN_attrs = True)
	z.show(RES_DF)
	</copy>
	```

	where `topN_attrs` returns the top **N** most influential attributes of the predicted value. For each attribute, three columns are provided: the attribute name, specific value, and corresponding weight of that attribute are provided. The output is similar to the following:

	![Prediction of model on the test data.](images/score-display-predict.png)

## Task 9: Use the SQL Interface to Score Data and Display Prediction Details

You can score data and make similar predictions using the SQL interface. The test data is materialized into DT\_TEST\_TABLE so that you can query it using SQL. The materialized method writes the contents of an Oracle Machine Learning proxy object (a view, a table, and so on) to an Oracle Database table.

1. Run the following command to materialize the test dataset:

	```
	<copy>
	%python

	try:
	    oml.drop(table = 'DT_TEST_TABLE')
	except:
	    pass
	_ = TEST_X.materialize(table = 'DT_TEST_TABLE')
	</copy>
	```

2. Run the following SQL command to score and display the prediction details. The prediction functions apply a decision tree classification model named `DT_CLAS_MODEL` to the data from the materialized table `DT_TEST_TABLE`. The query includes information about the predictors that have the greatest influence on the prediction.

	```
	<copy>
	%sql

	SELECT CUST_ID,
	    round(PREDICTION_YRS_RES,3) PRED_YRS_RES,
	    RTRIM(TRIM(SUBSTR(OUTPRED."Attribute1",17,100)),'rank="1"/>') FIRST_ATTRIBUTE,
	    RTRIM(TRIM(SUBSTR(OUTPRED."Attribute2",17,100)),'rank="2"/>') SECOND_ATTRIBUTE,
	    RTRIM(TRIM(SUBSTR(OUTPRED."Attribute3",17,100)),'rank="3"/>') THIRD_ATTRIBUTE
	FROM (SELECT CUST_ID,
	             PREDICTION(DT_CLAS_MODEL USING *) PREDICTION_YRS_RES,
	             PREDICTION_DETAILS(DT_CLAS_MODEL USING *) PD
	     FROM DT_TEST_TABLE
	     WHERE CUST_ID < 100015
	     ORDER BY CUST_ID) OUT,
	     XMLTABLE('/Details'
	              PASSING OUT.PD
	              COLUMNS
	              "Attribute1" XMLType PATH 'Attribute[1]',
	              "Attribute2" XMLType PATH 'Attribute[2]',
	              "Attribute3" XMLType PATH 'Attribute[3]')
	     OUTPRED
	</copy>
	```

	The output is similar to the following:

	![Illustration of prediction of model on materialized test data and its greatest attribute influence on the prediction.](images/score-predict-sql-interface.png)

## Task 10: Save and Load Python Objects in a Datastore Instance

You can save the python objects you create in one python session and load them in another session using the OML4Py datastore. Python objects and OML4Py proxy objects exist only during the current Python session, unless they are saved to a Datastore. OML4Py creates the datastore in the current user’s database schema. Until you delete the datastore and objects, they remain in the database. OML4Py provides functions for managing the objects in the datastore, such as `oml.ds.save`, `oml.ds.load`, `oml.ds.dir`, and so on.

1. First insert a new paragraph at the bottom of the Notebook. Click on the gear icon in the top-right corner of the last paragraph. Then, click on **Insert new** in the drop-down list. The default paragraph shows %md indicating that it is a markdown paragraph. To run a Python code, enter %python to change it to a Python paragraph.

	![Drop down-list of setting of a paragraph.](images/setting-paragraph.png)

2. To save one or more python objects to a datastore, use the `oml.ds.save` function. Here the DataFrame object is stored to `ds_pydata` and python model object is stored to `ds_pymodel`.
	- To save IRIS and res_df `oml.DataFrame` proxy object to the `ds_pydata` datastore, run the script below. Use the oml.sync function to create a python object as a proxy for IRIS table (see Task 3). You can give some descriptive text using the description argument, which will appear when you get information on the datastore.

	```
	<copy>
	%python
	IRIS = oml.sync(table='IRIS')
	oml.ds.save(objs={'iris':IRIS, 'res_df':RES_DF},name="ds_pydata", description = "python datasets", overwrite=True)
	</copy>
	```

	- Run the below script to save the `dt_mod` model proxy object to the `ds_pymodel` datastore. When the **overwrite**  boolean argument is set to TRUE (overwrite=TRUE), an existing datastore is replaced with a new datastore with the same name.

	```
	<copy>
	%python
	oml.ds.save(objs={'dt_mod':dt_mod},name="ds_pymodel",description = "python model", grantable=True, overwrite=True)
	</copy>
	```

	- The `oml.ds.dir` function returns a list of existing datastores that are available to you. Run the script below to get the list.

	```
	<copy>
	%python
	oml.ds.dir()
	</copy>
	```

	The output is similar to the following:
	![List of all datastore available and their object_count, size, date and description.](images/datastore-list.png)
	The output also includes the size in bytes consumed, the date, and the descriptive text provided by the user when loading the python objects into the datastore.

3. In this step, you will use `oml.ds.load` function for loading one or more python objects from the datastore to the global workspace or the user's workspace.
	- Run the following script to load all the python objects of a datastore into global Workspace and sort them by their name.

		```
		<copy>
		%python
		sorted(oml.ds.load(name="ds_pydata"))
		</copy>
		```

		![Sorted list of python proxy objects in a datastore.](images/sorted-objects-datastore.png)

	- Run the following script to load the named python object from the datastore into the global workspace.

		```
		<copy>
		%python
		oml.ds.load(name="ds_pymodel", objs=["dt_mod"])
		</copy>
		```

		The output is similar to the following:

		![list of python model proxy objects in a datastore.](images/model-object-datastore.png)

	-	Run the following script to use the `dt_mod` model from the datastore to make predictions on the test data using the predict function.

		```
		<copy>
		%python
		RES_DS= dt_mod.predict(TEST_X, supplemental_cols = TEST_X)
		z.show(RES_DS)
		</copy>
		```

		The output is similar to the following:

		![Rows of res_ds after prediction by loaded model.](images/rows-res-ds.png)

	- Run the following script to load the named python object from the datastore into the user's workspace.

		```
		<copy>
		%python
		oml.ds.load(name="ds_pymodel", objs=["dt_mod"], to_globals=False)
		</copy>
		```

		The output is similar to the following:
		![Illustration of a dictionary object containing the models name and value.](images/loaded-dictionaryobject-datastore.png)
		Also, the boolean input **to\_globals** is set to True by default. If to\_global=True then the `oml.ds.load` loads the python object to the global workspace. If to\_global=False, then the `oml.ds.load` function returns a dictionary object containing the object's name and value.
		To learn more about how to use datastores to store python objects click this [link](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/save-python-objects-in-database.html#GUID-C02396D1-2B30-47A0-AE27-37B123E15710).

In this example, you classified customers who are most likely to be positive responders to an Affinity Card loyal program. You built and applied a classification decision tree model using the Sales history (SH) schema data. You were also able to successfully identify the top **N** attributes that are important to the model built.

## Learn More

OML4Py enables data scientists to hand-off their user-defined Python functions to application developers for invocation from REST or SQL interfaces, where the database environment spawns and controls the Python engines, loads the user-defined function, and if required, loads the specified data as a Pandas DataFrame. This facilitates making native python machine learning models and predictions readily available for enterprise solutions as well, with the option to leverage data parallelism for greater performance and scalability. Given below are some of the functionalities that OML4Py offers:

1. [Embedded Python Execution](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/about-embedded-python-execution.html#GUID-A15F3A62-736A-4276-83F2-7C54BE026639)
	OML4Py Embedded Python Execution provides users the ability to call user-defined Python functions in one or more Python engines spawned and managed by the Oracle database environment.

2. [Automated Machine Learning (Auto ML)](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/about-automl.html#GUID-9F514C2B-1772-4073-807F-3E829D5D558C)

	AutoML provides built-in data science expertise about data analytics and modeling that you can employ to build machine learning models. Given below is an example on how you can automate the above scenario with the help of Auto ML by following the three steps:
	1. Prepare the Demo data and then rank the classification algorithms from the set of algorithms supported by AutoML using automatic algorithm selection.
	![The images shows how to prepare the demo data and rank the classification with the help of AutoML.](images/automl-algorithm-selections.png)
	2. Identify the most relevant feature subset using automatic feature selection.
	![It shows how AutoMl can be used for selection of relevant features.](images/automl-subset-feature-selection.png)
	3. Finally tune the hyperparameters for the selected classification algorithm and features using automatic model tuning.
	![The image shows how to fine tune hyperparameters with help of AutoML](images/automl-hyperparameter-tuning.png)

3. [Machine Learning Explainability (MLX)](https://docs.oracle.com/en/database/oracle/machine-learning/oml4py/1/mlpug/explain-model.html#GUID-1936962D-38AD-4E7E-9B96-EEE3EE2BD15C) is used to help explain and interpret the machine learning model by identifying the features that most impact model predictions.

## Acknowledgements

* **Authors** - Sarika Surampudi, Senior User Assistance Developer, Oracle Database User Assistance Development; Dhanish Kumar, Member of Technical Staff, User Assistance Developer.
* **Contributors** -  Mark Hornick, Senior Director, Data Science and Machine Learning; Sherry LaMonica, Consulting Member of Tech Staff, Machine Learning; Marcos Arancibia, Senior Principal Product Manager, Machine Learning.
* **Last Updated By/Date** - Dhanish Kumar, June 2022

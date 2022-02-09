#Week 3

## OLAP vs OLTP

 * OLAP (Online Analytical Processing) is a system for performing multi-dimensional analysis at high speeds on large volumes of data. 
    Typically this data is from data warehouse, data mart or some other centralized data store. OLAP is ideal for BI, data mining, 
    and complex analytical calculations as well business reporting functions like financial analysis, sales forecasting and budgeting.
    Core of most OLAP systems is OLAP Cubes which allows you to query, report on, and analyze multi-dimensional data. OLAP Cube extends 
    the row-by-columns format of traditional relational database and adds layers for additional data dimensions. 
    
 * OLTP (Online Transactional Processing) enables large number of database transactions to large number of users. OLTP systems are responsible 
    for many of everyday transactions like ATMs, Online Purchases and reservations. OLTP systems use relational databases that can 
    ** support large number of relatively simple transactions (usually insertions, deletions and updates to data).   
    ** enable multi-user access to data while ensuring data-integrity
    
|               | OLTP          | OLAP  |
|:-------------:|:-------------:| :-----:|
| Purpose     | Control and run essential business operations in real time | Plan, solve problems, support decisions, discover hidden insights |
| Data updates | Short, fast updates initiated by user     |   Data periodically refreshed with scheduled, long-running batch jobs |
| Database design | Normalized databases for efficiency      | Denormalized databases for analysis |
|Space requirements|Generally small if historical data is archived|Generally large due to aggregating large datasets|
|Data view|Lists day-to-day business transactions|Multi-dimensional view of enterprise data|
|User examples|Customer-facing personnel, clerks, online shoppers|Knowledge workers such as data analysts, business analysts, and executives


## Data Warehouse
 * Data warehouse often known as Enterprise Data Warehouse (EDW) is a reporting and data analysis system.
 * It unifies data from various data sources and stores current and historical data for Business analysts, data engineers, data scientists, and decision makers to access.
 * Is a OLAP solution.
 * used for reporting and data analysis.
 * Consists of raw data, meta data and summary data.
 * Google BigQuery, Amazon Redshift, and Microsoft Azure Synapse Analytics are three data warehouse services.
 * Data Marts are subsets of Data warehouses. Data in Data Marts is summarised or cleaned version of raw data available in data warehouse.

## Google Big Query
 * BigQuery is a fully managed enterprise data warehouse.
 * Serverless architechture means:
  * No hardware/servers to manage or database software to install.
 * Provides software as well as infrastructure with scalability and high availability.
 * BigQuery maximizes flexibility by separating the compute engine that analyzes your data from your storage.
 * Federated queries let you read data from external sources while streaming supports continuous data updates.
 * BigQuery interfaces include Google Cloud Console interface and the BigQuery command-line tool.
 * Developers and data scientists can use client libraries with familiar programming including Python, Java, JavaScript, and Go, as well as BigQuery's REST API and RPC API to transform and manage data.
 * ODBC and JDBC drivers provide interaction with existing applications including third-party tools and utilities. [[Big Query Reference Docs]](https://cloud.google.com/bigquery/docs/introduction)

### Partitioning 
 A partitioned table is a special table that is divided into segments, called partitions, that make it easier to manage and query your data. You can typically 
 split large tables into many smaller partitions using data ingestion time or `TIMESTAMP/DATE` column or an `INTEGER` column. BigQuery’s decoupled storage and 
 compute architecture leverages column-based partitioning simply to minimize the amount of data that slot workers read from disk. Once slot workers read their 
 data from disk, BigQuery can automatically determine more optimal data sharding and quickly repartition data using BigQuery’s in-memory shuffle service.
 
 BQ gives you following types of fields/columns as options to partition a table:
* Time-unit column
* Ingestion time (_PARTITIONTIME)
* Integer range partitioning
* When using Time unit or ingestion time
  * Daily (Default)
  * Hourly
  * Monthly or yearly
* Number of partitions limit is 4000

 
 <Partition Image>
  
  BigQuery Sample SQL for partitioning
  
  ``` SQL
  CREATE OR REPLACE TABLE `stackoverflow.questions_2018_partitioned`
PARTITION BY
 DATE(creation_date) AS
SELECT
 *
FROM
 `bigquery-public-data.stackoverflow.posts_questions`
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-07-01';
  ```

 ### Clustering
  When a table is clustered in BigQuery, the table data is automatically organized based on the contents of one or more columns in the table’s schema. 
  The columns you specify are used to colocate related data. Usually high cardinality and non-temporal columns are preferred for clustering.
  When data is written to a clustered table, BigQuery sorts the data using the values in the clustering columns. These values are used to organize the 
  data into multiple blocks in BigQuery storage. The order of clustered columns determines the sort order of the data. When new data is added to a table 
  or a specific partition, BigQuery performs automatic re-clustering in the background to restore the sort property of the table or partition. Auto 
  re-clustering is completely free and autonomous for the users.
  
   * Clustered tables in BigQuery are subject to the following limitations:

   * Only standard SQL is supported for querying clustered tables and for writing query results to clustered tables.
  Clustering columns must be top-level, non-repeated columns of one of the following types:

     `DATE`

     `BOOL`

     `GEOGRAPHY`

     `INT64`

     `NUMERIC`

     `BIGNUMERIC`

     `STRING`

     `TIMESTAMP`

     `DATETIME`
  

   * You can specify up to four clustering columns.

   * When using STRING type columns for clustering, BigQuery uses only the first 1,024 characters to cluster the data. The values in the columns can themselves be longer than 1,024.
  
  Sample SQL Query for Clustering:
  ```SQL
  CREATE OR REPLACE TABLE `stackoverflow.questions_2018_clustered`
PARTITION BY
 DATE(creation_date)
CLUSTER BY
 tags AS
SELECT
 *
FROM
 `bigquery-public-data.stackoverflow.posts_questions`
WHERE
 creation_date BETWEEN '2018-01-01' AND '2018-07-01';
  ```
  
  

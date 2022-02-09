--Creating external table referring to gcs path;
CREATE OR REPLACE EXTERNAL TABLE `tribal-archery-339118.trips_data_all.external_fhv2019_tripdata`
OPTIONS (
  format = 'parquet',
  uris = ['gs://dtc_data_lake_tribal-archery-339118/raw/fhv_tripdata_2019-*.parquet']
);

--Take a look at fhv data;
SELECT * FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata limit 10;

--Question 1: What is count for fhv vehicles data for year 2019 
SELECT COUNT(1) FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata limit 10;

--Question 2: How many distinct dispatching_base_num we have in fhv for 2019
SELECT COUNT(DISTINCT Dispatching_base_num) AS Distinct_Cnt FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata;

--Question 3: Best strategy to optimise if query always filter by dropoff_datetime and order by dispatching_base_num;
--Part 1: Running a query without optimizing it;

SELECT COUNT(1) 
FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata
WHERE dropoff_datetime between '2019-01-01' and '2019-03-31'
and dispatching_base_num in ('B00987','B02060','B02279')

--Part 2: Running a query after optimizing it;
CREATE OR REPLACE TABLE tribal-archery-339118.trips_data_all.external_fhv2019_tripdata_partitoned_clustered
PARTITION BY DATE(dropoff_datetime)
CLUSTER BY dispatching_base_num AS
SELECT * FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata;

--Question 4: What is the count, estimated and actual data processed for query which counts trip between 2019/01/01 and 2019/03/31 for dispatching_base_num B00987, B02060, B02279 ;
SELECT COUNT(1) 
FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata_partitoned_clustered
WHERE dropoff_datetime between '2019-01-01' and '2019-03-31'
and dispatching_base_num in ('B00987','B02060','B02279')
;

--Question 5: What will be the best partitioning or clustering strategy when filtering on dispatching_base_num and SR_Flag 
SELECT DISTINCT SR_Flag,count(1) as cnt FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata group by 1;

CREATE OR REPLACE TABLE tribal-archery-339118.trips_data_all.external_fhv2019_tripdata_partitioned_clustered_2
--PARTITION BY dispatching_base_num     ----Cannot use SR_Flag or dispatching_base_num to partition since they are not date type columns
CLUSTER BY SR_Flag,dispatching_base_num  AS 
SELECT * FROM tribal-archery-339118.trips_data_all.external_fhv2019_tripdata_partitoned_clustered;


-- Returns metadata for tables in a single dataset;
SELECT
 * EXCEPT(is_generated, generation_expression, is_stored, is_updatable)
FROM
 `tribal-archery-339118`.trips_data_all.INFORMATION_SCHEMA.COLUMNS
WHERE
 table_name="external_fhv2019_tripdata";
SELECT * FROM tribal-archery-339118.trips_data_all.INFORMATION_SCHEMA.external_fhv2019_tripdata;

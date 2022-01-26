# DataLake

## What is DataLake

  1. Its a central respository that hold big data from various sources.
  2. Data can be structured, semi structured or unstructured
  3. DataLake ingests data as fast possible and makes it available to Data Scientists, Data Analysts  and Data Enigneers
  4. Meta data in datalake can be used for faster access to data
  5. Datalake allows to store data securely, scale unlimitedly

## DataLake vs Datawarehouse

DataLake | Datawarehouse
--- | ---
raw unstructured data | structured data (in form of tables)
vast of amounts of data in order of petabytes stored indefinitely | contains less data in order of terabytes
Data needs minimal processing, can be transformed when neeeded | Data must be processed before ingestion and needs to be purged periodically
Variety of applications such as ML, Streaming Analytics, AI | EDW contains historic and relational data that can be used for BI and reporting


## ETL vs ELT

ETL | ELT
--- | ---
Extract Transform and Load | Extract Load and Transform
ETL is a datawarehouse solution | ELT is a datalake solution
Schema and relationships need to be well defined before writing the data | Data is written first and schema is defined after

## Pitfalls of DataLake

  - Datalake can turn into Dataswamp if right precautions are not taken
  - If same data is written in two incompatible schemas it can become hard to consume
  - Data can become useless if no metadata is associated with the data, as it is difficult decipher the contents of data
  - Data can also be useless if it cannot be joined with other data due to unavailable forieng keys


# Workflow Orchestration

Data pipeline is a workflow of one or more scripts that intake data from one or more sources and produces one or more data outputs.

<insert data pipline screenshot>
  
Week 1 example of data pipeline 
  
  This pipeline is ironically is good example of how to not write a datapipeline. It is because we did not include any failsafes 
  in case one of the steps in the work flow failed to run. Thus failure at any step will cause whole workflow to fail. 





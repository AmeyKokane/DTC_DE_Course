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
  
  This pipeline is ironically is good example of how to not write a data pipeline. It is because this data pipeline has multiple steps inside single job. Hence, if one of the steps fail for any reason,since we did not include any 'failsafes', whole job will fail.
  A good way to avoid this issue is to split up each step of the job and add dependencies for each step. Workflow Orchestration tools like Luigi, Apache Airflow allow data engineers to create such workflows which are also known as DAG (Directed Acyclic Graph).
  
## Airflow Architecture
  Consists of a Webserver which is a GUI to inspect, trigger and debug DAGs. Avialable on localhost 8080
  Scheduler: Handles both scheduling and triggering workflows. Submits tasks to the executor, monitors tasks. triggers task consensus after their dependencies are complete.
  Worker: Executes a task given by scheduler
  Metadata Database: Backend to Airflow environment. Use by scheduler, worker and Webserver to store the state of the DAG.
  
## Anatomy of a DAG
  THere are four components to a workflow
  1. DAG - specifies dependencies between a set of tasks and a specific execution order. Has a beginning and an end
  2. Task - Defined unit of work also known as Operators. Tasks is a description of what needs to be done for ex. fetching data, running analysis, triggering other systems
  3.DAG Run - individual execution or re-run of a task
  4.Task Instance - individual run of a single task. Also have an indicative state which can be failed, running, success, skipped etc
  
  DAG Structure: Defnined in an python file and composed of DAG definition, Operators and then Dependencies.
  
  Declaring a DAG - We have used an implicite way using a Context Manager. But there are other ways to declare a DAG which are using a standard constructor in which you pass a DAG to a task such as Operators or you could add a DAG decorator to turn a fnuction into a DAG generator.
  
  Tasks - a DAG runs through a series of tasks. 3 common type of tasks.
  1. Operators - predefined task that can be string together quickly
  2. Sensons - special subclass of operators which wait for a certain event to happen
  3.Taskflow Decorated Task: Custom python function packaged up as a Task.
  
  Tasks are defined based on the abstraction of the operators which represent a somg;e idempotent task. Best practice is to have atomic operator which is operators that stand on their own and do need to share resources among them. 
  Every single operator must be defined to a DAG either within 'with Operator' or passing DAG id. DAGs are parameterized always including an Interval. 




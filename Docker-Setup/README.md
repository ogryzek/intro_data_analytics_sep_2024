# Docker, Adventureworks and macOS. 
  
This is mostly just the result of some searching, troubleshooting and setup for Docker, AdventureWorks, and Azure Data Studio on macOS.  
  
## References:  
  - [mssql tips](https://www.mssqltips.com/sqlservertip/7099/testing-sql-server-edge-and-docker-on-the-latest-macbooks/)
  - [Medium Blog Post - Chaitali Chavan](https://medium.com/analytics-vidhya/how-to-run-adventureworks-using-azure-data-studio-on-mac-1863207bb8db)
  - [AdventureWorks Sample Database](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)
  - [Install Docker Desktop](https://docs.docker.com/desktop/install/mac-install/)  

## Download AdventureWorks data
Get the [AdventureWorks Sample Database](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms), and save it somewhere. In this case, we save `AdventureWorks2022.bak` to the Desktop for use in a later step.  
  
## Using the terminal:  
Use `docker pull` to download the Azure SQL Edge container image   
```
docker pull mcr.microsoft.com/azure-sql-edge:latest
```

Run a container using the Azure SQL Edge container image with some parameters:
```
docker run -d --name SQLEdge -p 6666:1433 -e "ACCEPT_EULA=Y" -e "MSSQL_SA_PASSWORD=w0nD3rFuuull" -e "MSSQL_PID=Developer" mcr.microsoft.com/azure-sql-edge
```


Create directory and copy the .bak file:
```
docker exec -it SQLEdge mkdir "/var/opt/mssql/backup"
docker cp ~/Desktop/AdventureWorks2022.bak SQLEdge:/var/opt/mssql/backup/
```


## Using Azure Data Studio

Then restore
```
RESTORE DATABASE AdventureWorks2022 FROM DISK = '/var/opt/mssql/backup/AdventureWorks2022.bak' WITH REPLACE, RECOVERY, MOVE 'AdventureWorks2022' TO '/var/opt/mssql/data/aw2022.mdf', MOVE 'AdventureWorks2022_log'  TO '/var/opt/mssql/data/aw2022.ldf';

```
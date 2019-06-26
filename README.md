# amusement-park-database


# Amusement Park Database Application

This application uses the Amusement Park Database in order to query and update the database. It allows the user to view different tables within the Amusement park database. This application also allows the user to enter their own data values into the database. Some actions that the user can perform are add visitors, add tickets, add food, add souvenirs, and add rides. 

## Installation

In order to embed the SQL Server database within the Java application, the JDBC Driver for SQL Server 6.0 was used. In order to run this program properly, the user must be able to connect to the Amusement Park database. Because this application was created with the database on the localhost, please ensure that the connection URL is correct for your computer. The connection URL used in the application is as follows: 
"jdbc:sqlserver://localhost:1433; databaseName=Loria_Michael_db;integratedSecurity=true". If you need to modify the connection URL for the application, please go to line 75 of the Driver.java file. There, you will be able to change the connection URL and connect it to where the Amusement Park Database is located on your own local computer.  

The connection URL is essential in order to get this program running properly. Note that if the connection to the database was not successful, an error message will be displayed. However, the application will still run, but the user will not be able to view any tables or add any data to the database. Therefore, it is very important that the connection is made to the Amusement Park database in order to view the tables and add data to the tables.

To run the application, you will need to run the Driver.java file (located in the gui folder). An executable JAR file has also been added to the project for your convenience. You can use the JAR file as well to run the Amusement Park Database application. 

To view all of the classes within this application, please go to the src folder and then navigate to the gui folder. Testing was also done on the application, which are located in the tests folder. Please ensure that all files are unzipped before running the application.

## Author
Michael Zachary Loria, Database Final Project Submission

## Version
1.0

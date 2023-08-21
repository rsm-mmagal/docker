/* Question 1 */
/*Use the Customers table and create a query that shows all columns. */

SELECT *
FROM customers;

/* Question 2 */
/*Use the Customers table and create a query that shows the CompanyNames and
Addresses. */
SELECT CompanyName, Address FROM customers;

/* Question 3 */
/* Use the Customers table and create a query that shows the CompanyNames and
Addresses for all customers located in the 'UK'. */
SELECT CompanyName, Address FROM customers WHERE Country = 'UK';

/* Question 4 */
/*Use the Customers table and create a query that shows the CompanyNames and
Addresses for all customers located in the 'UK' or the 'USA'. */
SELECT CompanyName, Address FROM customers WHERE Country = 'UK' or Country = 'USA'; 

/* Question 5 */
/* Use the Customers table and create a query that shows CompanyNames, Addresses,
Countries, and CustomerIDs. Use wildcards (% for any character and any number of
characters and _ for a single character) and select all customers with CompanyNames with
the letters 'po' anywhere in their name that are located in the 'USA' or the 'UK'. */
SELECT CompanyName, Address, Country
FROM Customers 
WHERE (Country = 'UK' OR Country = 'USA') AND CompanyName Like '%po%' ;

/* Question 5.5 */
/* As an additional exercise also create a query that finds all CompanyNames that starts with
'L' and second query that finds all CompanyNames that ends with 'e'. */
SELECT CompanyName
FROM Customers
WHERE CompanyName Like 'L%';

SELECT CompanyName
FROM Customers
WHERE CompanyName Like '%e';

/* Question 6 */
/* Using Order Details table create a query that includes a calculated field named
LineItemTotal that is calculated as UnitPrice*Quantity*(1-Discount). Round LineItemTotal
to two decimals. */
SELECT OrderID, ProductName, Discount, round(UnitPrice *Quantity*(1-Discount),2) As LineItemTotal
FROM OrderDetails;

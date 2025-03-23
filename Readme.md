# Summary of _Learning SQL_

**I have studies this book a year a go for a project, since that - unfortunately - I have never touched SQL since that, therefore im rereading the book and summarizing it because I need understanding of SQL for the upcomming stage**

TBH this is best ever SQL crash course/refresher on the internet

> If you like this summary; you can visit me on [Linkedin](https://www.linkedin.com/in/kareem-anees-0496b62b3/)

# Chapter 1:- _Intro_

this is about general concepts and some history

# Chapter 2: _Creating a database_

this chapter do 2 things

- it introduces SQL syntax
- it explaines Data sizes

## MySQL data types

these data types are MySQL specific but they are ver common, at the end of this chapter I will leave a comparison table between MySQL, Postgres and oracle

### Character Data

to specifiy a character colomn

```SQL
char(24)
-- or
varchar(24)
```

**What is Difference Between `char` and `varchar` ?**

- **_char_** has fixed length (in bytes) and if the text is smaller than the peek value (which in our case is 24) then the rest will be empty space to the right

- **_Varchar_** on the other hand is flexible with memory consumtion (ofcourse with tradeoffs but this is another topic)

characters format is set by default to UTF8mb4 but you can specify the charset you need within a colomn or the entirve database using commands

```SQL
> col1 varchar(64) character set ascii
```

to see character sets available just type

```SQL
> SHOW CHARACTER SET;
```

> the max size for `char` is 255 bytes.

> the max size for `varchar` is 65,535 bytes (64kb)

### text data

when the size of the row exceeds 64 kb, there are other types of sstring data that are

| Type         | Maximum Number of Bytes |
| ------------ | ----------------------- |
| `TINYTEXT`   | 255                     |
| `TEXT`       | 65,535                  |
| `MEDIUMTEXT` | 16,777,215              |
| `LONGTEXT`   | 4,294,967,295           |

**Important notes when dealing wiht text**

- when the inputs are larger than the max size, the rest of the inputs will be trauncated

- trailing spaces are not removed

- when sourting or grouping; only the first 1024 bytes are considered

### Numeric

they are boolen plus this table:

| Type        | Signed Range                    | Unsigned Range     |
| ----------- | ------------------------------- | ------------------ |
| `TINYINT`   | -128 to 127                     | 0 to 255           |
| `SMALLINT`  | -32,768 to 32,767               | 0 to 65,535        |
| `MEDIUMINT` | -8,388,608 to 8,388,607         | 0 to 16,777,215    |
| `INT`       | -2,147,483,648 to 2,147,483,647 | 0 to 4,294,967,295 |
| `BIGINT`    | -2⁶³ to (2⁶³ - 1)               | 0 to (2⁶⁴ - 1)     |

---

#### The difference beween signed and unsigned

the signed can be positive or negative while the unsigned are only positive

> the default is UNSIGNED

to make a colomn unsigned we use the following-like syntax

```SQL
CREATE TABLE users (
    age TINYINT UNSIGNED
);

```

---

**float are**

| Type           | Numeric Range (Signed)                                                                                      |
| -------------- | ----------------------------------------------------------------------------------------------------------- |
| `FLOAT(p, s)`  | -3.402823466E+38 to -1.175494351E-38 and 1.175494351E-38 to 3.402823466E+38                                 |
| `DOUBLE(p, s)` | -1.7976931348623157E+308 to -2.2250738585072014E-308 and 2.2250738585072014E-308 to 1.7976931348623157E+308 |

to specify it

```SQL
CREATE TABLE example_float (
    value FLOAT(7, 3)  -- Total 7 digits, 3 after decimal
);

--- Range of values: -9999.999 to 9999.999
```

### Date and time

it is as simple as looking at these tables

| Type        | Default Format      | Allowable Values                                         |
| ----------- | ------------------- | -------------------------------------------------------- |
| `DATE`      | YYYY-MM-DD          | 1000-01-01 to 9999-12-31                                 |
| `DATETIME`  | YYYY-MM-DD HH:MI:SS | 1000-01-01 00:00:00.000000 to 9999-12-31 23:59:59.999999 |
| `TIMESTAMP` | YYYY-MM-DD HH:MI:SS | 1970-01-01 00:00:00.000000 to 2038-01-18 22:14:07.999999 |
| `YEAR`      | YYYY                | 1901 to 2155                                             |
| `TIME`      | HHH:MI:SS           | -838:59:59.000000 to 838:59:59.000000                    |

---

yet another datatype in mysql is enums

```SQL
currency ENUM('EGP', 'USD', 'SAR')
```

---

END OF CHAPTER 2

# Chapter 3: _Query Primer_

this chapter talks about basic query clauses such as `SELECT` and `FROM`, etc...

but before diving into this; to view or export data as JSON for example

```SQL
SELECT json_object('id', id, 'name', name, 'balance', balance) FROM my_table;
```

outputs like

```json
{"id":1, "name":"Alice", "balance":1000.50}
{"id":2, "name":"Bob", "balance":200.75}
```

## Clauses

Each of the following clauses will be discusses in detail in it's chapter but for now they are

### **Query Mechanics**

- SQL queries are used to retrieve, filter, and manipulate data from a database.
- The basic structure follows:
  ```sql
  SELECT columns FROM table WHERE condition;
  ```

---

### **Query Clauses**

- SQL queries consist of different clauses like `SELECT`, `FROM`, `WHERE`, `ORDER BY`, etc.
- These clauses define what data to retrieve and how to process it.

---

### **The SELECT Clause**

- Used to specify which columns to fetch from a table.
  ```sql
  SELECT name, age FROM users;
  ```
- You can also use `*` to fetch all columns:
  ```sql
  SELECT * FROM users;
  ```

---

### **Column Aliases**

- Renames a column in the output using `AS`.
  ```sql
  SELECT name AS full_name, age AS user_age FROM users;
  ```
- Useful for improving readability in reports.

---

### **Removing Duplicates**

- Use `DISTINCT` to eliminate duplicate values in the result set.
  ```sql
  SELECT DISTINCT country FROM users;
  ```

---

### **The FROM Clause**

- Specifies the table to fetch data from.
  ```sql
  SELECT * FROM users;
  ```
- Can include joins with multiple tables.

---

### **Tables**

- A table consists of rows and columns, similar to an Excel sheet.
- Each column has a defined data type (e.g., `INT`, `VARCHAR`, `DATE`).

---

### **Table Links**

- Tables can be linked using `JOIN` operations.
  ```sql
  SELECT users.name, orders.amount
  FROM users
  JOIN orders ON users.id = orders.user_id;
  ```
- Common types: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, `FULL JOIN`.

---

### **Defining Table Aliases**

- Shortens table names in queries using `AS`.
  ```sql
  SELECT u.name, o.amount
  FROM users AS u
  JOIN orders AS o ON u.id = o.user_id;
  ```
- Helps simplify complex queries.

---

### **The WHERE Clause**

- Filters rows based on conditions.
  ```sql
  SELECT * FROM users WHERE age > 18;
  ```
- Supports conditions with `AND`, `OR`, `LIKE`, etc.

---

### **The GROUP BY and HAVING Clauses**

- `GROUP BY`: Groups rows with the same values.
  ```sql
  SELECT country, COUNT(*) FROM users GROUP BY country;
  ```
- `HAVING`: Filters grouped results.
  ```sql
  SELECT country, COUNT(*) FROM users GROUP BY country HAVING COUNT(*) > 10;
  ```

---

### **The ORDER BY Clause**

- Sorts the result set.
  ```sql
  SELECT * FROM users ORDER BY age;
  ```

---

### **Ascending vs. Descending Sort Order**

- `ASC` (default) sorts from smallest to largest.
- `DESC` sorts from largest to smallest.
  ```sql
  SELECT * FROM users ORDER BY age DESC;
  ```

---

### **Sorting via Numeric Placeholders**

- Instead of column names, use column positions.
  ```sql
  SELECT name, age FROM users ORDER BY 2 DESC;
  ```
- `2` refers to the second column (`age` in this case).

---

THE END OF CHAPTER 3

# Chapter 4: _Filtering_

## WHERE, OR, NOT, AND

this better demonstrated with tables and examples than BS

| Intermediate result    | Final result |
| ---------------------- | ------------ |
| `WHERE true OR true`   | true         |
| `WHERE true OR false`  | true         |
| `WHERE false OR true`  | true         |
| `WHERE false OR false` | false        |

Example:

```sql
SELECT * FROM users
WHERE first_name = 'STEVEN' OR create_date > '2006-01-01';
```

---

| Intermediate result          | Final result |
| ---------------------------- | ------------ |
| `(true OR true) AND true`    | true         |
| `(true OR false) AND true`   | true         |
| `(false OR true) AND true`   | true         |
| `(false OR false) AND true`  | false        |
| `(true OR true) AND false`   | false        |
| `(true OR false) AND false`  | false        |
| `(false OR true) AND false`  | false        |
| `(false OR false) AND false` | false        |

Example:

```sql
SELECT * FROM users
WHERE (first_name = 'STEVEN' OR last_name = 'YOUNG')
AND create_date > '2006-01-01';
```

---

| Intermediate result              | Final result |
| -------------------------------- | ------------ |
| `NOT (true OR true) AND true`    | false        |
| `NOT (true OR false) AND true`   | false        |
| `NOT (false OR true) AND true`   | false        |
| `NOT (false OR false) AND true`  | true         |
| `NOT (true OR true) AND false`   | false        |
| `NOT (true OR false) AND false`  | false        |
| `NOT (false OR true) AND false`  | false        |
| `NOT (false OR false) AND false` | false        |

Example:

```sql
SELECT * FROM users
WHERE NOT (first_name = 'STEVEN' OR last_name = 'YOUNG')
AND create_date > '2006-01-01';
```

---

## Building Conditions

**Comparison operators** are `=`, `!=`, `<`, `>`, `<>`

> `<>` is just `=`

> there are also comparison keywords like `IN`, `NOT IN`, `BETWEEN`

**This part is better demonstrated using the book's examples: **

### Query:

```sql
SELECT c.email
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
WHERE date(r.rental_date) = '2005-06-14';
```

### Output:

| email                                 |
| ------------------------------------- |
| CATHERINE.CAMPBELL@sakilacustomer.org |
| JOYCE.EDWARDS@sakilacustomer.org      |
| TERRENCE.GUNDERSON@sakilacustomer.org |

**16 rows in set (0.03 sec)**

---

## Inequality Conditions

### Query:

```sql
SELECT c.email
FROM customer c
INNER JOIN rental r ON c.customer_id = r.customer_id
WHERE date(r.rental_date) <> '2005-06-14';
```

### Output (Truncated):

| email                             |
| --------------------------------- |
| MARY.SMITH@sakilacustomer.org     |
| AUSTIN.CINTRON@sakilacustomer.org |

**16028 rows in set (0.03 sec)**

---

## Data Modification Using Equality Conditions

### Query:

```sql
DELETE FROM rental
WHERE year(rental_date) = 2004;
```

---

### Query:

```sql
DELETE FROM rental
WHERE year(rental_date) <> 2005 AND year(rental_date) <> 2006;
```

---

## Range Conditions

### Query:

```sql
SELECT customer_id, rental_date
FROM rental
WHERE rental_date < '2005-05-25';
```

### Output:

| customer_id | rental_date         |
| ----------- | ------------------- |
| 130         | 2005-05-24 22:53:30 |
| 459         | 2005-05-24 22:54:33 |
| 408         | 2005-05-24 23:03:39 |
| 333         | 2005-05-24 23:04:41 |
| 239         | 2005-05-24 23:31:46 |

**8 rows in set (0.00 sec)**

---

### Query:

```sql
SELECT customer_id, rental_date
FROM rental
WHERE rental_date <= '2005-06-16' AND rental_date >= '2005-06-14';
```

### Output (Truncated):

| customer_id | rental_date         |
| ----------- | ------------------- |
| 416         | 2005-06-14 22:53:33 |
| 516         | 2005-06-14 22:55:13 |
| 239         | 2005-06-14 23:00:34 |
| 285         | 2005-06-14 23:07:08 |

**364 rows in set (0.00 sec)**

---

## Using `BETWEEN` Operator

### Query:

```sql
SELECT customer_id, rental_date
FROM rental
WHERE rental_date BETWEEN '2005-06-14' AND '2005-06-16';
```

### Output (Truncated):

| customer_id | rental_date         |
| ----------- | ------------------- |
| 416         | 2005-06-14 22:53:33 |
| 516         | 2005-06-14 22:55:13 |
| 239         | 2005-06-14 23:00:34 |
| 285         | 2005-06-14 23:07:08 |
| 310         | 2005-06-14 23:09:38 |
| 592         | 2005-06-14 23:12:46 |

**364 rows in set (0.00 sec)**

---

### Incorrect Use of `BETWEEN`:

```sql
SELECT customer_id, rental_date
FROM rental
WHERE rental_date BETWEEN '2005-06-16' AND '2005-06-14';
```

**Output:**  
_Empty set (0.00 sec)_

---

## Numeric Ranges

### Query:

```sql
SELECT customer_id, payment_date, amount
FROM payment
WHERE amount BETWEEN 10.0 AND 11.99;
```

### Output:

| customer_id | payment_date        | amount |
| ----------- | ------------------- | ------ |
| 2           | 2005-07-30 13:47:43 | 10.99  |
| 3           | 2005-07-27 20:23:12 | 10.99  |
| 12          | 2005-08-01 06:50:26 | 10.99  |
| 29          | 2005-07-09 21:55:19 | 10.99  |

**114 rows in set (0.01 sec)**

---

## String Ranges

### Query:

```sql
SELECT last_name, first_name
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FR';
```

### Output:

| last_name  | first_name |
| ---------- | ---------- |
| FARNSWORTH | JOHN       |
| FENNELL    | ALEXANDER  |
| FERGUSON   | BERTHA     |
| FERNANDEZ  | MELINDA    |
| FOWLER     | JO         |
| FOX        | HOLLY      |

**18 rows in set (0.00 sec)**

---

### Query:

```sql
SELECT last_name, first_name
FROM customer
WHERE last_name BETWEEN 'FA' AND 'FRB';
```

### Output:

| last_name  | first_name |
| ---------- | ---------- |
| FARNSWORTH | JOHN       |
| FRALEY     | JUAN       |
| FRANCISCO  | JOEL       |
| FRANKLIN   | BETH       |
| FRAZIER    | GLENDA     |

**22 rows in set (0.00 sec)**

---

## Menmbershipt

the membership is achieved by `IN` keyword

like

```SQL
SELECT fname, lname
FROM people
WHERE title IN ('eng','phd');
```

not only that

we can create a range from a select clause

like

```SQL
SELECT fname, lname
FROM people
WHERE title IN (SELECT title FROM people WHERE country = "Egypt");
```

the above code will create a range of names of people who are only egyptian, then with will search with this range of names for people with phd

## Extra points

### **1. Partial String Matching**

To find customers whose last names begin with "Q", you can use the `LEFT()` function:

```sql
SELECT last_name, first_name
FROM customer
WHERE LEFT(last_name, 1) = 'Q';
```

This method works but is not flexible. A better approach is using wildcards.

---

### **2. Using Wildcards (`LIKE` Operator)**

Wildcards provide more control over pattern matching:

- **Find names that start with "Q"**
  ```sql
  SELECT last_name, first_name
  FROM customer
  WHERE last_name LIKE 'Q%';
  ```
- **Find names that end with "t"**
  ```sql
  SELECT last_name, first_name
  FROM customer
  WHERE last_name LIKE '%t';
  ```
- **Find names containing "bas" anywhere**
  ```sql
  SELECT last_name, first_name
  FROM customer
  WHERE last_name LIKE '%bas%';
  ```
- **Find names that have "A" in the second position and "T" in the fourth position, ending with "S"**
  ```sql
  SELECT last_name, first_name
  FROM customer
  WHERE last_name LIKE '_A_T%S';
  ```

---

### **3. Using Regular Expressions (`REGEXP`) for Advanced Matching**

If wildcards are not enough, regular expressions (`REGEXP`) can be used:

- **Find names that start with "Q" or "Y"**
  ```sql
  SELECT last_name, first_name
  FROM customer
  WHERE last_name REGEXP '^[QY]';
  ```
- **Find names that have exactly four characters, with "t" in the third position**
  ```sql
  SELECT last_name, first_name
  FROM customer
  WHERE last_name REGEXP '^..t.$';
  ```
- **Find names that follow a specific format (e.g., 11-character names with dashes in the fourth and seventh positions)**
  ```sql
  SELECT last_name, first_name
  FROM customer
  WHERE last_name REGEXP '^...-..-.....$';
  ```

---

### **4. Handling NULL Values**

`NULL` means "no value" and must be handled using `IS NULL` or `IS NOT NULL`.

- **Find all rentals that were never returned (return_date is NULL)**
  ```sql
  SELECT rental_id, customer_id
  FROM rental
  WHERE return_date IS NULL;
  ```
- **Find all rentals that have been returned (return_date is NOT NULL)**
  ```sql
  SELECT rental_id, customer_id, return_date
  FROM rental
  WHERE return_date IS NOT NULL;
  ```

⚠️ **Mistake to Avoid**: Using `= NULL` instead of `IS NULL`.  
Incorrect query (returns no results):

```sql
SELECT rental_id, customer_id
FROM rental
WHERE return_date = NULL;  -- ❌ Wrong!
```

---

### **5. Combining Conditions with NULL Handling**

To find rentals that were **not returned between May and August 2005**, accounting for `NULL` values:

```sql
SELECT rental_id, customer_id, return_date
FROM rental
WHERE return_date IS NULL
   OR return_date NOT BETWEEN '2005-05-01' AND '2005-09-01';
```

This ensures we include both:

1. Rentals that were returned outside the date range.
2. Rentals that were never returned (`NULL` values).

## NULL

> two nulls are not equal each other, because NULL iis not equal to anything

NULL means that a value is missing or doesnt exist; the value itself is not equal null

### **here is how to work with NULL in SQL:**

1. **`NULL` is not equal to anything, even another `NULL`**

   - `NULL = NULL` is **false** because `NULL` represents an unknown value.
   - To check for `NULL`, you must use `IS NULL` or `IS NOT NULL`, not `=` or `!=`.
     ```sql
     SELECT * FROM users WHERE email IS NULL;
     ```

2. **Operations with `NULL` result in `NULL`**

   - Any arithmetic or string operation with `NULL` will return `NULL`:
     ```sql
     SELECT 5 + NULL;  -- Result: NULL
     SELECT 'Hello' || NULL;  -- Result: NULL
     ```

3. **Handling `NULL` in Queries**

   - **`COALESCE()`**: Returns the first non-null value from a list.
     ```sql
     SELECT COALESCE(NULL, 'Default', 'Fallback');  -- Result: 'Default'
     ```
   - **`IFNULL()` (MySQL) or `NVL()` (Oracle)**: Similar to `COALESCE()` but only takes two arguments.
     ```sql
     SELECT IFNULL(NULL, 'Fallback');  -- Result: 'Fallback'
     ```
   - **`NULLIF()`**: Returns `NULL` if two values are equal; otherwise, it returns the first value.
     ```sql
     SELECT NULLIF(10, 10);  -- Result: NULL
     SELECT NULLIF(10, 20);  -- Result: 10
     ```

4. **`NULL` and Aggregate Functions**

   - Most aggregate functions ignore `NULL` values:
     ```sql
     SELECT AVG(salary) FROM employees;  -- NULL salaries are ignored
     ```
   - But `COUNT(*)` includes `NULL` values, while `COUNT(column_name)` excludes them.
     ```sql
     SELECT COUNT(*) FROM employees;       -- Counts all rows
     SELECT COUNT(salary) FROM employees;  -- Excludes NULL salaries
     ```

5. **Sorting and Filtering `NULL`**
   - When sorting, `NULL` values appear **first or last** depending on the database and `ORDER BY` direction.
     ```sql
     SELECT * FROM employees ORDER BY salary ASC;  -- NULLs appear first
     SELECT * FROM employees ORDER BY salary DESC; -- NULLs appear last
     ```
   - You can control this using `NULLS FIRST` or `NULLS LAST` (supported in PostgreSQL and some others).
     ```sql
     SELECT * FROM employees ORDER BY salary DESC NULLS LAST;
     ```

### Example: Handling `NULL` in a Table

Imagine a table `customers`:

| id  | name  | email          |
| --- | ----- | -------------- |
| 1   | John  | john@email.com |
| 2   | Alice | NULL           |
| 3   | Bob   | bob@email.com  |

#### Queries:

- Find customers with no email:

  ```sql
  SELECT * FROM customers WHERE email IS NULL; -- will work
  ```

---

END OF CHAPTER 4

# Chapter 5: _Quering multiple tables_

**this chapter gives an introduction to joins**

joins are more of a design than syntax bu this book is only concerned by syntax

1. **INNER JOIN** – Returns only matching rows from both tables.

   - Example: Get customers who placed an order.

   ```sql
   SELECT customers.name, orders.order_id
   FROM customers
   INNER JOIN orders ON customers.id = orders.customer_id;
   ```

2. **LEFT JOIN (or LEFT OUTER JOIN)** – Returns all rows from the left table and matching rows from the right table. If there’s no match, NULL is returned for columns from the right table.

   - Example: Get all customers, even those who haven’t placed an order.

   ```sql
   SELECT customers.name, orders.order_id
   FROM customers
   LEFT JOIN orders ON customers.id = orders.customer_id;
   ```

3. **RIGHT JOIN (or RIGHT OUTER JOIN)** – Returns all rows from the right table and matching rows from the left table. If there’s no match, NULL is returned for columns from the left table.

   - Example: Get all orders, even if they don’t have a customer.

   ```sql
   SELECT customers.name, orders.order_id
   FROM customers
   RIGHT JOIN orders ON customers.id = orders.customer_id;
   ```

4. **FULL JOIN (or FULL OUTER JOIN)** – Returns all rows from both tables, with NULLs where there is no match.

   - Example: Get all customers and orders, including those without matches.

   ```sql
   SELECT customers.name, orders.order_id
   FROM customers
   FULL JOIN orders ON customers.id = orders.customer_id;
   ```

5. **CROSS JOIN** – Returns all possible combinations (cartesian product) of both tables.
   - Example: Pair every customer with every order.
   ```sql
   SELECT customers.name, orders.order_id
   FROM customers
   CROSS JOIN orders;
   ```

> Joins will be revisited in chapter 10 with more detail

## Some Demonstrative Examples

#### **Customers Table**

| id  | name    | country |
| --- | ------- | ------- |
| 1   | Alice   | USA     |
| 2   | Bob     | Canada  |
| 3   | Charlie | UK      |
| 4   | David   | Egypt   |

#### **Orders Table**

| order_id | customer_id | product  |
| -------- | ----------- | -------- |
| 101      | 1           | Laptop   |
| 102      | 2           | Phone    |
| 103      | 1           | Keyboard |
| 104      | 3           | Monitor  |

---

### **JOIN Examples**

#### **1. INNER JOIN** (Only customers who placed orders)

```sql
SELECT customers.name, orders.order_id, orders.product
FROM customers
INNER JOIN orders ON customers.id = orders.customer_id;
```

✅ **Result:**
| name | order_id | product |
|--------|---------|----------|
| Alice | 101 | Laptop |
| Alice | 103 | Keyboard |
| Bob | 102 | Phone |
| Charlie| 104 | Monitor |

_(David is missing because he has no orders.)_

---

#### **2. LEFT JOIN** (All customers, even those with no orders)

```sql
SELECT customers.name, orders.order_id, orders.product
FROM customers
LEFT JOIN orders ON customers.id = orders.customer_id;
```

✅ **Result:**
| name | order_id | product |
|---------|---------|----------|
| Alice | 101 | Laptop |
| Alice | 103 | Keyboard |
| Bob | 102 | Phone |
| Charlie | 104 | Monitor |
| David | NULL | NULL |

_(David is included, but with NULL values for order details.)_

---

#### **3. RIGHT JOIN** (All orders, even if they don't match a customer)

```sql
SELECT customers.name, orders.order_id, orders.product
FROM customers
RIGHT JOIN orders ON customers.id = orders.customer_id;
```

✅ **Result:**
| name | order_id | product |
|---------|---------|----------|
| Alice | 101 | Laptop |
| Alice | 103 | Keyboard |
| Bob | 102 | Phone |
| Charlie | 104 | Monitor |

_(Same result as INNER JOIN because every order has a matching customer.)_

---

#### **4. FULL OUTER JOIN** (All customers and all orders, even if no match)

```sql
SELECT customers.name, orders.order_id, orders.product
FROM customers
FULL JOIN orders ON customers.id = orders.customer_id;
```

✅ **Result:**
| name | order_id | product |
|---------|---------|----------|
| Alice | 101 | Laptop |
| Alice | 103 | Keyboard |
| Bob | 102 | Phone |
| Charlie | 104 | Monitor |
| David | NULL | NULL |

_(Same as LEFT JOIN here since all orders already have customers.)_

---

#### **5. CROSS JOIN** (Every customer paired with every order)

```sql
SELECT customers.name, orders.order_id, orders.product
FROM customers
CROSS JOIN orders;
```

✅ **Result:** _(All possible combinations of customers and orders)_
| name | order_id | product |
|---------|---------|----------|
| Alice | 101 | Laptop |
| Alice | 102 | Phone |
| Alice | 103 | Keyboard |
| Alice | 104 | Monitor |
| Bob | 101 | Laptop |
| Bob | 102 | Phone |
| Bob | 103 | Keyboard |
| Bob | 104 | Monitor |
| Charlie | 101 | Laptop |
| ... | ... | ... |

_(Results will have **4 customers × 4 orders = 16 rows**.)_

---

END OF CHAPTER 5

# Chapter 6: _Sets_

the first part of this chapter talks about sets (union, intersection, exception)

> an SQL command called `desc` which is used to describe the schema of a table

## Set Operators

set operators are used to combine resuts of multiple queries in one transaction

the are UNION, UNIOIN ALL, INTERSECR, EXCEPT

### **Sample Tables:**

We have two tables:

#### **Customers Table** (`customers`)

| id  | name  | city       |
| --- | ----- | ---------- |
| 1   | Ali   | Cairo      |
| 2   | Omar  | Giza       |
| 3   | Salma | Alexandria |
| 4   | Nada  | Cairo      |

#### **Suppliers Table** (`suppliers`)

| id  | name    | city       |
| --- | ------- | ---------- |
| 1   | Ahmed   | Cairo      |
| 2   | Omar    | Giza       |
| 3   | Nada    | Alexandria |
| 4   | Youssef | Luxor      |

---

### **1. UNION (Removes Duplicates)**

Combines unique names from both tables.

```sql
SELECT name FROM customers
UNION
SELECT name FROM suppliers;
```

#### **Result:**

| name    |
| ------- |
| Ali     |
| Omar    |
| Salma   |
| Nada    |
| Ahmed   |
| Youssef |

👉 **"Omar" and "Nada" appear in both tables but are included only once.**

---

### **2. UNION ALL (Includes Duplicates)**

Combines names but **keeps duplicates**.

```sql
SELECT name FROM customers
UNION ALL
SELECT name FROM suppliers;
```

#### **Result:**

| name    |
| ------- |
| Ali     |
| Omar    |
| Salma   |
| Nada    |
| Ahmed   |
| Omar    |
| Nada    |
| Youssef |

👉 **"Omar" and "Nada" appear twice because they exist in both tables.**

---

### **3. INTERSECT (Common Records in Both Tables)**

Returns only names **that exist in both** `customers` and `suppliers`.

```sql
SELECT name FROM customers
INTERSECT
SELECT name FROM suppliers;
```

#### **Result:**

| name |
| ---- |
| Omar |
| Nada |

👉 **Only "Omar" and "Nada" are common in both tables.**  
(_Note:_ `INTERSECT` is not supported in MySQL.)

---

### **4. EXCEPT (MINUS in Oracle)**

Returns names from `customers` **that are NOT in** `suppliers`.

```sql
SELECT name FROM customers
EXCEPT
SELECT name FROM suppliers;
```

#### **Result:**

| name  |
| ----- |
| Ali   |
| Salma |

👉 **"Ali" and "Salma" are in `customers` but NOT in `suppliers`.**  
(_In Oracle, use `MINUS` instead of `EXCEPT`._)

---

### **Summary Table**

| Operator           | Function                                            |
| ------------------ | --------------------------------------------------- |
| `UNION`            | Combines results, removes duplicates                |
| `UNION ALL`        | Combines results, keeps duplicates                  |
| `INTERSECT`        | Returns common rows in both tables                  |
| `EXCEPT` (`MINUS`) | Returns rows from the first table not in the second |

---

END OF CHAPTER 6

# Chapter 7: _Data manipulation_

this chapter introduces MySQL-specific functions

## String Manipulation Functions

Let's start with string concatenation, which varies across database systems:

### String Concatenation

```sql
-- MySQL
SELECT CONCAT('Hello', ' ', 'World') AS greeting;
-- Result: 'Hello World'

-- Oracle
SELECT 'Hello' || ' ' || 'World' AS greeting FROM dual;
-- Result: 'Hello World'

-- SQL Server
SELECT 'Hello' + ' ' + 'World' AS greeting;
-- Result: 'Hello World'
```

This demonstrates how different database systems handle the same operation of joining strings together.

### Substring Functions

The SUBSTRING function extracts part of a string:

```sql
-- MySQL syntax
SELECT SUBSTRING('Please find the substring in this string', 17, 9) AS extract;
-- Result: 'substring'

-- Breaking down the parameters:
-- 'Please find the substring in this string' is the source string
-- 17 is the starting position (1-indexed in MySQL)
-- 9 is the length of the substring to extract
```

### String Padding Functions

LPAD and RPAD add characters to make a string a specific length:

```sql
-- Left padding (adds characters to the left)
SELECT LPAD('Price', 10, '*') AS padded_left;
-- Result: '*****Price'

-- Right padding (adds characters to the right)
SELECT RPAD('Price', 10, '*') AS padded_right;
-- Result: 'Price*****'
```

## Numeric Functions

### Rounding Functions

Let's clarify the ROUND function with examples:

```sql
-- Round to 2 decimal places
SELECT ROUND(123.4567, 2) AS rounded_positive;
-- Result: 123.46

-- Round negative number to 2 decimal places
SELECT ROUND(-25.76823, 2) AS rounded_negative;
-- Result: -25.77

-- Round to nearest integer (0 decimal places)
SELECT ROUND(123.5, 0) AS rounded_integer;
-- Result: 124
```

### Floor and Ceiling

These functions round to the nearest integer in a specific direction:

```sql
-- FLOOR always rounds down to the nearest integer
SELECT FLOOR(123.99) AS floor_example;
-- Result: 123

-- CEILING always rounds up to the nearest integer
SELECT CEIL(123.01) AS ceiling_example;
-- Result: 124
```

## Date and Time Functions

### Extracting Parts of Dates

```sql
-- Extract the month from the current date
SELECT EXTRACT(MONTH FROM CURRENT_DATE) AS current_month;
-- If today is December 15, 2023, result would be: 12

-- Extract the year from a specific date
SELECT EXTRACT(YEAR FROM '2023-12-15') AS specific_year;
-- Result: 2023
```

### Adding and Subtracting Time Intervals

```sql
-- MySQL: Add 3 days to a date
SELECT DATE_ADD('2023-12-15', INTERVAL 3 DAY) AS future_date;
-- Result: '2023-12-18'

-- MySQL: Subtract 1 month from a date
SELECT DATE_SUB('2023-12-15', INTERVAL 1 MONTH) AS past_date;
-- Result: '2023-11-15'

-- SQL Server: Add 3 days to a date
SELECT DATEADD(day, 3, '2023-12-15') AS future_date;
-- Result: '2023-12-18'
```

## Type Conversion Functions

The CAST function converts data from one type to another:

```sql
-- Convert string to integer
SELECT CAST('123' AS SIGNED) AS int_value;
-- Result: 123

-- Convert string to date
SELECT CAST('2023-12-15' AS DATE) AS date_value;
-- Result: 2023-12-15

-- Convert number to string
SELECT CAST(123.45 AS CHAR) AS string_value;
-- Result: '123.45'
```

## Regular Expressions in SQL

Regular expressions provide powerful pattern matching capabilities in SQL. Though implementation varies by database system, MySQL's implementation serves as a good example:

```sql
-- Check if a string contains a pattern using REGEXP
SELECT 'Programming' REGEXP 'gram' AS contains_pattern;
-- Result: 1 (true)

-- Match strings starting with a specific pattern
SELECT 'Database' REGEXP '^Data' AS starts_with_data;
-- Result: 1 (true)

-- Match strings ending with a specific pattern
SELECT 'Database' REGEXP 'base$' AS ends_with_base;
-- Result: 1 (true)

-- Match any single character with '.'
SELECT 'Database' REGEXP 'D.tab' AS match_single_char;
-- Result: 1 (true, matches "Datab")

-- Match numbers in a string
SELECT 'Room 123' REGEXP '[0-9]+' AS contains_numbers;
-- Result: 1 (true)
```

Regular expressions make it possible to perform complex string validation and extraction that would be difficult with basic string functions alone. For example, you could validate email formats or extract specific patterns from text.

## Finding Substrings

The document mentions several functions for locating substrings within larger strings:

```sql
-- MySQL LOCATE function (returns the position of the first occurrence)
SELECT LOCATE('SQL', 'Learning SQL is fun') AS position;
-- Result: 10 (position where 'SQL' starts)

-- LOCATE with starting position parameter
SELECT LOCATE('a', 'database management', 3) AS position;
-- Result: 4 (finds the first 'a' starting from position 3)

-- INSTR function (similar to LOCATE)
SELECT INSTR('Learning SQL is fun', 'SQL') AS position;
-- Result: 10

-- SQL Server CHARINDEX
-- CHARINDEX(substring, string, [start_position])
SELECT CHARINDEX('SQL', 'Learning SQL is fun') AS position;
-- Result: 10
```

The key difference between these functions is their syntax and which database systems support them. LOCATE and INSTR are commonly used in MySQL, while CHARINDEX is specific to SQL Server.

## Trigonometric Functions

SQL provides standard trigonometric functions for mathematical calculations:

```sql
-- Calculate sine of an angle (in radians)
SELECT SIN(1) AS sine_of_one;
-- Result: 0.8414709848078965

-- Calculate cosine of an angle
SELECT COS(0) AS cosine_of_zero;
-- Result: 1

-- Convert degrees to radians for trigonometric functions
SELECT SIN(RADIANS(30)) AS sine_of_30_degrees;
-- Result: 0.5

-- Calculate tangent
SELECT TAN(RADIANS(45)) AS tangent_of_45_degrees;
-- Result: 1

-- Calculate arc sine (inverse sine)
SELECT DEGREES(ASIN(0.5)) AS arcsin_in_degrees;
-- Result: 30
```

These functions are particularly useful for scientific and engineering applications where mathematical transformations of data are needed.

## Date Differences and Manipulations

Working with date differences is a common task in SQL:

```sql
-- Calculate days between two dates
SELECT DATEDIFF('2023-12-31', '2023-01-01') AS days_in_year;
-- Result: 364

-- Calculate months between dates (MySQL)
SELECT PERIOD_DIFF(202312, 202301) AS months_diff;
-- Result: 11

-- Add different intervals to dates
SELECT
    DATE_ADD('2023-01-01', INTERVAL 1 YEAR) AS one_year_later,
    DATE_ADD('2023-01-01', INTERVAL 3 MONTH) AS three_months_later,
    DATE_ADD('2023-01-01', INTERVAL 14 DAY) AS two_weeks_later,
    DATE_ADD('2023-01-01 12:00:00', INTERVAL 30 MINUTE) AS thirty_min_later;
/* Results:
   one_year_later: '2024-01-01'
   three_months_later: '2023-04-01'
   two_weeks_later: '2023-01-15'
   thirty_min_later: '2023-01-01 12:30:00'
*/
```

These functions allow for sophisticated date-based calculations, which are essential for reporting, scheduling, and business intelligence applications.

## Date Formatting

While the document doesn't provide specific examples of date formatting functions, this is an important topic:

```sql
-- MySQL DATE_FORMAT function for custom date formatting
SELECT DATE_FORMAT('2023-12-15', '%W, %M %d, %Y') AS formatted_date;
-- Result: 'Friday, December 15, 2023'

-- Common format specifiers:
-- %Y = 4-digit year (2023)
-- %y = 2-digit year (23)
-- %m = month as a number (01-12)
-- %M = month name (January-December)
-- %d = day of month (01-31)
-- %W = weekday name (Sunday-Saturday)
-- %H = hour (00-23)
-- %i = minutes (00-59)
-- %s = seconds (00-59)

-- SQL Server date formatting using CONVERT with style parameter
SELECT CONVERT(VARCHAR, GETDATE(), 107) AS formatted_date;
-- Result: 'Dec 15, 2023' (style 107 produces this format)
```

Date formatting is crucial for presenting dates in a readable format for reports and user interfaces.

## Complex Type Conversion Examples

The CAST and CONVERT functions are essential for data type conversions:

```sql
-- Convert between various data types
SELECT
    CAST('2023-12-15' AS DATE) AS string_to_date,
    CAST(123.45 AS DECIMAL(10,1)) AS rounded_decimal,
    CAST(0 AS BOOLEAN) AS numeric_to_boolean,
    CAST(CURRENT_TIMESTAMP AS DATE) AS timestamp_to_date;
/* Results:
   string_to_date: 2023-12-15
   rounded_decimal: 123.5 (rounded to 1 decimal place)
   numeric_to_boolean: FALSE (0 converts to false in boolean context)
   timestamp_to_date: 2023-12-15 (time portion removed)
*/

-- Formatting numbers as currency strings
SELECT CONCAT('$', FORMAT(1234567.89, 2)) AS currency_format;
-- Result: '$1,234,567.89'

-- Converting between character sets (MySQL)
SELECT CONVERT('Sample text' USING utf8mb4) AS converted_text;
-- Result: Same text but encoded in UTF-8
```

Type conversions are particularly important when:

1. Importing data from external sources
2. Preparing data for display or export
3. Performing calculations that require specific data types
4. Comparing values of different types

---

END OF CHAPTER 7

# Chapter 8: _Grouping and Aggregations_

## Some Useful Aggregate Functions

### 1. COUNT()

Counts the number of rows in a group.

```sql
SELECT COUNT(*) AS total_customers FROM customers;
```

**Example Output:**
| total_customers |
|----------------|
| 100 |

---

### 2. SUM()

Calculates the total sum of a numeric column.

```sql
SELECT SUM(price) AS total_revenue FROM orders;
```

**Example Output:**
| total_revenue |
|--------------|
| 25000 |

---

### 3. AVG()

Calculates the average (mean) value of a numeric column.

```sql
SELECT AVG(salary) AS average_salary FROM employees;
```

**Example Output:**
| average_salary |
|--------------|
| 5000 |

---

### 4. MAX()

Finds the highest value in a column.

```sql
SELECT MAX(price) AS highest_price FROM products;
```

**Example Output:**
| highest_price |
|--------------|
| 999 |

---

### 5. MIN()

Finds the lowest value in a column.

```sql
SELECT MIN(price) AS lowest_price FROM products;
```

**Example Output:**
| lowest_price |
|-------------|
| 10 |

---

### 6. GROUP_CONCAT()

Concatenates values from a grouped column into a single string.

```sql
SELECT category, GROUP_CONCAT(product_name) AS products_list
FROM products
GROUP BY category;
```

**Example Output:**
| category | products_list |
|-----------|------------------------|
| Electronics | Laptop, Phone, Tablet |
| Furniture | Chair, Desk |

---

### 7. VARIANCE() (or VAR_SAMP, VAR_POP)

Calculates the variance of a numeric column.

```sql
SELECT VARIANCE(salary) AS salary_variance FROM employees;
```

---

### 8. STDDEV() (or STDDEV_SAMP, STDDEV_POP)

Calculates the standard deviation of a numeric column.

```sql
SELECT STDDEV(salary) AS salary_stddev FROM employees;
```

---

### Example: Using Multiple Aggregate Functions Together

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(price) AS total_revenue,
    AVG(price) AS avg_order_price,
    MAX(price) AS highest_order,
    MIN(price) AS lowest_order
FROM orders;
```

This query provides useful business insights in a single query.

## Grouping

### GROUP BY Clause

The `GROUP BY` clause is used to group rows with the same values in one or more columns and apply aggregate functions to each group.

#### **Syntax**

```sql
SELECT column_name, AGGREGATE_FUNCTION(column_name)
FROM table_name
GROUP BY column_name;
```

#### **Example: Total Sales by Category**

```sql
SELECT category, SUM(price * quantity) AS total_sales
FROM sales
GROUP BY category;
```

##### **Output:**

| category    | total_sales |
| ----------- | ----------- |
| Electronics | 19100       |
| Furniture   | 5100        |

---

### GROUPING MULTIPLE COLUMNS

You can group by multiple columns to get more granular summaries.

#### **Example: Total Sales by Category and Product**

```sql
SELECT category, product, SUM(price * quantity) AS total_sales
FROM sales
GROUP BY category, product;
```

##### **Output:**

| category    | product | total_sales |
| ----------- | ------- | ----------- |
| Electronics | Laptop  | 5000        |
| Electronics | Phone   | 5000        |
| Electronics | Tablet  | 4900        |
| Furniture   | Chair   | 2250        |
| Furniture   | Desk    | 2000        |

---

### GROUP BY with HAVING Clause

- The `HAVING` clause filters the groups after aggregation (unlike `WHERE`, which filters rows before aggregation).

#### **Example: Filter Categories with Total Sales Over 5000**

```sql
SELECT category, SUM(price * quantity) AS total_sales
FROM sales
GROUP BY category
HAVING total_sales > 5000;
```

##### **Output:**

| category    | total_sales |
| ----------- | ----------- |
| Electronics | 19100       |

---

## Some Useful Aggregate Functions

### 1. COUNT()

Counts the number of rows in a group.

```sql
SELECT COUNT(*) AS total_customers FROM customers;
```

**Example Output:**
| total_customers |
|----------------|
| 100 |

---

### 2. SUM()

Calculates the total sum of a numeric column.

```sql
SELECT SUM(price) AS total_revenue FROM orders;
```

**Example Output:**
| total_revenue |
|--------------|
| 25000 |

---

### 3. AVG()

Calculates the average (mean) value of a numeric column.

```sql
SELECT AVG(salary) AS average_salary FROM employees;
```

**Example Output:**
| average_salary |
|--------------|
| 5000 |

---

### 4. MAX()

Finds the highest value in a column.

```sql
SELECT MAX(price) AS highest_price FROM products;
```

**Example Output:**
| highest_price |
|--------------|
| 999 |

---

### 5. MIN()

Finds the lowest value in a column.

```sql
SELECT MIN(price) AS lowest_price FROM products;
```

**Example Output:**
| lowest_price |
|-------------|
| 10 |

---

### 6. GROUP_CONCAT()

Concatenates values from a grouped column into a single string.

```sql
SELECT category, GROUP_CONCAT(product_name) AS products_list
FROM products
GROUP BY category;
```

**Example Output:**
| category | products_list |
|-----------|------------------------|
| Electronics | Laptop, Phone, Tablet |
| Furniture | Chair, Desk |

---

### 7. VARIANCE() (or VAR_SAMP, VAR_POP)

Calculates the variance of a numeric column.

```sql
SELECT VARIANCE(salary) AS salary_variance FROM employees;
```

---

### 8. STDDEV() (or STDDEV_SAMP, STDDEV_POP)

Calculates the standard deviation of a numeric column.

```sql
SELECT STDDEV(salary) AS salary_stddev FROM employees;
```

---

### Example: Using Multiple Aggregate Functions Together

```sql
SELECT
    COUNT(*) AS total_orders,
    SUM(price) AS total_revenue,
    AVG(price) AS avg_order_price,
    MAX(price) AS highest_order,
    MIN(price) AS lowest_order
FROM orders;
```

This query provides useful business insights in a single query.

---

END OF CHAPTER 8

# Chapter 9: _Subqueries_

Subqueries are queries nested within another SQL query, creating powerful ways to retrieve, filter, and transform data. They allow you to use the results of one query as part of another query.

## **1. One Column, One Row (Scalar Subquery)**

A **scalar subquery** returns a single value (one column, one row). It is often used in `SELECT`, `WHERE`, or `HAVING` clauses.

### **Example: Get the most expensive product price**

```SQL
SELECT name, price
FROM products
WHERE price = (SELECT MAX(price) FROM products);
```

- The subquery `(SELECT MAX(price) FROM products)` returns a single value (highest price).
- The main query finds the product with this price.

## **2. One Column, Many Rows (List Subquery)**

A subquery returning **multiple values in a single column** is used with `IN`, `ANY`, or `ALL`.

### **Example: Get employees working in the 'Marketing' department**

```SQL
SELECT employee_name, salary
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE department_name = 'Marketing'
);
```

- The subquery `(SELECT department_id FROM departments WHERE department_name = 'Marketing')` returns a list of department IDs.
- The main query selects employees from those departments.

## **3. Many Columns, Many Rows (Table Subquery)**

A subquery that returns **multiple columns and rows** can be used with `EXISTS`, `JOIN`, or as a derived table.

### **Example: Find customers who have placed an order**

```SQL
SELECT name
FROM customers
WHERE EXISTS (
    SELECT 1 FROM orders WHERE customers.id = orders.customer_id
);
```

- The subquery `(SELECT 1 FROM orders WHERE customers.id = orders.customer_id)` checks if a customer has orders.
- `EXISTS` returns `TRUE` if at least one matching row is found.

### **Example: Use Subquery as a Derived Table**

```SQL
SELECT avg_salary.department_id, avg_salary.avg_salary
FROM (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
) AS avg_salary;
```

- The subquery `(SELECT department_id, AVG(salary) AS avg_salary FROM employees GROUP BY department_id)` calculates the average salary per department.
- The main query retrieves this derived data.

## Practical Use Cases for SQL Subqueries

SQL subqueries provide flexible ways to solve complex data problems that would be difficult to express with simpler queries. Let me walk you through the major use cases where subqueries shine, with practical examples for each.

## 1. Filtering Based on Aggregated Data

One of the most common uses of subqueries is filtering records based on aggregated values that can't be directly accessed in a WHERE clause.

```sql
-- Find products that are priced above average
SELECT product_name, price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- Find customers who have placed more than the average number of orders
SELECT customer_name, COUNT(*) as order_count
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, customer_name
HAVING COUNT(*) > (
    SELECT AVG(order_count)
    FROM (
        SELECT COUNT(*) AS order_count
        FROM orders
        GROUP BY customer_id
    ) AS customer_orders
);
```

This approach is necessary because you can't use aggregate functions directly in WHERE clauses. The subquery calculates the aggregate value first, which is then used by the outer query.

### 2. Finding Records with No Matches (Anti-Join Pattern)

Subqueries provide elegant ways to find records that don't have corresponding entries in another table.

```sql
-- Find products that have never been ordered
SELECT product_id, product_name
FROM products p
WHERE NOT EXISTS (
    SELECT 1
    FROM order_details od
    WHERE od.product_id = p.product_id
);

-- Alternative using LEFT JOIN
SELECT p.product_id, p.product_name
FROM products p
LEFT JOIN order_details od ON p.product_id = od.product_id
WHERE od.product_id IS NULL;
```

The NOT EXISTS approach often performs better for large datasets than alternatives, as it can stop checking once it finds a single match.

### 3. Dynamic Reporting with Row-by-Row Calculations

Subqueries in SELECT clauses allow you to calculate specific metrics for each row that depend on other data in the database.

```sql
-- Sales report with percentage of total for each product
SELECT
    p.product_id,
    p.product_name,
    SUM(od.quantity * od.unit_price) AS product_sales,
    (SUM(od.quantity * od.unit_price) / (
        SELECT SUM(quantity * unit_price)
        FROM order_details
    )) * 100 AS percentage_of_total_sales
FROM products p
JOIN order_details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
ORDER BY product_sales DESC;

-- List each employee with their department's average salary for comparison
SELECT
    e.employee_id,
    e.employee_name,
    e.salary,
    (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id) AS dept_avg_salary,
    e.salary - (SELECT AVG(salary) FROM employees WHERE department_id = e.department_id) AS diff_from_avg
FROM employees e
ORDER BY diff_from_avg DESC;
```

These subqueries create dynamic metrics that would be difficult to generate with joins alone, especially when comparing individual records against aggregates.

### 4. Data Pivoting and Reshaping

Subqueries can help transform data from rows to columns for reporting and analysis.

```sql
-- Create a quarterly sales summary by region
SELECT
    region,
    (SELECT SUM(sales_amount) FROM sales s2
     WHERE s2.region = s1.region AND EXTRACT(QUARTER FROM sale_date) = 1 AND EXTRACT(YEAR FROM sale_date) = 2023) AS Q1,
    (SELECT SUM(sales_amount) FROM sales s2
     WHERE s2.region = s1.region AND EXTRACT(QUARTER FROM sale_date) = 2 AND EXTRACT(YEAR FROM sale_date) = 2023) AS Q2,
    (SELECT SUM(sales_amount) FROM sales s2
     WHERE s2.region = s1.region AND EXTRACT(QUARTER FROM sale_date) = 3 AND EXTRACT(YEAR FROM sale_date) = 2023) AS Q3,
    (SELECT SUM(sales_amount) FROM sales s2
     WHERE s2.region = s1.region AND EXTRACT(QUARTER FROM sale_date) = 4 AND EXTRACT(YEAR FROM sale_date) = 2023) AS Q4
FROM (SELECT DISTINCT region FROM sales WHERE EXTRACT(YEAR FROM sale_date) = 2023) s1
ORDER BY region;
```

This approach creates a pivoted view of the data without requiring special pivot functions, which aren't available in all SQL implementations.

### 5. Multi-Step Data Transformations

Complex data processing often requires multiple transformation steps. Subqueries in the FROM clause let you perform transformations in stages, making queries easier to understand and debug.

```sql
-- Calculate year-over-year growth by product category
SELECT
    current_year.category_name,
    current_year.sales AS current_year_sales,
    previous_year.sales AS previous_year_sales,
    (current_year.sales - previous_year.sales) / previous_year.sales * 100 AS growth_percentage
FROM
    (SELECT c.category_name, SUM(od.quantity * od.unit_price) AS sales
     FROM categories c
     JOIN products p ON c.category_id = p.category_id
     JOIN order_details od ON p.product_id = od.product_id
     JOIN orders o ON od.order_id = o.order_id
     WHERE EXTRACT(YEAR FROM o.order_date) = 2023
     GROUP BY c.category_name) AS current_year
JOIN
    (SELECT c.category_name, SUM(od.quantity * od.unit_price) AS sales
     FROM categories c
     JOIN products p ON c.category_id = p.category_id
     JOIN order_details od ON p.product_id = od.product_id
     JOIN orders o ON od.order_id = o.order_id
     WHERE EXTRACT(YEAR FROM o.order_date) = 2022
     GROUP BY c.category_name) AS previous_year
ON current_year.category_name = previous_year.category_name
ORDER BY growth_percentage DESC;
```

Each subquery performs a specific calculation, and the main query combines the results. This approach makes complex analytics more manageable and readable.

### 6. Top-N Per Group Problems

Subqueries excel at finding the top records within each category or group, a common requirement in business reporting.

```sql
-- Find the most recent order for each customer
SELECT o.*
FROM orders o
WHERE o.order_date = (
    SELECT MAX(order_date)
    FROM orders o2
    WHERE o2.customer_id = o.customer_id
);

-- Find the top 3 selling products in each category
SELECT *
FROM (
    SELECT
        p.category_id,
        p.product_id,
        p.product_name,
        SUM(od.quantity) AS total_quantity,
        ROW_NUMBER() OVER (PARTITION BY p.category_id ORDER BY SUM(od.quantity) DESC) AS rank
    FROM products p
    JOIN order_details od ON p.product_id = od.product_id
    GROUP BY p.category_id, p.product_id, p.product_name
) ranked_products
WHERE rank <= 3;
```

The second example combines a subquery with window functions for an elegant solution to the "top N per group" problem.

### 7. Dynamic Data Validation and Constraints

Subqueries can implement complex business rules and validations that go beyond simple constraints.

```sql
-- Ensure a new order doesn't exceed the customer's credit limit
INSERT INTO orders (order_id, customer_id, order_date, total_amount)
SELECT
    12345,
    101,
    CURRENT_DATE,
    500.00
WHERE 500.00 + (
    SELECT COALESCE(SUM(total_amount), 0)
    FROM orders
    WHERE customer_id = 101 AND payment_status = 'Unpaid'
) <= (
    SELECT credit_limit
    FROM customers
    WHERE customer_id = 101
);

-- Reject product price changes that exceed 10% of the average price in their category
UPDATE products
SET price = 29.99
WHERE product_id = 123
AND 29.99 BETWEEN (
    SELECT 0.9 * AVG(price)
    FROM products
    WHERE category_id = (SELECT category_id FROM products WHERE product_id = 123)
) AND (
    SELECT 1.1 * AVG(price)
    FROM products
    WHERE category_id = (SELECT category_id FROM products WHERE product_id = 123)
);
```

These examples show how subqueries can enforce sophisticated business rules during data modifications.

### 8. Time Series Gap Analysis

Identifying gaps in sequential data is a common challenge that subqueries handle effectively.

```sql
-- Find dates with no sales in a date range
WITH date_series AS (
    SELECT DATEADD(day, seq, '2023-01-01') AS calendar_date
    FROM (
        SELECT ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) - 1 AS seq
        FROM information_schema.columns c1
        CROSS JOIN information_schema.columns c2
        LIMIT 365
    ) seq_numbers
    WHERE DATEADD(day, seq, '2023-01-01') <= '2023-12-31'
)
SELECT calendar_date
FROM date_series ds
LEFT JOIN daily_sales s ON ds.calendar_date = s.sale_date
WHERE s.sale_date IS NULL
ORDER BY calendar_date;
```

This query generates all dates in a range and then identifies those without corresponding sales records.

### 9. Hierarchical Data Queries

Querying hierarchical data like organizational charts or product categories requires specialized techniques, often involving subqueries.

```sql
-- Find all employees under a specific manager (recursive approach)
WITH employee_hierarchy AS (
    -- Base case: start with the manager
    SELECT employee_id, employee_name, manager_id, 1 AS level
    FROM employees
    WHERE employee_id = 5

    UNION ALL

    -- Recursive case: add employees who report to someone in our hierarchy
    SELECT e.employee_id, e.employee_name, e.manager_id, eh.level + 1
    FROM employees e
    JOIN employee_hierarchy eh ON e.manager_id = eh.employee_id
)
SELECT * FROM employee_hierarchy
ORDER BY level, employee_name;
```

This recursive common table expression (CTE) builds a hierarchy starting from a specific employee and finding all direct and indirect reports.

### 10. Data Anomaly Detection

Subqueries help identify outliers and anomalies in data by comparing values against statistical norms.

```sql
-- Find orders with unusually high values (more than 2 standard deviations above average)
SELECT order_id, customer_id, total_amount
FROM orders
WHERE total_amount > (
    SELECT AVG(total_amount) + 2 * STDDEV(total_amount)
    FROM orders
);

-- Find products with sudden sales spikes (more than 200% of their average)
SELECT
    p.product_id,
    p.product_name,
    o.order_date,
    SUM(od.quantity) AS daily_quantity
FROM products p
JOIN order_details od ON p.product_id = od.product_id
JOIN orders o ON od.order_id = o.order_id
GROUP BY p.product_id, p.product_name, o.order_date
HAVING SUM(od.quantity) > 2 * (
    SELECT AVG(daily_qty)
    FROM (
        SELECT
            p2.product_id,
            o2.order_date,
            SUM(od2.quantity) AS daily_qty
        FROM products p2
        JOIN order_details od2 ON p2.product_id = od2.product_id
        JOIN orders o2 ON od2.order_id = o2.order_id
        WHERE p2.product_id = p.product_id
        GROUP BY p2.product_id, o2.order_date
    ) AS product_daily_sales
)
ORDER BY o.order_date DESC;
```

These queries identify potentially suspicious transactions or unusual sales patterns that might warrant investigation.

### 11. Comparing Current Values with Historical Snapshots

Subqueries can efficiently compare current data with historical values to track changes over time.

```sql
-- Find products whose prices have increased by more than 20% since last year
SELECT
    p.product_id,
    p.product_name,
    p.current_price,
    (
        SELECT price
        FROM product_price_history
        WHERE product_id = p.product_id
        AND price_effective_date = (
            SELECT MAX(price_effective_date)
            FROM product_price_history
            WHERE product_id = p.product_id
            AND price_effective_date <= DATEADD(year, -1, CURRENT_DATE)
        )
    ) AS price_one_year_ago,
    (p.current_price / (
        SELECT price
        FROM product_price_history
        WHERE product_id = p.product_id
        AND price_effective_date = (
            SELECT MAX(price_effective_date)
            FROM product_price_history
            WHERE product_id = p.product_id
            AND price_effective_date <= DATEADD(year, -1, CURRENT_DATE)
        )
    ) - 1) * 100 AS price_increase_percentage
FROM products p
WHERE p.current_price > 1.2 * (
    SELECT price
    FROM product_price_history
    WHERE product_id = p.product_id
    AND price_effective_date = (
        SELECT MAX(price_effective_date)
        FROM product_price_history
        WHERE product_id = p.product_id
        AND price_effective_date <= DATEADD(year, -1, CURRENT_DATE)
    )
)
ORDER BY price_increase_percentage DESC;
```

This complex query finds the closest historical price record from approximately a year ago and compares it with current prices, highlighting significant increases.

### 12. Dynamic SQL Generation

While not a direct use of subqueries in the SQL language, subqueries are often used to generate dynamic SQL statements in applications or stored procedures:

```sql
-- Stored procedure that generates and executes SQL based on user parameters
CREATE PROCEDURE generate_sales_report(
    in_start_date DATE,
    in_end_date DATE,
    in_grouping VARCHAR(20) -- 'product', 'category', 'customer', etc.
)
AS $$
DECLARE
    sql_text TEXT;
BEGIN
    -- Construct SQL based on the grouping parameter
    sql_text := 'SELECT ';

    IF in_grouping = 'product' THEN
        sql_text := sql_text || 'p.product_id, p.product_name, ';
    ELSIF in_grouping = 'category' THEN
        sql_text := sql_text || 'c.category_id, c.category_name, ';
    ELSIF in_grouping = 'customer' THEN
        sql_text := sql_text || 'cu.customer_id, cu.customer_name, ';
    END IF;

    sql_text := sql_text || 'SUM(od.quantity * od.unit_price) AS total_sales
    FROM order_details od
    JOIN orders o ON od.order_id = o.order_id ';

    IF in_grouping = 'product' THEN
        sql_text := sql_text || 'JOIN products p ON od.product_id = p.product_id ';
    ELSIF in_grouping = 'category' THEN
        sql_text := sql_text || 'JOIN products p ON od.product_id = p.product_id
                                JOIN categories c ON p.category_id = c.category_id ';
    ELSIF in_grouping = 'customer' THEN
        sql_text := sql_text || 'JOIN customers cu ON o.customer_id = cu.customer_id ';
    END IF;

    sql_text := sql_text || 'WHERE o.order_date BETWEEN $1 AND $2
    GROUP BY ';

    IF in_grouping = 'product' THEN
        sql_text := sql_text || 'p.product_id, p.product_name ';
    ELSIF in_grouping = 'category' THEN
        sql_text := sql_text || 'c.category_id, c.category_name ';
    ELSIF in_grouping = 'customer' THEN
        sql_text := sql_text || 'cu.customer_id, cu.customer_name ';
    END IF;

    sql_text := sql_text || 'ORDER BY total_sales DESC';

    -- Execute the dynamically generated SQL
    EXECUTE sql_text USING in_start_date, in_end_date;
END;
$$ LANGUAGE plpgsql;
```

This stored procedure constructs different SQL queries based on the user's desired grouping, demonstrating how subqueries are part of dynamic SQL generation strategies.

Understanding these use cases helps you recognize when subqueries are the right tool for your SQL challenges. While there are often multiple ways to solve a problem in SQL, subqueries provide an elegant and often intuitive approach for complex data manipulations.

---

END OF CHAPTER 9

# Chapter 10: _Joins Revisited_

this chapter exmplains outer joins

### **1. Outer Joins**

An **outer join** returns matching rows from both tables plus the unmatched rows from one or both tables.  
Types of outer joins:

- **LEFT OUTER JOIN**: Returns all rows from the left table and matching rows from the right table.
- **RIGHT OUTER JOIN**: Returns all rows from the right table and matching rows from the left table.
- **FULL OUTER JOIN**: Returns all rows from both tables, filling unmatched values with `NULL`.

#### **Example**

```sql
CREATE TABLE Employees (
    id INT PRIMARY KEY,
    name VARCHAR(50)
);

CREATE TABLE Departments (
    id INT PRIMARY KEY,
    department VARCHAR(50),
    emp_id INT
);

INSERT INTO Employees VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Charlie');
INSERT INTO Departments VALUES (1, 'HR', 1), (2, 'IT', 2), (3, 'Finance', NULL);
```

### **2. Left vs. Right Outer Joins**

- **LEFT JOIN (LEFT OUTER JOIN)**: Returns all rows from the left table, even if there's no match in the right table.
- **RIGHT JOIN (RIGHT OUTER JOIN)**: Returns all rows from the right table, even if there's no match in the left table.

#### **LEFT JOIN Example**

```sql
SELECT e.name, d.department
FROM Employees e
LEFT JOIN Departments d ON e.id = d.emp_id;
```

✅ **Result**:

```
name    | department
--------|------------
Alice   | HR
Bob     | IT
Charlie | NULL  -- No matching department
```

#### **RIGHT JOIN Example**

```sql
SELECT e.name, d.department
FROM Employees e
RIGHT JOIN Departments d ON e.id = d.emp_id;
```

✅ **Result**:

```
name    | department
--------|------------
Alice   | HR
Bob     | IT
NULL    | Finance  -- No matching employee
```

---

### **3. Three-Way Outer Joins**

A **three-way outer join** involves three tables using outer joins.

#### **Example**

```sql
CREATE TABLE Projects (
    id INT PRIMARY KEY,
    project_name VARCHAR(50),
    emp_id INT
);

INSERT INTO Projects VALUES (1, 'Project A', 1), (2, 'Project B', NULL);
```

```sql
SELECT e.name, d.department, p.project_name
FROM Employees e
LEFT JOIN Departments d ON e.id = d.emp_id
LEFT JOIN Projects p ON e.id = p.emp_id;
```

✅ **Result**:

```
name    | department | project_name
--------|------------|--------------
Alice   | HR        | Project A
Bob     | IT        | NULL
Charlie | NULL      | NULL
```

---

### **4. Cross Joins**

A **CROSS JOIN** returns all possible combinations of rows from two tables (Cartesian product).

#### **Example**

```sql
SELECT e.name, d.department
FROM Employees e
CROSS JOIN Departments d;
```

✅ **Result** _(3 employees × 3 departments = 9 rows)_:

```
name    | department
--------|------------
Alice   | HR
Alice   | IT
Alice   | Finance
Bob     | HR
Bob     | IT
Bob     | Finance
Charlie | HR
Charlie | IT
Charlie | Finance
```

---

### **5. Natural Joins**

A **NATURAL JOIN** automatically joins tables based on columns with the same name.

#### **Example**

```sql
SELECT * FROM Employees
NATURAL JOIN Departments;
```

✅ **Equivalent to**:

```sql
SELECT e.id, e.name, d.department
FROM Employees e
INNER JOIN Departments d ON e.id = d.emp_id;
```

---

### **Summary Table**

| Join Type        | Behavior                                                  |
| ---------------- | --------------------------------------------------------- |
| **LEFT JOIN**    | All rows from left table, matching rows from right table. |
| **RIGHT JOIN**   | All rows from right table, matching rows from left table. |
| **FULL JOIN**    | All rows from both tables.                                |
| **CROSS JOIN**   | Every row of Table A × Every row of Table B.              |
| **NATURAL JOIN** | Auto-matches common column names.                         |

---

END CHAPTER 10

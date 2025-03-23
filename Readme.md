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

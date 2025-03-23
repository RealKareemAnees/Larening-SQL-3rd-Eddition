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

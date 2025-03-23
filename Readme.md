# Summary of _Learning SQL_

**I have studies this book a year a go for a project, since that - unfortunately - I have never touched SQL since that, therefore im rereading the book and summarizing it because I need understanding of SQL for the upcomming stage**

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

# Chapter 3

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

WITH occ_count AS (
  SELECT
    Occupation,
    COUNT(*) AS Count
  FROM OCCUPATIONS
  GROUP BY 1
),
occ_report AS (
  SELECT
  CONCAT('There are a total of ', Count, ' ', LOWER(Occupation), 's.') AS col1
  ,ROW_NUMBER() OVER (ORDER BY Count, Occupation) AS order_table2
  FROM occ_count
),
sorted_people AS (
  SELECT
    CONCAT(Name, '(', LEFT(Occupation, 1),')') AS col1
    ,ROW_NUMBER() OVER (ORDER BY Name) AS order_table1
  FROM OCCUPATIONS
),
merged_table AS (
  SELECT col1, order_table1, 'table1' AS table_name
  FROM sorted_people
  UNION
  SELECT col1, order_table2, 'table2' AS table_name
  FROM occ_report
)
SELECT col1
FROM merged_table
ORDER BY table_name, order_table1;


/*
https://www.hackerrank.com/challenges/the-pads/problem

    Enter your query here and follow these instructions:
    1. Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
    2. The AS keyword causes errors, so follow this convention: "Select t.Field From table1 t" instead of "select t.Field From table1 AS t"
    3. Type your code immediately after comment. Don't leave any blank line.

Sample output
  Ashely(P)
  Christeen(P)
  Jane(A)
  Jenny(D)
  Julia(A)
  Ketty(P)
  Maria(A)
  Meera(S)
  Priya(S)
  Samantha(D)
  There are a total of 2 doctors.
  There are a total of 2 singers.
  There are a total of 3 actors.
  There are a total of 3 professors.
*/

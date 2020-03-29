
WITH CTE (column1, column2, column3, DuplicateCount)
AS
(
  SELECT column1, column2, column3,
  ROW_NUMBER() OVER(PARTITION BY column1, column2,
       column3 ORDER BY column1) AS DuplicateCount
  FROM iTokencarga_130219
) SELECT * from CTE Where DuplicateCount > 1


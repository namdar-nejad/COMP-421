
WITH

     before (movid, avgrating) AS(
         SELECT R1.movid, AVG(R1.rating)
         FROM review R1
         WHERE R1.reviewdate < '2019-01-01'
         GROUP BY R1.movid
         HAVING AVG(R1.rating) >= 7),

     after (movid, avgrating) AS(
        SELECT R1.movid, AVG(R1.rating)
        FROM review R1
        WHERE R1.reviewdate >= '2019-01-01'
        GROUP BY R1.movid
        HAVING AVG(R1.rating) <= 5)

SELECT  DISTINCT (
           SELECT M1.title
           FROM movies M1
           WHERE M1.movid = v1.movid) AS title,
       (
           SELECT M1.releasedate
           FROM movies M1
           WHERE M1.movid = v1.movid) AS date
FROM before v1 LEFT OUTER JOIN after v2
                               ON v1.movid = v2.movid
ORDER BY date, title
;
SELECT DISTINCT M.title, M.releasedate
FROM movies M
WHERE (EXISTS(
      SELECT R1.movid
      FROM review R1
      WHERE R1.movid = M.movid
      GROUP BY R1.movid HAVING COUNT(R1.rating) < 2
    )
  OR M.movid NOT IN (
  SELECT DISTINCT R1.movid
  FROM review R1
))
ORDER BY M.releasedate, M.title
;


SELECT DISTINCT M.title, M.releasedate,
       CASE
           WHEN NOT EXISTS (
                   SELECT *
                   FROM review RL2
                   WHERE RL2.movid = M.movid
               ) THEN 0

           ELSE (
               SELECT count(RL2.rating)
               FROM review RL2
               WHERE RL2.movid = M.movid
           )

           END AS "numreviews"

FROM movies M
WHERE M.releasedate <= '2021-12-29'
  AND M.releasedate >= '2021-01-01'
ORDER BY numreviews DESC , M.releasedate, M.title
;

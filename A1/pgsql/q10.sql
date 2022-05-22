SELECT DISTINCT M.title, M.releasedate
FROM movies M, releaselanguages RL1, releaselanguages RL2
WHERE M.movid = RL1.movid
  AND RL1.movid = RL2.movid
  AND RL1.language = 'English'
  AND RL2.language = 'French'
  AND EXISTS(
        SELECT R1.movid
        FROM review R1
        WHERE R1.movid = M.movid
        GROUP BY R1.movid HAVING COUNT(R1.rating) >= 5
    )
ORDER BY M.releasedate, M.title
;

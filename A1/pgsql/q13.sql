SELECT DISTINCT M.title, M.releasedate
FROM movies M, review RL1
WHERE M.movid = RL1.movid
  AND (
      SELECT count(RL2.rating)
      FROM review RL2
      WHERE RL2.movid = M.movid
      GROUP BY RL2.movid
      )
          >= ALL
      (
      SELECT count(RL1.rating)
      FROM review RL1
      GROUP BY RL1.movid
      )
ORDER BY M.releasedate, M.title
;
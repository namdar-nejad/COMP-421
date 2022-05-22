SELECT DISTINCT M.title,
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
WHERE M.releasedate
    >= ALL
      (
          SELECT M2.releasedate
          FROM movies M2
      )

ORDER BY M.title
;

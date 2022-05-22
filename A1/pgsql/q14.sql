SELECT DISTINCT M.title, M.releasedate, (
    SELECT AVG(RL.rating)
    FROM review RL
    WHERE RL.movid = M.movid
    GROUP BY RL.movid
    ) as "avgrating"

FROM movies M

WHERE
    (
    SELECT count(RL2.rating)
    FROM review RL2
    WHERE RL2.movid = M.movid
    GROUP BY RL2.movid ) >= 2
ORDER BY avgrating DESC, M.releasedate, M.title
;
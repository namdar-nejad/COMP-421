SELECT DISTINCT R1.userid
FROM movies M1, movies M2, review R1, review R2
Where M1.title = M2.title AND M1.title = 'Ben-Hur'
  AND M1.releasedate < '1960-01-01' AND M1.releasedate > '1959-01-01'
  AND M2.releasedate < '2017-01-01' AND M2.releasedate > '2016-01-01'
  AND R1.movid = M1.movid AND R1.userid = R2.userid
  AND R1.rating >= 7
  AND (
        (R2.rating <= 4 AND R2.movid = M2.movid) OR
        NOT EXISTS(
                SELECT *
                FROM review R3
                WHERE R2.userid = R3.userid
                  AND R3.movid = M2.movid
            )
    )
ORDER BY R1.userid;
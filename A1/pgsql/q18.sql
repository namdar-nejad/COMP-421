
WITH genere_avg (genre, avg) AS (
         SELECT G1.genre, (AVG(R1.rating)) AS avg
         FROM users U1, review R1, moviegenres G1
         WHERE U1.email = 'cinebuff@movieinfo.com'
         AND R1.userid = U1.userid
         AND G1.movid = R1.movid
         GROUP BY G1.genre
         ORDER BY avg DESC
     )

SELECT DISTINCT A.genre
FROM genere_avg A
WHERE A.avg >= ALL (SELECT A2.avg from genere_avg A2)
ORDER BY A.genre
;
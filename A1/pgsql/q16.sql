
WITH AVG1 (rating) AS (
    SELECT AVG(R.rating)
    FROM users U, review R, moviegenres G
    WHERE U.userid = R.userid
      AND G.movid = R.movid
      AND G.genre = 'Comedy'
      AND U.email = 'cinebuff@movieinfo.com'
    GROUP BY G.genre
)
SELECT DISTINCT M.title, M.releasedate, AVG(R.rating) as avg
FROM movies M, review R, moviegenres G
WHERE G.movid = M.movid
  AND G.genre = 'Comedy'
  AND R.movid = M.movid
  AND NOT EXISTS(
        SELECT U.userid
        FROM users U
        WHERE U.userid = R.userid
          AND U.email = 'cinebuff@movieinfo.com'
    )
GROUP BY M.title, M.releasedate
HAVING AVG(R.rating) >= ALL (SELECT * FROM AVG1)
ORDER BY avg DESC , M.releasedate, M.title
;


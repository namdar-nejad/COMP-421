SELECT COUNT(DISTINCT M.movid) AS "nummovies"
FROM movies M, moviegenres G
WHERE M.movid = G.movid
  AND '2021-01-01' <=  M.releasedate
  AND M.releasedate <= '2021-12-29'
  AND G.genre = 'Comedy';
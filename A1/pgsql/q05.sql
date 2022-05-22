SELECT DISTINCT M.title, M.releasedate
FROM movies M, moviegenres G1, moviegenres G2
WHERE '2021-01-01' <=  M.releasedate
  AND M.releasedate <= '2021-12-29'
  AND M.movid = G1.movid
  AND M.movid = G2.movid
  AND G1.genre = 'Sci-Fi'
  AND G2.genre = 'Comedy'
ORDER BY M.releasedate ,  M.title ;
SELECT DISTINCT R.userid
FROM review R, movies M
WHERE R.movid = M.movid
  AND M.title = 'Casablanca'
ORDER BY R.userid;

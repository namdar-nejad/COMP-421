SELECT DISTINCT M.title, M.releasedate, R.rating
FROM users U, review R, movies M
WHERE U.email = 'talkiesdude@movieinfo.com'
  AND R.userid = U.userid
  AND M.movid = R.movid
ORDER BY R.rating DESC, M.releasedate ASC, M.title ASC;

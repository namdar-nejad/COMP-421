SELECT DISTINCT U2.email
FROM users U1, users U2, movies M1, review R1, review R2
WHERE U1.email = 'cinebuff@movieinfo.com'
  AND R1.userid = U1.userid
  AND R2.userid = U2.userid
  AND R1.movid = R2.movid
  AND M1.movid = R1.movid
  AND R2.rating <= R1.rating + 1
  AND R2.rating >=  R1.rating - 1
  AND NOT U1.userid = U2.userid
ORDER BY u2.email;
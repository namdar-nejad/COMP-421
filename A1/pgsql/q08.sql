SELECT DISTINCT U.uname, U.email
FROM users U, review R,movies M, releaselanguages RL
WHERE U.userid = R.userid
  AND R.movid = M.movid
  AND M.movid = RL.movid
  AND RL.language = 'French'
  AND NOT EXISTS(
      SELECT *
      FROM releaselanguages RL1
      WHERE RL1.movid = M.movid
        AND NOT RL1.language = 'French'
    )
ORDER BY U.email;
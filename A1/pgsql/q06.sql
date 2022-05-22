SELECT DISTINCT M.title, M.releasedate
FROM movies M, releaselanguages R1
WHERE M.movid = R1.movid
    AND R1.language = 'French'
    AND 'English' NOT IN (
        SELECT DISTINCT R2.language
        FROM releaselanguages R2
        WHERE M.movid = R2.movid
    )
ORDER BY M.releasedate ,  M.title;
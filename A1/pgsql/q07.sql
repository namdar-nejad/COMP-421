SELECT DISTINCT M.title, M.releasedate,
CASE
    WHEN
    (
        'French' IN (
            SELECT R1.language FROM releaselanguages R1
            WHERE R1.movid = M.movid
        ) AND
        'Italian' IN (
            SELECT R1.language FROM releaselanguages R1
            WHERE R1.movid = M.movid
        )
    ) THEN 'French,Italian'
    ELSE R.language
END AS "languages"

FROM movies M, releaselanguages R
WHERE M.movid = R.movid AND (R.language = 'French' OR R.language = 'Italian')
ORDER BY M.releasedate, M.title
;
WITH langgenres (lan, genre, count) AS (
    SELECT R.language, G.genre, COUNT(*)
    FROM releaselanguages R, moviegenres G
    WHERE R.movid = G.movid
    GROUP BY R.language, G.genre
    ORDER BY R.language, G.genre)
SELECT DISTINCT L1.lan, L1.genre
FROM langgenres L1
WHERE L1.count >= ALL (SELECT L2.count
                       FROM langgenres L2
                       WHERE L2.lan = L1.lan)
ORDER BY L1.lan, L1.genre
;


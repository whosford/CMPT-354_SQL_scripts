--Query a
SELECT A.name, COUNT(A.name) AS NumberOfMovies
FROM dbo.ActedIn A
GROUP BY A.name
ORDER BY NumberOfMovies DESC

--Query b
SELECT A.name, COUNT(A.name) AS NumberOfMovies
FROM dbo.ActedIn A
GROUP BY A.name
HAVING COUNT(A.name) > 1
ORDER BY NumberOfMovies DESC

--Query c
SELECT A.name, COUNT(A.name) AS MaxNumberOfMovies
FROM dbo.ActedIn A
GROUP BY A.name
HAVING COUNT(A.name)  = 
	(SELECT MAX(C.CNT) 
     FROM (SELECT COUNT(B.name) AS CNT 
		   FROM dbo.ActedIn B
		   GROUP BY B.name) AS C)

--Query d
SELECT DISTINCT M.title
FROM dbo.Movie M
	INNER JOIN dbo.Keywords K
	ON M.title = K.title
	WHERE M.genre = 'Action' 
		AND K.keyword LIKE '%war%'
		AND NOT K.keyword LIKE '%star%'
EXCEPT
SELECT DISTINCT M.title
FROM dbo.Movie M
	INNER JOIN dbo.Keywords K
	ON M.title = K.title
	WHERE K.keyword LIKE '%star%'

--Query e
SELECT S.songID, S.rank
FROM dbo.Soundtrack S
	INNER JOIN dbo.Keywords K
	ON S.title = K.title
	WHERE K.keyword = 'computer'
		OR K.keyword = 'computer-animation'
ORDER BY S.rank DESC


--Query f
SELECT T.fname, T.lname
FROM dbo.TechStaff T, dbo.Actors A
WHERE T.fname = A.fname AND T.lname = A.lname


--Query g
SELECT S.studioName,  ROUND(AVG(A.salary), 2) AS AverageActorSalary, ROUND(AVG(T.salary), 2) AS AverageTechSalary
FROM dbo.Studio S, dbo.TechStaff T, dbo.Actors A, dbo.Movie M, dbo.ActedIn AI 
WHERE S.studioID = T.studioID AND S.studioID = M.studioID AND M.title = AI.title AND AI.name = A.name
GROUP BY S.studioName

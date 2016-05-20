--Task a
ALTER TABLE dbo.TechStaff
ADD CONSTRAINT age_constraint CHECK (age > 9 AND age < 126)
GO
ALTER TABLE dbo.Soundtrack
ADD CONSTRAINT song_constraint CHECK ([duration(sec)] > 0)
GO

--Task b
ALTER TABLE dbo.Actors
ADD fname varchar(255)
GO
ALTER TABLE dbo.Actors
ADD lname varchar(255)
GO
UPDATE dbo.Actors
SET 
	fname = (CASE WHEN 0 = CHARINDEX(',', name) THEN name 
		ELSE LTRIM(SUBSTRING(name, CHARINDEX(',', name) + 1, LEN(name))) END),
	lname = (CASE WHEN 0 = CHARINDEX(',', name) THEN ''
		ELSE SUBSTRING(name, 1, CHARINDEX(',', name) - 1) END)
GO

--Task c
UPDATE S
SET
	S.employees = T2.TotalEmployees
FROM dbo.Studio S
INNER JOIN (SELECT studioID,
			SUM(CASE WHEN T.studioID = studioID THEN 1 ELSE 0 END) AS TotalEmployees
			FROM dbo.TechStaff T
			GROUP BY studioID) as T2
ON T2.studioID = S.studioID
GO

--Task d
CREATE TRIGGER Employee_Trigger
ON dbo.TechStaff
AFTER INSERT, DELETE
AS
IF EXISTS (Select * FROM inserted) AND NOT EXISTS (Select * FROM deleted)
BEGIN
	UPDATE dbo.Studio
		SET employees += 1
		FROM dbo.Studio S, inserted i
		WHERE S.studioID = i.studioID 
END
IF EXISTS (Select * FROM deleted) AND NOT EXISTS (Select * FROM inserted)
BEGIN
	UPDATE dbo.Studio
		SET employees -= 1
		FROM dbo.Studio S, deleted d
		WHERE S.studioID = d.studioID
END
GO

--Task e
CREATE TRIGGER Studio_Trigger
ON dbo.Studio
AFTER DELETE
AS
IF (NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' AND  TABLE_NAME = 'FoldedStudios'))
	BEGIN
		CREATE TABLE FoldedStudios
		(
			studioName varchar(50),	
			fired int
		)
		INSERT INTO FoldedStudios
		SELECT d.studioName, d.employees FROM deleted d 
	END
ELSE
	BEGIN
		INSERT INTO FoldedStudios
		SELECT d.studioName, d.employees FROM deleted d 
	END
GO

--Task f
CREATE PROC spSearchString 	@st	varchar(20) 
AS
	SET @st += '%'
	SELECT *
	FROM dbo.Keywords k
	WHERE k.keyword LIKE @st
GO	

CREATE TABLE Actors
(
	name varchar(255) PRIMARY KEY,
	salary money
);

CREATE TABLE Studio
(
	studioID int PRIMARY KEY,
	studioName varchar(50) NOT NULL,
	employees int,
	budget money,
	est int
);

CREATE TABLE Movie
(
	title varchar(255) PRIMARY KEY,
	year int,
	genre varchar(50),
	studioID int,
	CONSTRAINT FK_Movie_studioID
		FOREIGN KEY (studioID)
		REFERENCES dbo.Studio (studioID)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);

CREATE TABLE TechStaff
(
	sin int PRIMARY KEY,
	fname varchar(255),
	lname varchar(255) NOT NULL,
	age int,
	salary money,
	studioID int,
	CONSTRAINT FK_TechStaff_studioID
		FOREIGN KEY (studioID)
		REFERENCES dbo.Studio (studioID)
		ON DELETE SET NULL
		ON UPDATE CASCADE
);

CREATE TABLE ActedIn
(
	name varchar(255) NOT NULL,
	title varchar(255) NOT NULL,
	CONSTRAINT PK_ActedIn
		PRIMARY KEY NONCLUSTERED (name,title),
	CONSTRAINT FK_ActedIn_name
		FOREIGN KEY (name)
		REFERENCES dbo.Actors (name)
		ON DELETE CASCADE,
	CONSTRAINT FK_ActedIn_title
		FOREIGN KEY (title)
		REFERENCES dbo.Movie (title)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Soundtrack
(
	songID varchar(10) PRIMARY KEY,
	[duration(sec)] int,
	rank real,
	title varchar(255),
	CONSTRAINT FK_Sountrack_title
		FOREIGN KEY (title)
		REFERENCES dbo.Movie (title)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

CREATE TABLE Keywords
(
	title varchar(255) PRIMARY KEY,
	keyword varchar(50),
	CONSTRAINT FK_Keywords_title
		FOREIGN KEY (title)
		REFERENCES dbo.Movie (title)
		ON DELETE CASCADE
		ON UPDATE CASCADE
);

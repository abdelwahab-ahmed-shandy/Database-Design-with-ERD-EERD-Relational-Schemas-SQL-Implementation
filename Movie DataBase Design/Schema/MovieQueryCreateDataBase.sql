Create DataBase Movie_DataBase;

use Movie_DataBase;

Create Table Actors (
	ActorID INT IDENTITY(1,1) Primary Key ,
	ActorFirstName char(20) Not Null ,
	ActorLastName char(20) Not Null ,
	ActorGender char(1) Not Null
);

Create Table Directors(
	DirectorID INT IDENTITY(1,1) Primary Key ,
	DirectorFirstName char(20) Not Null ,
	DirectorLastName char(20) Not Null 
);

Create Table Movies(
	MovieID INT IDENTITY(1,1) Primary Key ,
	MovieTitle char(50) not null ,
	MovieYear int not null ,
	MovieTime int not null ,
	MovieLang char(50) not null ,
	MovieDateTimeRel datetime2 not null ,
	MovieRelCountry char(5) not null 
);

Create Table Movie_Cast (
	Role char(30) not null ,
	ActorID Int References Actors(ActorID) Not Null,
	MovieID Int References Movies(MovieID) Not Null
);

Create Table Movie_Direction(
	DirectorID Int References Directors(DirectorID) Not Null,
	MovieID Int References Movies(MovieID) Not Null
);

Create Table Reviewers(
	ReviewerID Int Identity(1,1) Primary Key ,
	ReviewerName char(30) Not Null 
);

Create Table Rating(
	RatingState int Not Null ,
	NumberOfRating int Not Null ,
	MovieID Int References Movies(MovieID) Not Null ,
	ReviewerID Int References Reviewers(ReviewerID) Not Null 
);

Create Table Genres(
	GenreID Int Identity(1,1) Primary Key ,
	GenreTitle Char(20) Not null 
);

Create Table Movie_Genres(
	GenreID int References Genres(GenreID) not Null ,
	MovieID Int References Movies(MovieID) Not Null 
);
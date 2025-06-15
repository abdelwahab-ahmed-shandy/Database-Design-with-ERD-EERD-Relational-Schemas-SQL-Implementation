-- Script for creating Musicana Records Database
-- Author: Abdelwahab Shandy
-- Description: This script creates a database named MusicanaRecords_DB to manage music-related data, including instruments, musicians, albums, and songs.

Create Database MusicanaRecords_DB;

Use MusicanaRecords_DB ;

Create Table Instrument(
	InstrumentName nvarchar(200) Primary Key, 
	InstrumentKey int 
);

Create Table Musician(
	MusicianID int Primary Key ,
	Name nvarchar(150) ,
	Phone nvarchar(100),
	Street nvarchar(200),
	City nvarchar(100)
);

Create Table PlayInstrument(
	MusicianID int Foreign Key References Musician(MusicianID),
	NameInstrument nvarchar(200) Foreign Key References Instrument(InstrumentName)
);

Create Table Album(
	AlbumID int Primary Key ,
	Title nvarchar(150) ,
	Date datetime2 ,
	MusicianID int Foreign Key References Musician(MusicianID)
);

Create Table Song(
	Title nvarchar(255) primary key,
	Author nvarchar(100),
	AlbumID int Foreign Key References Album(AlbumID)
);

Create Table PlaySong(
	MusicianID int Foreign Key References Musician(MusicianID),
	Title nvarchar(255) Foreign Key References Song(Title)
);

BACKUP DATABASE MusicanaRecords_DB
TO DISK = 'E:\1- DB\DataBase Design\Musicana Records ERD Relational Schemas\MusicanaRecords_DB.bak';
/* Michael Zachary Loria															*/
/* TCSS 445 Spring 2019																*/
/* Databases Project																*/
/* Amusement Park Database															*/
/* The following code creates the database, the tables and fill tables with data.	*/

CREATE DATABASE Loria_Michael_db;
GO

USE Loria_Michael_db;
GO

CREATE TABLE PARKING_GARAGE
(
	ParkingGarageID	int			NOT NULL,
	Name			varchar(30)	NOT NULL,
	Capacity		int			NOT NULL,
	CONSTRAINT	PARKING_GARAGE_PK	PRIMARY KEY(ParkingGarageID) 
);

CREATE TABLE VEHICLE
(
	LicensePlateNumber	varchar(8)	NOT NULL,
	ParkingGarageID		int			NOT NULL,
	CONSTRAINT	VEHICLE_PK			PRIMARY KEY(LicensePlateNumber),
	CONSTRAINT	PARKING_GARAGE_FK	FOREIGN KEY (ParkingGarageID)
				REFERENCES PARKING_GARAGE(ParkingGarageID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE VISITOR
(
	VisitorID	int				IDENTITY(1,1)	NOT NULL,
	FirstName	varchar(30)		NOT NULL,
	LastName	varchar(20)		NOT NULL,
	Height		int				NOT NULL,
	Age			int				NOT NULL,
	LicensePlateNumber	varchar(8)	NULL,
	CONSTRAINT	VISITOR_PK			PRIMARY KEY (VisitorID),
	CONSTRAINT	LICENSE_PLATE_FK	FOREIGN KEY (LicensePlateNumber)
				REFERENCES VEHICLE(LicensePlateNUmber)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE TICKET_TYPE
(
	TicketTypeID	int				NOT NULL,
	TicketTypeName	varchar(10)		NOT NULL,
	Description		varchar(1000)	NULL,
	Price			decimal(9,2)	NOT NULL,
	MinimumAge		int				NULL,
	MaximumAge		int				NULL,
	CONSTRAINT		TICKET_TYPE_PK	PRIMARY	KEY (TicketTypeID)
);

CREATE TABLE TICKET
(
	TicketID		int		IDENTITY(3000,1) 	NOT NULL,
	DateIssued		date	NOT NULL,
	DateValid		date	NOT NULL,
	TicketTypeID	int		NOT NULL,
	VisitorID		int		NOT NULL,
	CONSTRAINT	TICKET_PK		PRIMARY	KEY (TicketID),
	CONSTRAINT	TICKET_TYPE_FK	FOREIGN KEY (TicketTypeID)
				REFERENCES TICKET_TYPE(TicketTypeID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
	CONSTRAINT	VISITOR_TICKET_FK		FOREIGN KEY (VisitorID)
				REFERENCES VISITOR(VisitorID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE RIDE_TYPE
(
	RideTypeID	int				NOT NULL,
	Name		varchar(20)		NOT NULL,
	Description	varchar(1000)	NOT NULL,
	CONSTRAINT	RIDE_TYPE_PK	PRIMARY KEY (RideTypeID)
);

CREATE TABLE RIDE
(
	RideID			int				NOT NULL,
	Name			varchar(20)		NOT NULL,
	Description		varchar(1000)	NOT NULL,
	MininmumHeight	int				NULL,
	Duration		int				NOT NULL,
	MaximumCapacity	int				NOT NULL,
	RideTypeID		int				NOT NULL,
	CONSTRAINT 	RIDE_PK				PRIMARY KEY (RideID),
	CONSTRAINT	RIDE_TYPE_FK		FOREIGN KEY (RideTypeID)
				REFERENCES RIDE_TYPE (RideTypeID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE RIDE_CYCLE
(
	RideCycleID		int		IDENTITY(1000,3)	NOT NULL,
	StartTime		time	NOT NULL,
	RideID			int		NOT NULL,
	CONSTRAINT	RIDE_CYCLE_PK		PRIMARY KEY (RideCycleID),
	CONSTRAINT	RIDE_FK				FOREIGN KEY (RideID)
				REFERENCES RIDE (RideID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE RIDES_ON
(
	VisitorID	int	NOT NULL,
	RideCycleID	int	NOT NULL,
	CONSTRAINT RIDES_ON_PK	PRIMARY KEY (VisitorID, RideCycleID),
	CONSTRAINT VISITOR_RIDES_ON_FK	FOREIGN KEY (VisitorID)
				REFERENCES VISITOR (VisitorID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
	CONSTRAINT RIDE_CYCLE_FK	FOREIGN KEY (RideCycleID)
				REFERENCES RIDE_CYCLE (RideCycleID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE SHOW
(
	ShowID		int				NOT NULL,
	Name		varchar(20)		NOT NULL,
	Description	varchar(1000)	NULL,
	Duration	int				NOT NULL,
	CONSTRAINT SHOW_PK		PRIMARY KEY (ShowID)
);

CREATE TABLE SHOWING
(
	ShowingID	int		IDENTITY(2000,3)	NOT NULL,
	StartTime	time	NOT NULL,
	ShowID		int		NOT NULL,
	CONSTRAINT	SHOWING_PK	PRIMARY KEY (ShowingID),
	CONSTRAINT	SHOW_FK		FOREIGN KEY (ShowID)
				REFERENCES SHOW (ShowID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION				
);

CREATE TABLE WATCHES
(
	VisitorID	int		NOT NULL,
	ShowingID	int		NOT NULL,
	CONSTRAINT	WATCHES_PK	PRIMARY KEY (VisitorID, ShowingID),
	CONSTRAINT VISITOR_WATCHES_FK	FOREIGN KEY (VisitorID)
				REFERENCES VISITOR (VisitorID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
	CONSTRAINT SHOWING_FK	FOREIGN KEY (ShowingID)
				REFERENCES SHOWING (ShowingID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION		
);

CREATE TABLE CONCESSION_STAND_TYPE
(
	ConcessionStandTypeID	int				NOT NULL,
	Name					varchar(20)		NOT NULL,
	Description				varchar(1000)	NULL,
	CONSTRAINT	CONCESSION_STAND_TYPE_PK	PRIMARY KEY (ConcessionStandTypeID),
);

CREATE TABLE CONCESSION_STAND
(
	ConcessionStandID		int			NOT NULL,
	Name					varchar(20)	NOT NULL,
	OpeningTime				time		NOT NULL,
	ClosingTime				time		NOT NULL,
	ConcessionStandTypeID	int			NOT NULL,
	CONSTRAINT	CONCESSION_STAND_PK		PRIMARY KEY (ConcessionStandID),
	CONSTRAINT	CONESSION_STAND_TYPE_FK	FOREIGN KEY (ConcessionStandTypeID)
				REFERENCES CONCESSION_STAND_TYPE (ConcessionStandTypeID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE FOOD_ORDER
(
	FoodOrderID			int		IDENTITY(4000,1)	NOT NULL,
	Date				date	NOT NULL,
	Time				time	NOT NULL,
	VisitorID			int		NOT NULL,
	ConcessionStandID	int		NOT NULL,
	CONSTRAINT	FOOD_ORDER_PK			PRIMARY KEY (FoodOrderID),
	CONSTRAINT	VISITOR_FOOD_ORDER_FK	FOREIGN KEY (VisitorID)
				REFERENCES VISITOR (VisitorID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
	CONSTRAINT	CONCESSION_STAND_FK	FOREIGN KEY (ConcessionStandID)
				REFERENCES CONCESSION_STAND (ConcessionStandID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE FOOD
(
	FoodID		int				NOT NULL,
	Name		varchar(20)		NOT NULL,
	Description	varchar(1000)	NULL,
	Price		Decimal(9,2)	NOT NULL,
	CONSTRAINT	FOOD_PK		PRIMARY KEY (FoodID)
);

CREATE TABLE FOOD_ORDER_ITEM
(
	FoodID		int		NOT NULL,
	FoodOrderID	int		NOT NULL,
	Quantity	int		NOT NULL,
	CONSTRAINT	FOOD_ORDER_ITEM_PK	PRIMARY KEY (FoodID, FoodOrderID),
	CONSTRAINT	FOOD_FK			FOREIGN KEY (FoodID)
				REFERENCES FOOD (FoodID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
	CONSTRAINT	FOOD_ORDER_FK	FOREIGN KEY (FoodOrderID)
				REFERENCES FOOD_ORDER (FoodOrderID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE SOUVENIR_SHOP
(
	SouvenirShopID	int				NOT NULL,
	Name			varchar(20)		NOT NULL,
	Description		varchar(1000)	NULL,
	OpeningTime		time			NOT NULL,
	ClosingTime		time			NOT NULL,
	CONSTRAINT	SOUVENIR_SHOP_PK	PRIMARY KEY (SouvenirShopID)
);

CREATE TABLE SOUVENIR_ORDER
(
	SouvenirOrderID	int				IDENTITY(5000,1)	NOT NULL,
	Date			date			NOT NULL,
	Time			time			NOT NULL,
	VisitorID		int				NOT NULL,
	SouvenirShopID	int				NOT NULL,
	CONSTRAINT	SOUVENIR_ORDER_PK		PRIMARY KEY (SouvenirOrderID),
	CONSTRAINT	VISITOR_SOUVENIR_ORDER_FK	FOREIGN KEY (VisitorID)
				REFERENCES VISITOR (VisitorID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
	CONSTRAINT	SOUVENIR_SHOP_FK	FOREIGN KEY (SouvenirShopID)
				REFERENCES SOUVENIR_SHOP (SouvenirShopID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

CREATE TABLE SOUVENIR
(
	SouvenirID	int				NOT NULL,
	Name		varchar(20)		NOT NULL,
	Description	varchar(1000)	NULL,
	Price		Decimal(9,2)	NOT NULL,
	CONSTRAINT	SOUVENIR_PK		PRIMARY KEY (SouvenirID)
);

CREATE TABLE SOUVENIR_ORDER_ITEM
(
	SouvenirOrderID		int		NOT NULL,
	SouvenirID			int		NOT NULL,
	Quantity			int		NOT NULL,
	CONSTRAINT	SOUVENIR_ORDER_ITEM_PK	PRIMARY KEY (SouvenirOrderID, SouvenirID),
	CONSTRAINT	SOUVENIR_FK			FOREIGN KEY (SouvenirID)
				REFERENCES SOUVENIR (SouvenirID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION,
	CONSTRAINT	SOUVENIR_ORDER_FK	FOREIGN KEY (SouvenirOrderID)
				REFERENCES SOUVENIR_ORDER (SouvenirOrderID)
					ON UPDATE NO ACTION
					ON DELETE NO ACTION
);

INSERT INTO PARKING_GARAGE VALUES (1, 'West Coast', 555);
INSERT INTO PARKING_GARAGE VALUES (2, 'East Side', 300);
INSERT INTO PARKING_GARAGE VALUES (3, 'North Pole', 950);
INSERT INTO PARKING_GARAGE VALUES (4, 'South Bay', 100);

INSERT INTO VEHICLE VALUES ('HELLO',1);
INSERT INTO VEHICLE VALUES ('ABC-123',1);
INSERT INTO VEHICLE VALUES ('SDF-341',1);
INSERT INTO VEHICLE VALUES ('CSFZ1SF',1);
INSERT INTO VEHICLE VALUES ('UOU-345',1);
INSERT INTO VEHICLE VALUES ('WSKP234',1);
INSERT INTO VEHICLE VALUES ('QW23IUP',2);
INSERT INTO VEHICLE VALUES ('WINNER',2);
INSERT INTO VEHICLE VALUES ('12UPRRK',2);
INSERT INTO VEHICLE VALUES ('JBC5672',2);
INSERT INTO VEHICLE VALUES ('KJWRG34',3);
INSERT INTO VEHICLE VALUES ('CZC-545',3);
INSERT INTO VEHICLE VALUES ('WRK2352',4);
INSERT INTO VEHICLE VALUES ('FSKL233',1);
INSERT INTO VEHICLE VALUES ('QWERTY1',2);
INSERT INTO VEHICLE VALUES ('PERR123',1);
INSERT INTO VEHICLE VALUES ('ERT3409',1);
INSERT INTO VEHICLE VALUES ('VERT563',4);
INSERT INTO VEHICLE VALUES ('W8RVF91',1);
INSERT INTO VEHICLE VALUES ('F2VBW78',4);

INSERT INTO VISITOR VALUES ('Mike','Johnson',64,30,'HELLO');
INSERT INTO VISITOR VALUES ('Jerry','Welch',65,28,'ABC-123');
INSERT INTO VISITOR VALUES ('Rebecca', 'Demming', 60,22,'SDF-341');
INSERT INTO VISITOR VALUES ('Jenae','Rodda',62, 20,'CSFZ1SF');
INSERT INTO VISITOR VALUES ('Corry','Cleary',70,35, 'UOU-345');
INSERT INTO VISITOR VALUES ('Ben', 'Cleary', 48,6,'UOU-345');
INSERT INTO VISITOR VALUES ('Alice', 'Cleary', 56,6,'UOU-345');
INSERT INTO VISITOR VALUES ('Trudy', 'Williams', 58,75,'WSKP234');
INSERT INTO VISITOR VALUES ('Gary', 'Williams', 65,79,'WSKP234');
INSERT INTO VISITOR VALUES ('Brandon', 'Felts', 65,88, null);
INSERT INTO VISITOR VALUES ('Macy', 'Felts', 60,88, null);
INSERT INTO VISITOR VALUES ('Robert','Le',67,40,'WINNER');
INSERT INTO VISITOR VALUES ('Reggie','Le',48,5,'WINNER');
INSERT INTO VISITOR VALUES ('Tabitha','Le',43,4,'WINNER');
INSERT INTO VISITOR VALUES ('Ruth','Le',63,40,'WINNER');
INSERT INTO VISITOR VALUES ('Stephen', 'Curry', 74, 35, '12UPRRK');
INSERT INTO VISITOR VALUES ('Jackson', 'Knight', 70, 23, 'JBC5672');
INSERT INTO VISITOR VALUES ('Russell', 'Wilson', 76, 29, 'KJWRG34');
INSERT INTO VISITOR VALUES ('Pete', 'Carroll', 68, 70, 'CZC-545');
INSERT INTO VISITOR VALUES ('KJ', 'Wright', 78, 33, 'WRK2352');
INSERT INTO VISITOR VALUES ('Ichiro', 'Suzuki', 70, 40, 'FSKL233');
INSERT INTO VISITOR VALUES ('Denny', 'Williams', 60, 40, 'QWERTY1');
INSERT INTO VISITOR VALUES ('Lorenzo', 'Ball', 75, 25, 'PERR123');
INSERT INTO VISITOR VALUES ('Lebron', 'James', 80, 34, 'ERT3409');
INSERT INTO VISITOR VALUES ('Robert', 'Downey', 68, 45, 'VERT563');
INSERT INTO VISITOR VALUES ('Derek', 'Jacobs', 60, 16, 'W8RVF91');
INSERT INTO VISITOR VALUES ('Mary', 'Jacobs', 58, 14, 'W8RVF91');
INSERT INTO VISITOR VALUES ('Martha', 'Jacobs', 54, 12, 'W8RVF91');
INSERT INTO VISITOR VALUES ('Candace', 'Jacobs', 50, 10, 'W8RVF91');
INSERT INTO VISITOR VALUES ('Randy', 'McKnight', 75, 20, 'F2VBW78');
INSERT INTO VISITOR VALUES ('Russell', 'McKnight', 76, 22, 'F2VBW78');
INSERT INTO VISITOR VALUES ('Kyle', 'McKnight', 72, 18, 'F2VBW78');
INSERT INTO VISITOR VALUES ('Chris', 'McKnight', 60, 12, 'F2VBW78');
INSERT INTO VISITOR VALUES ('Tom', 'Fields', 65, 77, null);
INSERT INTO VISITOR VALUES ('Kris', 'Fields', 58, 74, null);
INSERT INTO VISITOR VALUES ('Leona', 'Shelby', 60, 12, null);
INSERT INTO VISITOR VALUES ('Benny', 'Fugate', 58, 11, null);

INSERT INTO TICKET_TYPE VALUES (1, 'Adult', 'This ticket admits one adult into the amusement park.', 109.99, 18, 64)
INSERT INTO TICKET_TYPE VALUES (2, 'Kid', 'This ticket admits one kid into the amusement park.', 99.99, 0, 17)
INSERT INTO TICKET_TYPE VALUES (3, 'Senior', 'This ticket admits one senior citizen into the amusement park.', 89.99, 65, null)

INSERT INTO TICKET VALUES ('May 1, 2019','May 2, 2019',1,1)
INSERT INTO TICKET VALUES ('May 1, 2019','May 3, 2019',1,1)
INSERT INTO TICKET VALUES ('May 1, 2019','May 4, 2019',1,1)
INSERT INTO TICKET VALUES ('May 1, 2019','May 5, 2019',1,1)
INSERT INTO TICKET VALUES ('May 2, 2019','May 2, 2019',1,2)
INSERT INTO TICKET VALUES ('May 2, 2019','May 2, 2019',1,3)
INSERT INTO TICKET VALUES ('May 2, 2019','May 2, 2019',1,4)
INSERT INTO TICKET VALUES ('May 2, 2019','May 2, 2019',1,5)
INSERT INTO TICKET VALUES ('May 2, 2019','May 2, 2019',2,6)
INSERT INTO TICKET VALUES ('May 2, 2019','May 3, 2019',2,6)
INSERT INTO TICKET VALUES ('May 2, 2019','May 4, 2019',2,6)
INSERT INTO TICKET VALUES ('May 2, 2019','May 2, 2019',2,7)
INSERT INTO TICKET VALUES ('May 2, 2019','May 3, 2019',2,7)
INSERT INTO TICKET VALUES ('May 2, 2019','May 4, 2019',2,7)
INSERT INTO TICKET VALUES ('May 2, 2019','May 16, 2019',3,8)
INSERT INTO TICKET VALUES ('May 2, 2019','May 17, 2019',3,8)
INSERT INTO TICKET VALUES ('May 2, 2019','May 16, 2019',3,9)
INSERT INTO TICKET VALUES ('May 2, 2019','May 17, 2019',3,9)
INSERT INTO TICKET VALUES ('May 2, 2019','May 22, 2019',3,10)
INSERT INTO TICKET VALUES ('May 2, 2019','May 22, 2019',3,11)
INSERT INTO TICKET VALUES ('May 3, 2019','May 5, 2019',1,12)
INSERT INTO TICKET VALUES ('May 3, 2019','May 5, 2019',2,13)
INSERT INTO TICKET VALUES ('May 3, 2019','May 5, 2019',2,14)
INSERT INTO TICKET VALUES ('May 3, 2019','May 5, 2019',1,15)
INSERT INTO TICKET VALUES ('May 3, 2019','May 6, 2019',1,12)
INSERT INTO TICKET VALUES ('May 3, 2019','May 6, 2019',2,13)
INSERT INTO TICKET VALUES ('May 3, 2019','May 6, 2019',2,14)
INSERT INTO TICKET VALUES ('May 3, 2019','May 6, 2019',1,15)
INSERT INTO TICKET VALUES ('May 4, 2019','May 19, 2019',1,16)
INSERT INTO TICKET VALUES ('May 4, 2019','May 20, 2019',1,16)
INSERT INTO TICKET VALUES ('May 4, 2019','May 4, 2019',1,17)
INSERT INTO TICKET VALUES ('May 4, 2019','May 4, 2019',1,18)
INSERT INTO TICKET VALUES ('May 5, 2019','May 7, 2019',3,19)
INSERT INTO TICKET VALUES ('May 6, 2019','July 1, 2019',1,20)
INSERT INTO TICKET VALUES ('May 6, 2019','July 20, 2019',1,21)
INSERT INTO TICKET VALUES ('May 6, 2019','May 6, 2019',1,22)
INSERT INTO TICKET VALUES ('May 7, 2019','June 9, 2019',1,23)
INSERT INTO TICKET VALUES ('May 7, 2019','May 7, 2019',1,24)
INSERT INTO TICKET VALUES ('May 7, 2019','May 8, 2019',1,25)
INSERT INTO TICKET VALUES ('May 7, 2019','June 30, 2019',2,26)
INSERT INTO TICKET VALUES ('May 7, 2019','July 1, 2019',2,26)
INSERT INTO TICKET VALUES ('May 7, 2019','June 30, 2019',2,27)
INSERT INTO TICKET VALUES ('May 7, 2019','July 1, 2019',2,27)
INSERT INTO TICKET VALUES ('May 7, 2019','June 30, 2019',2,28)
INSERT INTO TICKET VALUES ('May 7, 2019','July 1, 2019',2,28)
INSERT INTO TICKET VALUES ('May 7, 2019','June 30, 2019',2,29)
INSERT INTO TICKET VALUES ('May 7, 2019','July 1, 2019',2,29)
INSERT INTO TICKET VALUES ('May 10, 2019','May 10, 2019',1,30)
INSERT INTO TICKET VALUES ('May 10, 2019','May 10, 2019',1,31)
INSERT INTO TICKET VALUES ('May 10, 2019','May 10, 2019',1,32)
INSERT INTO TICKET VALUES ('May 10, 2019','May 10, 2019',2,33)
INSERT INTO TICKET VALUES ('May 10, 2019','May 11, 2019',1,30)
INSERT INTO TICKET VALUES ('May 10, 2019','May 11, 2019',1,31)
INSERT INTO TICKET VALUES ('May 10, 2019','May 11, 2019',1,32)
INSERT INTO TICKET VALUES ('May 10, 2019','May 11, 2019',2,33)
INSERT INTO TICKET VALUES ('May 11, 2019','May 30, 2019',3,34)
INSERT INTO TICKET VALUES ('May 11, 2019','May 30, 2019',3,35)
INSERT INTO TICKET VALUES ('May 11, 2019','May 11, 2019',2,36)
INSERT INTO TICKET VALUES ('May 11, 2019','May 11, 2019',2,37)

INSERT INTO RIDE_TYPE VALUES (1, 'Scary', 'These rides are scary!')
INSERT INTO RIDE_TYPE VALUES (2, 'Wet', 'Make sure to bring a towel for these rides!')
INSERT INTO RIDE_TYPE VALUES (3, 'Calm', 'Sit back and relax on these rides!')
INSERT INTO RIDE_TYPE VALUES (4, 'Thrill', 'Get ready for a thrilling and exciting ride!')
INSERT INTO RIDE_TYPE VALUES (5, 'Kids', 'These rides are perfect for little kids!')
INSERT INTO RIDE_TYPE VALUES (6, 'Horror', 'Be ready to scream in these rides!')
INSERT INTO RIDE_TYPE VALUES (7, 'Slow', 'Take it easy with these slow rides.')
INSERT INTO RIDE_TYPE VALUES (8, 'Fast', 'Hold on!')
INSERT INTO RIDE_TYPE VALUES (9, 'Bright', 'Bright lights!')
INSERT INTO RIDE_TYPE VALUES (10, 'Dark', 'It may get hard to see in these rides.')

INSERT INTO RIDE VALUES (1, 'Mountain Railroad', 'A hilly rollercoaster.', 50, 5, 40, 4)
INSERT INTO RIDE VALUES (2, 'Teacup', 'Spin around!', null, 6, 20, 5)
INSERT INTO RIDE VALUES (3, 'Space Coaster', 'A coaster in outerspace!', 50, 5, 30, 4)
INSERT INTO RIDE VALUES (4, 'House of Terror', 'A house full of mysteries.', null, 10, 40, 6)
INSERT INTO RIDE VALUES (5, 'Boat', 'A boat ride around the park.', null, 20, 100, 7)
INSERT INTO RIDE VALUES (6, 'Laser Lights', 'A laser-filled ride.', 50, 5, 30, 9)
INSERT INTO RIDE VALUES (7, 'Night Sky', 'A dark tour in the night sky.', null, 10, 10, 10)
INSERT INTO RIDE VALUES (8, 'Rapid Waters', 'Water filled thrills.', 50, 7, 10, 2)
INSERT INTO RIDE VALUES (9, 'World Tour', 'Take a tour around the world.', null, 10, 20, 3)
INSERT INTO RIDE VALUES (10, 'Speed', 'The fastest rollercoaster around.', 50, 5, 30, 8)

INSERT INTO RIDE_CYCLE VALUES ('10:00', 1)
INSERT INTO RIDE_CYCLE VALUES ('18:00', 1)
INSERT INTO RIDE_CYCLE VALUES ('19:00', 1)
INSERT INTO RIDE_CYCLE VALUES ('20:00', 1)
INSERT INTO RIDE_CYCLE VALUES ('10:19', 2)
INSERT INTO RIDE_CYCLE VALUES ('11:19', 2)
INSERT INTO RIDE_CYCLE VALUES ('15:19', 2)
INSERT INTO RIDE_CYCLE VALUES ('18:25', 3)
INSERT INTO RIDE_CYCLE VALUES ('19:25', 3)
INSERT INTO RIDE_CYCLE VALUES ('20:25', 3)
INSERT INTO RIDE_CYCLE VALUES ('10:45', 4)
INSERT INTO RIDE_CYCLE VALUES ('11:45', 4)
INSERT INTO RIDE_CYCLE VALUES ('12:45', 4)
INSERT INTO RIDE_CYCLE VALUES ('18:35', 5)
INSERT INTO RIDE_CYCLE VALUES ('19:35', 5)
INSERT INTO RIDE_CYCLE VALUES ('20:35', 5)
INSERT INTO RIDE_CYCLE VALUES ('10:50', 6)
INSERT INTO RIDE_CYCLE VALUES ('16:50', 6)
INSERT INTO RIDE_CYCLE VALUES ('18:50', 6)
INSERT INTO RIDE_CYCLE VALUES ('10:30', 7)
INSERT INTO RIDE_CYCLE VALUES ('11:30', 7)
INSERT INTO RIDE_CYCLE VALUES ('17:30', 7)
INSERT INTO RIDE_CYCLE VALUES ('18:45', 8)
INSERT INTO RIDE_CYCLE VALUES ('19:45', 8)
INSERT INTO RIDE_CYCLE VALUES ('20:45', 8)
INSERT INTO RIDE_CYCLE VALUES ('10:15', 9)
INSERT INTO RIDE_CYCLE VALUES ('11:15', 9)
INSERT INTO RIDE_CYCLE VALUES ('16:15', 9)
INSERT INTO RIDE_CYCLE VALUES ('14:20', 10)
INSERT INTO RIDE_CYCLE VALUES ('15:20', 10)
INSERT INTO RIDE_CYCLE VALUES ('16:20', 10)

INSERT INTO RIDES_ON VALUES (1,1000)
INSERT INTO RIDES_ON VALUES (2,1000)
INSERT INTO RIDES_ON VALUES (3,1000)
INSERT INTO RIDES_ON VALUES (4,1000)
INSERT INTO RIDES_ON VALUES (5,1000)
INSERT INTO RIDES_ON VALUES (1,1003)
INSERT INTO RIDES_ON VALUES (2,1003)
INSERT INTO RIDES_ON VALUES (3,1003)
INSERT INTO RIDES_ON VALUES (4,1003)
INSERT INTO RIDES_ON VALUES (5,1003)
INSERT INTO RIDES_ON VALUES (1,1021)
INSERT INTO RIDES_ON VALUES (1,1051)
INSERT INTO RIDES_ON VALUES (1,1081)
INSERT INTO RIDES_ON VALUES (7,1003)
INSERT INTO RIDES_ON VALUES (8,1003)
INSERT INTO RIDES_ON VALUES (9,1003)
INSERT INTO RIDES_ON VALUES (10,1003)
INSERT INTO RIDES_ON VALUES (11,1006)
INSERT INTO RIDES_ON VALUES (12,1009)
INSERT INTO RIDES_ON VALUES (37,1015)
INSERT INTO RIDES_ON VALUES (15,1018)
INSERT INTO RIDES_ON VALUES (13,1018)
INSERT INTO RIDES_ON VALUES (14,1018)
INSERT INTO RIDES_ON VALUES (14,1015)
INSERT INTO RIDES_ON VALUES (13,1015)
INSERT INTO RIDES_ON VALUES (6,1015)
INSERT INTO RIDES_ON VALUES (14,1012)
INSERT INTO RIDES_ON VALUES (13,1012)
INSERT INTO RIDES_ON VALUES (6,1012)
INSERT INTO RIDES_ON VALUES (16,1021)
INSERT INTO RIDES_ON VALUES (17,1024)
INSERT INTO RIDES_ON VALUES (18,1027)
INSERT INTO RIDES_ON VALUES (19,1030)
INSERT INTO RIDES_ON VALUES (20,1033)
INSERT INTO RIDES_ON VALUES (21,1036)
INSERT INTO RIDES_ON VALUES (22,1039)
INSERT INTO RIDES_ON VALUES (23,1042)
INSERT INTO RIDES_ON VALUES (24,1045)
INSERT INTO RIDES_ON VALUES (25,1048)
INSERT INTO RIDES_ON VALUES (26,1051)
INSERT INTO RIDES_ON VALUES (27,1054)
INSERT INTO RIDES_ON VALUES (28,1057)
INSERT INTO RIDES_ON VALUES (30,1060)
INSERT INTO RIDES_ON VALUES (31,1063)
INSERT INTO RIDES_ON VALUES (32,1066)
INSERT INTO RIDES_ON VALUES (33,1069)
INSERT INTO RIDES_ON VALUES (34,1072)
INSERT INTO RIDES_ON VALUES (35,1075)
INSERT INTO RIDES_ON VALUES (36,1078)
INSERT INTO RIDES_ON VALUES (37,1081)
INSERT INTO RIDES_ON VALUES (37,1084)
INSERT INTO RIDES_ON VALUES (6,1075)
INSERT INTO RIDES_ON VALUES (14,1078)
INSERT INTO RIDES_ON VALUES (13,1081)
INSERT INTO RIDES_ON VALUES (37,1087)
INSERT INTO RIDES_ON VALUES (37,1090)

INSERT INTO SHOW VALUES (1, 'The Happy Musical', 'A musical of your favorite characters.', 20)
INSERT INTO SHOW VALUES (2, 'The Bear King', 'Featuring the bear king and his friends.', 10)
INSERT INTO SHOW VALUES (3, 'River Lights', 'Amazing light show in the river.', 30)
INSERT INTO SHOW VALUES (4, 'The Toy Book', 'The talking toys come to life!', 20)
INSERT INTO SHOW VALUES (5, 'The Yellow Bear', 'The adventures of the yellow bear.', 20)
INSERT INTO SHOW VALUES (6, 'Airplanes', 'The talking trucks in real life.', 10)
INSERT INTO SHOW VALUES (7, 'Finding Karen', 'It is time to find Karen!', 10)
INSERT INTO SHOW VALUES (8, 'The Forest Book', 'We return to the forest for this famous story.', 20)
INSERT INTO SHOW VALUES (9, 'Melting', 'We go to Antarctica to meet the Melting characters.', 20)
INSERT INTO SHOW VALUES (10, 'Fireworks', 'The nightly fireworks show!', 20)

INSERT INTO SHOWING VALUES ('12:00', 1)
INSERT INTO SHOWING VALUES ('15:30', 1)
INSERT INTO SHOWING VALUES ('14:00', 2)
INSERT INTO SHOWING VALUES ('20:00', 3)
INSERT INTO SHOWING VALUES ('18:00', 4)
INSERT INTO SHOWING VALUES ('10:30', 4)
INSERT INTO SHOWING VALUES ('16:00', 5)
INSERT INTO SHOWING VALUES ('15:00', 6)
INSERT INTO SHOWING VALUES ('10:00', 7)
INSERT INTO SHOWING VALUES ('11:00', 8)
INSERT INTO SHOWING VALUES ('19:00', 9)
INSERT INTO SHOWING VALUES ('20:30', 9)
INSERT INTO SHOWING VALUES ('21:00', 10)

INSERT INTO WATCHES VALUES (1,2000)
INSERT INTO WATCHES VALUES (2,2000)
INSERT INTO WATCHES VALUES (3,2003)
INSERT INTO WATCHES VALUES (4,2006)
INSERT INTO WATCHES VALUES (5,2006)
INSERT INTO WATCHES VALUES (6,2009)
INSERT INTO WATCHES VALUES (7,2009)
INSERT INTO WATCHES VALUES (8,2009)
INSERT INTO WATCHES VALUES (9,2012)
INSERT INTO WATCHES VALUES (10,2015)
INSERT INTO WATCHES VALUES (11,2015)
INSERT INTO WATCHES VALUES (12,2018)
INSERT INTO WATCHES VALUES (13,2018)
INSERT INTO WATCHES VALUES (14,2018)
INSERT INTO WATCHES VALUES (15,2018)
INSERT INTO WATCHES VALUES (16,2018)
INSERT INTO WATCHES VALUES (17,2018)
INSERT INTO WATCHES VALUES (18,2018)
INSERT INTO WATCHES VALUES (19,2018)
INSERT INTO WATCHES VALUES (20,2018)
INSERT INTO WATCHES VALUES (21,2018)
INSERT INTO WATCHES VALUES (22,2018)
INSERT INTO WATCHES VALUES (23,2018)
INSERT INTO WATCHES VALUES (24,2018)
INSERT INTO WATCHES VALUES (25,2018)
INSERT INTO WATCHES VALUES (26,2018)
INSERT INTO WATCHES VALUES (27,2018)
INSERT INTO WATCHES VALUES (28,2021)
INSERT INTO WATCHES VALUES (29,2024)
INSERT INTO WATCHES VALUES (30,2027)
INSERT INTO WATCHES VALUES (31,2030)
INSERT INTO WATCHES VALUES (32,2033)
INSERT INTO WATCHES VALUES (1,2036)
INSERT INTO WATCHES VALUES (2,2036)
INSERT INTO WATCHES VALUES (3,2036)
INSERT INTO WATCHES VALUES (4,2036)
INSERT INTO WATCHES VALUES (5,2036)
INSERT INTO WATCHES VALUES (6,2036)
INSERT INTO WATCHES VALUES (7,2036)
INSERT INTO WATCHES VALUES (8,2036)
INSERT INTO WATCHES VALUES (9,2036)
INSERT INTO WATCHES VALUES (10,2036)
INSERT INTO WATCHES VALUES (11,2036)
INSERT INTO WATCHES VALUES (12,2036)
INSERT INTO WATCHES VALUES (13,2036)
INSERT INTO WATCHES VALUES (14,2036)
INSERT INTO WATCHES VALUES (15,2036)
INSERT INTO WATCHES VALUES (16,2036)
INSERT INTO WATCHES VALUES (17,2036)
INSERT INTO WATCHES VALUES (18,2036)
INSERT INTO WATCHES VALUES (19,2036)
INSERT INTO WATCHES VALUES (20,2036)
INSERT INTO WATCHES VALUES (21,2036)

INSERT INTO CONCESSION_STAND_TYPE VALUES (1, 'Drinks', 'Serves refreshing drinks.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (2, 'Ice Cream', 'Serves all types of frozen treats.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (3, 'Churros', 'Serves different types of churros.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (4, 'Snacks', 'Serves different packaged snacks.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (5, 'Hot Dog', 'Serves hot dogs.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (6, 'Fries', 'Serving world famous french fries.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (7, 'Burritos', 'Serves burritos and tacos.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (8, 'Corn Dogs', 'Serves corndogs.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (9, 'Cotton Candy', 'Serves cotton candy and other sugary treats.')
INSERT INTO CONCESSION_STAND_TYPE VALUES (10, 'Popcorn', 'Serves buttery popcorn.')

INSERT INTO CONCESSION_STAND VALUES (1, 'Refreshers', '8:00', '22:00', 1)
INSERT INTO CONCESSION_STAND VALUES (2, 'Thirst Quenchers', '8:00', '21:00', 1)
INSERT INTO CONCESSION_STAND VALUES (3, 'Freeze', '10:00', '18:00', 2)
INSERT INTO CONCESSION_STAND VALUES (4, 'The Ice Cream Shop', '8:00', '20:00', 2)
INSERT INTO CONCESSION_STAND VALUES (5, 'Jacks Famous Churros', '8:00', '15:00', 3)
INSERT INTO CONCESSION_STAND VALUES (6, 'World Famous Churros', '12:00', '21:00', 3)
INSERT INTO CONCESSION_STAND VALUES (7, 'Fill Ups', '8:00', '21:00', 4)
INSERT INTO CONCESSION_STAND VALUES (8, 'Mikes Snacks', '8:00', '21:00', 4)
INSERT INTO CONCESSION_STAND VALUES (9, 'Hot Dog Stand', '8:00', '21:00', 5)
INSERT INTO CONCESSION_STAND VALUES (10, 'Gourmet Hot Dogs', '8:00', '21:00', 5)
INSERT INTO CONCESSION_STAND VALUES (11, 'French Fries', '8:00', '21:00', 6)
INSERT INTO CONCESSION_STAND VALUES (12, 'Corys Fries', '8:00', '21:00', 6)
INSERT INTO CONCESSION_STAND VALUES (13, 'Burritos and Tacos', '11:00', '21:00', 7)
INSERT INTO CONCESSION_STAND VALUES (14, 'Famous Burritos', '10:00', '21:00', 7)
INSERT INTO CONCESSION_STAND VALUES (15, 'Crunchy Corn Dogs', '11:00', '20:00', 8)
INSERT INTO CONCESSION_STAND VALUES (16, 'Matts Corn Dogs', '11:00', '21:00', 8)
INSERT INTO CONCESSION_STAND VALUES (17, 'Cotton Candy Stand', '8:00', '14:00', 9)
INSERT INTO CONCESSION_STAND VALUES (18, 'Jeffs Cotton Candy', '11:00', '21:00', 9)
INSERT INTO CONCESSION_STAND VALUES (19, 'Buttery Popcorn', '12:00', '20:00', 10)
INSERT INTO CONCESSION_STAND VALUES (20, 'The Crunch', '8:00', '16:00', 10)

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '11:25', VisitorID, '1'
FROM TICKET
WHERE VisitorID >= 1 AND VisitorID <= 5

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '12:00', VisitorID, '2'
FROM TICKET
WHERE VisitorID >= 5 AND VisitorID <= 9

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '15:00', VisitorID, '3'
FROM TICKET
WHERE VisitorID >= 21 AND VisitorID <= 31

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '18:00', VisitorID, '4'
FROM TICKET
WHERE VisitorID >= 32 AND VisitorID <= 37

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '14:30', VisitorID, '5'
FROM TICKET
WHERE VisitorID >= 35 AND VisitorID <= 37

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '20:15', VisitorID, '6'
FROM TICKET
WHERE VisitorID >= 21 AND VisitorID <= 22

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '10:30', VisitorID, '7'
FROM TICKET
WHERE VisitorID >= 18 AND VisitorID <= 19

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '11:45', VisitorID, '8'
FROM TICKET
WHERE VisitorID >= 13 AND VisitorID <= 14

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '14:00', VisitorID, '9'
FROM TICKET
WHERE VisitorID >= 6 AND VisitorID <= 7

INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '16:00', VisitorID, '10'
FROM TICKET
WHERE VisitorID >= 8 AND VisitorID <= 11


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '18:00', VisitorID, '11'
FROM TICKET
WHERE VisitorID >= 20 AND VisitorID <= 21


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '12:00', VisitorID, '12'
FROM TICKET
WHERE VisitorID >= 34 AND VisitorID <= 34


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '18:00', VisitorID, '13'
FROM TICKET
WHERE VisitorID >= 33 AND VisitorID <= 37


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '18:30', VisitorID, '14'
FROM TICKET
WHERE VisitorID >= 29 AND VisitorID <= 30


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '17:00', VisitorID, '15'
FROM TICKET
WHERE VisitorID >= 31 AND VisitorID <= 33


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '19:00', VisitorID, '16'
FROM TICKET
WHERE VisitorID >= 19 AND VisitorID <= 20


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '13:55', VisitorID, '17'
FROM TICKET
WHERE VisitorID >= 13 AND VisitorID <= 14


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '19:35', VisitorID, '18'
FROM TICKET
WHERE VisitorID >= 11 AND VisitorID <= 12


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '12:30', VisitorID, '19'
FROM TICKET
WHERE VisitorID >= 6 AND VisitorID <= 10


INSERT INTO FOOD_ORDER (Date, Time, VisitorID, ConcessionStandID)
SELECT DateValid, '11:00', VisitorID, '20'
FROM TICKET
WHERE VisitorID >= 1 AND VisitorID <= 5

INSERT INTO FOOD VALUES (1, 'Slushy', 'A refreshing iced slushy.', 4.99)
INSERT INTO FOOD VALUES (2, 'Water', 'Bottled water.', 3.99)
INSERT INTO FOOD VALUES (3, 'Soda', 'Canned soda.', 3.99)
INSERT INTO FOOD VALUES (4, 'Vanilla Ice Cream', null, 4.99)
INSERT INTO FOOD VALUES (5, 'Ice Cream Sandwich', null, 3.99)
INSERT INTO FOOD VALUES (6, 'Crispy Churro', null, 2.99)
INSERT INTO FOOD VALUES (7, 'Jumbo Churro', null, 4.99)
INSERT INTO FOOD VALUES (8, 'Chips', 'Any bag of chips.', 2.99)
INSERT INTO FOOD VALUES (9, 'Cookies', 'Jumbo sized cookie.', 2.99)
INSERT INTO FOOD VALUES (10, 'Chili Cheese Dog', null, 8.99)
INSERT INTO FOOD VALUES (11, 'Plain Hot Dog', null, 7.99)
INSERT INTO FOOD VALUES (12, 'Turkey Hot Dog', null, 8.99)
INSERT INTO FOOD VALUES (13, 'Hot Dog Combo', null, 14.99)
INSERT INTO FOOD VALUES (14, 'Garlic Fries', null, 7.99)
INSERT INTO FOOD VALUES (15, 'Cheese Fries', 'Extra cheesy fries.', 8.99)
INSERT INTO FOOD VALUES (16, 'Cheese Burrito', null, 9.99)
INSERT INTO FOOD VALUES (17, 'Veggie Burrito', null, 9.99)
INSERT INTO FOOD VALUES (18, 'Chicken Cheese Taco', null, 8.49)
INSERT INTO FOOD VALUES (19, 'Crispy Corn Dog', null, 8.99)
INSERT INTO FOOD VALUES (20, 'Corn Dog Combo', null, 12.99)
INSERT INTO FOOD VALUES (21, 'Regular Cotton Candy', null, 6.99)
INSERT INTO FOOD VALUES (22, 'Jumbo Cotton Candy', null, 9.99)
INSERT INTO FOOD VALUES (23, 'Small Popcorn', null, 7.99)
INSERT INTO FOOD VALUES (24, 'Flavored Popcorn', null, 8.99)

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 1, FoodOrderID, 1
FROM FOOD_ORDER
WHERE FoodOrderID >= 4000 AND FoodOrderID <= 4007

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 2, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID >= 4008 AND FoodOrderID <= 4018

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 4, FoodOrderID, 5
FROM FOOD_ORDER
WHERE FoodOrderID >= 4019 AND FoodOrderID <= 4035

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 5, FoodOrderID, 3
FROM FOOD_ORDER
WHERE FoodOrderID >= 4036 AND FoodOrderID <= 4043

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 6, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID >= 4044 AND FoodOrderID <= 4046

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 7, FoodOrderID, 10
FROM FOOD_ORDER
WHERE FoodOrderID >= 4047 AND FoodOrderID <= 4048

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 8, FoodOrderID, 1
FROM FOOD_ORDER
WHERE FoodOrderID >= 4049 AND FoodOrderID <= 4050

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 9, FoodOrderID, 4
FROM FOOD_ORDER
WHERE FoodOrderID >= 4051 AND FoodOrderID <= 4054

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 11, FoodOrderID, 3
FROM FOOD_ORDER
WHERE FoodOrderID >= 4055 AND FoodOrderID <= 4060

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 13, FoodOrderID, 6
FROM FOOD_ORDER
WHERE FoodOrderID >= 4061 AND FoodOrderID <= 4066

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 14, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID >= 4067 AND FoodOrderID <= 4068

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 15, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID = 4069

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 17, FoodOrderID, 3
FROM FOOD_ORDER
WHERE FoodOrderID >= 4070 AND FoodOrderID <= 4075

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 18, FoodOrderID, 4
FROM FOOD_ORDER
WHERE VisitorID >= 4076 AND VisitorID <= 4079

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 20, FoodOrderID, 4
FROM FOOD_ORDER
WHERE FoodOrderID >= 4080 AND FoodOrderID <= 4085


INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 19, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID >= 4086 AND FoodOrderID <= 4087


INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 21, FoodOrderID, 4
FROM FOOD_ORDER
WHERE FoodOrderID >= 4088 AND FoodOrderID <= 4091


INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 22, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID >= 4092 AND FoodOrderID <= 4094


INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 23, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID >= 4095 AND FoodOrderID <= 4105

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 24, FoodOrderID, 2
FROM FOOD_ORDER
WHERE FoodOrderID >= 4106 AND FoodOrderID <= 4113

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 23, FoodOrderID, 1
FROM FOOD_ORDER
WHERE FoodOrderID >= 4106 AND FoodOrderID <= 4107

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 18, FoodOrderID, 1
FROM FOOD_ORDER
WHERE FoodOrderID >= 4076 AND FoodOrderID <= 4079

INSERT INTO FOOD_ORDER_ITEM (FoodID, FoodOrderID, Quantity)
SELECT 2, FoodOrderID, 1
FROM FOOD_ORDER
WHERE FoodOrderID >= 4076 AND FoodOrderID <= 4079

INSERT INTO SOUVENIR_SHOP VALUES (1, 'The Souvenir Shop', 'One stop shop for souvenirs!', '8:00', '21:00')
INSERT INTO SOUVENIR_SHOP VALUES (2, 'The Space Station', 'Space themed souvenirs.', '8:00', '21:00')
INSERT INTO SOUVENIR_SHOP VALUES (3, 'The Cars', null, '8:00', '21:00')
INSERT INTO SOUVENIR_SHOP VALUES (4, 'The Animals', 'Animal themed souvenirs.', '8:00', '21:00')
INSERT INTO SOUVENIR_SHOP VALUES (5, 'Bears and Friends', null, '8:00', '21:00')
INSERT INTO SOUVENIR_SHOP VALUES (6, 'Superheroes', null, '8:00', '20:00')
INSERT INTO SOUVENIR_SHOP VALUES (7, 'Nature Store', 'Nature themed store.', '8:00', '20:00')
INSERT INTO SOUVENIR_SHOP VALUES (8, 'Stuffed Animals', null, '8:00', '20:00')
INSERT INTO SOUVENIR_SHOP VALUES (9, 'River Store', null, '8:00', '20:00')
INSERT INTO SOUVENIR_SHOP VALUES (10, 'Toy Shop', null, '8:00', '20:00')

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '15:00', VisitorID, 1
FROM TICKET
WHERE VisitorID >= 1 AND VisitorID <= 10

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '15:00', VisitorID, 2
FROM TICKET
WHERE VisitorID >= 11 AND VisitorID <= 20

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '16:00', VisitorID, 3
FROM TICKET
WHERE VisitorID >= 21 AND VisitorID <= 37

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '9:00', VisitorID, 4
FROM TICKET
WHERE VisitorID >= 4 AND VisitorID <= 5

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '10:00', VisitorID, 1
FROM TICKET
WHERE VisitorID >= 15 AND VisitorID <= 19

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '11:00', VisitorID, 5
FROM TICKET
WHERE VisitorID >= 21 AND VisitorID <= 22

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '12:00', VisitorID, 6
FROM TICKET
WHERE VisitorID >= 24 AND VisitorID <= 27

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '14:00', VisitorID, 7
FROM TICKET
WHERE VisitorID >= 28 AND VisitorID <= 29

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '15:00', VisitorID, 8
FROM TICKET
WHERE VisitorID >= 30 AND VisitorID <= 31

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '16:00', VisitorID, 9
FROM TICKET
WHERE VisitorID >= 13 AND VisitorID <= 14

INSERT INTO SOUVENIR_ORDER (Date, Time, VisitorID, SouvenirShopID)
SELECT DateValid, '18:00', VisitorID, 10
FROM TICKET
WHERE VisitorID >= 1 AND VisitorID <= 2

INSERT INTO SOUVENIR VALUES (1, 'Magnet', 'A magnet to remember the fun rides.', 4.99)
INSERT INTO SOUVENIR VALUES (2, 'Stuffed Animal', 'A stuffed animal.', 9.99)
INSERT INTO SOUVENIR VALUES (3, 'Key Chain', 'Key chain with the amusement park logo', 5.99)
INSERT INTO SOUVENIR VALUES (4, 'T-Shirt', null, 14.99)
INSERT INTO SOUVENIR VALUES (5, 'Hat', 'A hat with the amusement park logo.', 19.99)
INSERT INTO SOUVENIR VALUES (6, 'Fan', 'Stay cool with this fan.', 13.99)
INSERT INTO SOUVENIR VALUES (7, 'Toy Car', 'A toy car.', 12.99)
INSERT INTO SOUVENIR VALUES (8, 'Mug', 'Coffee mug.', 16.99)
INSERT INTO SOUVENIR VALUES (9, 'Phone Case', null, 19.99)
INSERT INTO SOUVENIR VALUES (10, 'Photo Frame', 'A photo frame.', 10.99)

INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 1, 1
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5000 AND SouvenirOrderID <= 5005


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 2, 2
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5005 AND SouvenirOrderID <= 5010


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 3, 2
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5011 AND SouvenirOrderID <= 5016


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 4, 1
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5017 AND SouvenirOrderID <= 5022


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 5, 1
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5023 AND SouvenirOrderID <= 5039


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 6, 1
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5040 AND SouvenirOrderID <= 5060


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 7, 2
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5061 AND SouvenirOrderID <= 5069


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 8, 8
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5070 AND SouvenirOrderID <= 5075


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 9, 10
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5076 AND SouvenirOrderID <= 5084


INSERT INTO SOUVENIR_ORDER_ITEM (SouvenirOrderID, SouvenirID, Quantity)
SELECT SouvenirOrderID, 10, 3
FROM SOUVENIR_ORDER
WHERE SouvenirOrderID >= 5085 AND SouvenirOrderID <= 5092
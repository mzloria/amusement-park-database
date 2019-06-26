/* Michael Zachary Loria	*/
/* Databases Project		*/
/* Amusement Park Database	*/
/* Queries					*/

USE Loria_Michael_db
GO

/* Find the names of all visitors that have been to the amusement park more than one time. */

SELECT VISITOR.FirstName, VISITOR.LastName, COUNT(TICKET.TicketID) AS VisitsToAmusementPark
FROM VISITOR, TICKET
WHERE VISITOR.VisitorID = TICKET.VisitorID
GROUP BY VISITOR.VisitorID, VISITOR.FirstName, VISITOR.LastName
HAVING COUNT(TICKET.TicketID) > 1;

/* Find the most popular food item in the amusement park. */

SELECT TOP 1 FOOD.Name
FROM FOOD, FOOD_ORDER, FOOD_ORDER_ITEM
WHERE FOOD_ORDER.FoodOrderID = FOOD_ORDER_ITEM.FoodOrderID
	AND FOOD_ORDER_ITEM.FoodID = FOOD.FoodID
GROUP BY FOOD.Name
ORDER BY Count(FOOD.Name) DESC;

/* Find the most popular ride in the amusement park. */

SELECT TOP 1 RIDE.Name
FROM RIDE, RIDE_CYCLE, RIDES_ON
WHERE RIDE.RideID = RIDE_CYCLE.RideID
	AND RIDE_CYCLE.RideCycleID = RIDES_ON.RideCycleID
GROUP BY RIDE.Name
ORDER BY Count(RIDE.Name) DESC;

/* Find the ride(s) that have been ridden on the least. */

SELECT RIDE.Name
FROM RIDE, RIDE_CYCLE, RIDES_ON
WHERE RIDE.RideID = RIDE_CYCLE.RideID 
	AND RIDE_CYCLE.RideCycleID = RIDES_ON.RideCycleID
GROUP BY RIDE.Name
HAVING Count(RIDE.Name) =
(
	SELECT TOP 1 Count(RIDE.Name)
	FROM RIDE, RIDE_CYCLE, RIDES_ON
	WHERE RIDE.RideID = RIDE_CYCLE.RideID
		AND RIDE_CYCLE.RideCycleID = RIDES_ON.RideCycleID
	GROUP BY RIDE.Name
	ORDER BY Count(RIDE.Name)
);

/* Find the most popular show in the amusement park. */

SELECT TOP 1 SHOW.Name
FROM SHOW, SHOWING, WATCHES
WHERE SHOW.ShowID = SHOWING.ShowID	
	AND SHOWING.ShowingID = WATCHES.ShowingID
GROUP BY SHOW.Name
ORDER BY COUNT(SHOW.Name) DESC;

/* Find the shows that have been watched the least. */

SELECT SHOW.Name
FROM SHOW, SHOWING, WATCHES
WHERE SHOW.ShowID = SHOWING.ShowID	
	AND SHOWING.ShowingID = WATCHES.ShowingID
GROUP BY SHOW.Name
HAVING Count(SHOW.Name) =
(
	SELECT TOP 1 Count(SHOW.Name)
	FROM SHOW, SHOWING, WATCHES
	WHERE SHOW.ShowID = SHOWING.ShowID	
		AND SHOWING.ShowingID = WATCHES.ShowingID
	GROUP BY SHOW.Name
	ORDER BY Count(SHOW.Name)
);

/* Find all of the names of visitors that parked in the West Coast parking garage. */

SELECT VISITOR.FirstName, VISITOR.LastName
FROM VISITOR, VEHICLE, PARKING_GARAGE
WHERE VISITOR.LicensePlateNumber = VEHICLE.LicensePlateNumber
	AND VEHICLE.ParkingGarageID = PARKING_GARAGE.ParkingGarageID
	AND PARKING_GARAGE.Name = 'West Coast';

/* Find the names of all visitors over 30 that parked in the East Side parking garage. */

SELECT VISITOR.FirstName, VISITOR.LastName
FROM VISITOR, VEHICLE, PARKING_GARAGE
WHERE VISITOR.LicensePlateNumber = VEHICLE.LicensePlateNumber
	AND VEHICLE.ParkingGarageID = PARKING_GARAGE.ParkingGarageID
	AND PARKING_GARAGE.Name = 'East Side'
	AND VISITOR.Age >= 30;

/* Find the souvenir shop earning the most money. */

SELECT TOP 1 SOUVENIR_SHOP.Name
FROM SOUVENIR, SOUVENIR_ORDER, SOUVENIR_ORDER_ITEM, SOUVENIR_SHOP
WHERE SOUVENIR_ORDER.SouvenirOrderID = SOUVENIR_ORDER_ITEM.SouvenirOrderID
	AND SOUVENIR_ORDER_ITEM.SouvenirID = SOUVENIR.SouvenirID
	AND SOUVENIR_ORDER.SouvenirShopID = SOUVENIR_SHOP.SouvenirShopID
GROUP BY SOUVENIR_SHOP.Name
ORDER BY SUM(Price) DESC

/* Find the time where the Moutain Railroad ride is most popular. */

SELECT TOP 1 RIDE_CYCLE.StartTime
FROM RIDE, RIDE_CYCLE, RIDES_ON 
WHERE RIDE.RideID = RIDE_CYCLE.RideID 
	AND RIDE_CYCLE.RideCycleID = RIDES_ON.RideCycleID
	AND RIDE.Name = 'Mountain Railroad'
GROUP BY RIDE_CYCLE.StartTime
ORDER BY COUNT(RIDES_ON.VisitorID) DESC;

/* Find all the names of visitors over 80 that have eaten the Hot Dog Combo. */

SELECT VISITOR.FirstName, VISITOR.LastName
FROM VISITOR, FOOD, FOOD_ORDER, FOOD_ORDER_ITEM
WHERE VISITOR.VisitorID = FOOD_ORDER.VisitorID 
	AND FOOD_ORDER.FoodOrderID = FOOD_ORDER_ITEM.FoodOrderID
	AND FOOD_ORDER_ITEM.FoodID = FOOD.FoodID
	AND FOOD.Name = 'Hot Dog Combo'
	AND VISITOR.Age > 80;

/* Find the names of visitors less than 30 that have bought the Magnet from The Souvenir Shop. */

SELECT VISITOR.FirstName, VISITOR.LastName
FROM VISITOR, SOUVENIR, SOUVENIR_ORDER, SOUVENIR_ORDER_ITEM, SOUVENIR_SHOP
WHERE VISITOR.VisitorID = SOUVENIR_ORDER.VisitorID 
	AND SOUVENIR_ORDER.SouvenirOrderID = SOUVENIR_ORDER_ITEM.SouvenirOrderID
	AND SOUVENIR_ORDER_ITEM.SouvenirID = SOUVENIR.SouvenirID
	AND SOUVENIR_ORDER.SouvenirShopID = SOUVENIR_SHOP.SouvenirShopID
	AND SOUVENIR.Name = 'Magnet'
	AND SOUVENIR_SHOP.Name = 'The Souvenir Shop'
	AND VISITOR.Age < 30;

/* Find the date and time of the most expensive food order. */

SELECT TOP 1 FOOD_ORDER.Date, FOOD_ORDER.Time
FROM FOOD, FOOD_ORDER, FOOD_ORDER_ITEM
WHERE FOOD.FoodID = FOOD_ORDER_ITEM.FoodID	
	AND FOOD_ORDER.FoodOrderID = FOOD_ORDER_ITEM.FoodOrderID
GROUP BY FOOD_ORDER.FoodOrderID, FOOD_ORDER.Date, FOOD_ORDER.Time
ORDER BY Sum(FOOD.Price) DESC

/* Find the names of all visitors that have a Kid ticket that have ridden on at least 1 Calm ride. */

SELECT DISTINCT VISITOR.FirstName, VISITOR.LastName
FROM VISITOR, RIDE, RIDE_CYCLE, RIDES_ON, RIDE_TYPE, TICKET_TYPE, TICKET
WHERE VISITOR.VisitorID = TICKET.VisitorID
	AND TICKET.TicketTypeID = TICKET_TYPE.TicketTypeID
	AND RIDE.RideID = RIDE_CYCLE.RideID
	AND RIDE_CYCLE.RideCycleID = RIDES_ON.RideCycleID
	AND RIDES_ON.VisitorID = VISITOR.VisitorID
	AND RIDE_TYPE.RideTypeID = RIDE.RideTypeID
	AND RIDE_TYPE.Name = 'Calm'
	AND TICKET_TYPE.TicketTypeName = 'Kid';

/* Find all the names of concession stands of the Hot Dog, Corn Dogs, or Popcorn type that has earned more than 50.00. */

SELECT CONCESSION_STAND.Name
FROM CONCESSION_STAND, CONCESSION_STAND_TYPE, FOOD, FOOD_ORDER, FOOD_ORDER_ITEM
WHERE CONCESSION_STAND.ConcessionStandTypeID = CONCESSION_STAND_TYPE.ConcessionStandTypeID
	AND FOOD_ORDER.FoodOrderID = FOOD_ORDER_ITEM.FoodOrderID
	AND FOOD_ORDER_ITEM.FoodID = FOOD.FoodID
	AND FOOD_ORDER.ConcessionStandID = CONCESSION_STAND.ConcessionStandID
	AND (CONCESSION_STAND_TYPE.Name = 'Hot Dog' OR
		CONCESSION_STAND_TYPE.Name = 'Corn Dogs' OR
		CONCESSION_STAND_TYPE.Name = 'Popcorn')
GROUP BY CONCESSION_STAND.Name
HAVING SUM(FOOD.Price) > 50;

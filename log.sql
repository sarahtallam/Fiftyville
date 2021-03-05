-- Keep a log of any SQL queries you execute as you solve the mystery.--


-- 1) Checking crime_scene table for a crime scene that matches the provided date and crime location
--date: July 28, 2020
--Location Chamberlin Street--

-- 2) Execute code below to see description.--
SELECT description
FROM crime_scene_reports
WHERE year = 2020 AND month = 7 AND day = 28 AND street LIKE "%Chamberlin%";

-- QUERY RESULT:
--"Theft of the CS50 duck took place at 10:15am at the Chamberlin Street courthouse.
--Interviews were conducted today with three witnesses who were present at the time — each of their
--interview transcripts mentions the courthouse."--

-- CS50 Duck Theft Description:
--"Theft of the CS50 duck took place at 10:15am at the Chamberlin
--Street courthouse. Interviews were conducted today with three witnesses who were present at
--the time — each of their interview transcripts mentions the courthouse."

-- 3) Check interviews conducted with witnesses of the CS50 Duck theft incident using SQL query below
--The theft description says that ALL THREE WITNESSES mentioned the COURTHOUSE so I'll filter using
--"courhouse" as a keyword

SELECT *
FROM interviews
WHERE year = 2020 AND month = 7 AND day = 28 AND transcript LIKE "%courthouse%";

-- WITNESS TRANSCRIPTS:
id | name | year | month | day | transcript
161 | Ruth | 2020 | 7 | 28 |
--Sometime within ten minutes of the theft, I saw the thief get
--into a car in the courthouse parking lot and drive away. If you have security footage from the
--courthouse parking lot, you might want to look for cars that left the parking lot in that time
--frame.
162 | Eugene | 2020 | 7 | 28 |
--I don't know the thief's name, but it was someone I recognized.
--Earlier this morning, before I arrived at the courthouse, I was walking by the ATM on Fifer
--Street and saw the thief there withdrawing some money.
163 | Raymond | 2020 | 7 | 28 |
--As the thief was leaving the courthouse, they called
--someone who talked to them for less than a minute. In the call, I heard the thief say that
--they were planning to take the earliest flight out of Fiftyville tomorrow. The thief then
--asked the person on the other end of the phone to purchase the flight ticket.

-- 4) Check courthouse_security_logs for thief's car's license plate because one of the witnesses said they left the
--courthouse 10 minutes after the theft took place.
-- Run SQL query looking for cars that left the parking lot at 10:25 AM--

SELECT *
FROM courthouse_security_logs
WHERE (year = 2020)
AND (month = 7)
AND (day = 28)
AND (hour = 10)
AND minute >= 15
AND minute <= 25;
AND activity = "exit";

-- Results from above query showed the following car license plate numbers exiting the Courthouse lot:
id | year | month | day | hour | minute | activity | license_plate
260 | 2020 | 7 | 28 | 10 | 16 | exit | 5P2BI95
261 | 2020 | 7 | 28 | 10 | 18 | exit | 94KL13X
262 | 2020 | 7 | 28 | 10 | 18 | exit | 6P58WS2
263 | 2020 | 7 | 28 | 10 | 19 | exit | 4328GD8
264 | 2020 | 7 | 28 | 10 | 20 | exit | G412CB7
265 | 2020 | 7 | 28 | 10 | 21 | exit | L93JTIZ
266 | 2020 | 7 | 28 | 10 | 23 | exit | 322W7JE
267 | 2020 | 7 | 28 | 10 | 23 | exit | 0NTHK55


-- 5) Check Fiftyville people's database to match above license plate numbers with the people
SELECT *
FROM people
WHERE (license_plate = "5P2BI95");

SELECT *
FROM people
WHERE license_plate = "94KL13X";

SELECT *
FROM people
WHERE license_plate = "6P58WS2";

SELECT *
FROM people
WHERE license_plate = "4328GD8";

SELECT *
FROM people
WHERE license_plate = "G412CB7";

SELECT *
FROM people
WHERE license_plate = "L93JTIZ";

SELECT *
FROM people
WHERE license_plate = "322W7JE";

SELECT *
FROM people
WHERE license_plate = "0NTHK55";

-- RESULTS SHOWED THE FOLLOWING:

id     | name |    phone_number | passport_number | license_plate
--221103 | Patrick | (725) 555-4692 | 2963008352 | 5P2BI95
686048 | Ernest | (367) 555-5533 | 5773159633 | 94KL13X
--243696 | Amber | (301) 555-4174 | 7526138472 | 6P58WS2
--467400 | Danielle | (389) 555-5198 | 8496433585 | 4328GD8
398010 | Roger | (130) 555-0289 | 1695452385 | G412CB7
--396669 | Elizabeth | (829) 555-5269 | 7049073643 | L93JTIZ
514354 | Russell | (770) 555-1861 | 3592750733 | 322W7JE
--560886 | Evelyn | (499) 555-9472 | 8294398571 | 0NTHK55

-- 6) Check phone logs for calls that took place at the time and date of theft that were <= 60 secs
SELECT *
FROM phone_calls
WHERE year = 2020 AND day = 28 AND month = 7 AND duration <= 60;

RESULSTS:
id | caller | receiver | year | month | day | duration
221 | (130) 555-0289 | (996) 555-8899 | 2020 | 7 | 28 | 51   ROGER
--224 | (499) 555-9472 | (892) 555-8872 | 2020 | 7 | 28 | 36
233 | (367) 555-5533 | (375) 555-8161 | 2020 | 7 | 28 | 45   ERNEST
--234 | (609) 555-5876 | (389) 555-5198 | 2020 | 7 | 28 | 60
--251 | (499) 555-9472 | (717) 555-1342 | 2020 | 7 | 28 | 50
--254 | (286) 555-6063 | (676) 555-6554 | 2020 | 7 | 28 | 43
255 | (770) 555-1861 | (725) 555-3243 | 2020 | 7 | 28 | 49   RUSSELL
--261 | (031) 555-6622 | (910) 555-3251 | 2020 | 7 | 28 | 38
--279 | (826) 555-1652 | (066) 555-9701 | 2020 | 7 | 28 | 55
--281 | (338) 555-6650 | (704) 555-2131 | 2020 | 7 | 28 | 54

-- NOW WE HAVE THREE SUSPECTS: ERNEST, ROGER, AND RUSSELL

-- 7) NOW we'll find out who the three suspects were calling at the time of the theft

SELECT *
FROM people
WHERE phone_number = "(996) 555-8899";

id | name | phone_number | passport_number | license_plate
567218 | Jack | (996) 555-8899 | 9029462229 | 52R0Y8U            ------>>> ROGER CALLED THIS PERSON

SELECT *
FROM people
WHERE phone_number = "(375) 555-8161";
id | name | phone_number | passport_number | license_plate
864400 | Berthold | (375) 555-8161 |  | 4V16VO0                 ------>>> ERNEST CALLED THIS PERSON

SELECT *
FROM people
WHERE phone_number = "(725) 555-3243";

id | name | phone_number | passport_number | license_plate
847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6         ------>>> RUSSELL CALLED THIS PERSON



-- 8) Now I'll look for flights that took off on the day of the theft from Fiftyville
--I'll filter by the DAY AFTER the theft took place per the witness' transcript
--and will look for EARLY flight times
SELECT *
FROM flights JOIN airports ON flights.origin_airport_id = airports.id
WHERE year = 2020 AND month = 7 AND day = 29 AND origin_airport_id = 8;

--RESULTS SHOW THE FOLLOWING FLIGHTS:

id | origin_airport_id | destination_airport_id | year | month | day | hour | minute | id | abbreviation | full_name | city
--18 | 8 | 6 | 2020 | 7 | 29 | 16 | 0 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
--23 | 8 | 11 | 2020 | 7 | 29 | 12 | 15 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
43 | 8 | 1 | 2020 | 7 | 29 | 9 | 30 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
--53 | 8 | 9 | 2020 | 7 | 29 | 15 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville

--WE HAVE ONLY 2 EARLY FLIGHTS
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 8 | CSF | Fiftyville Regional Airport | Fiftyville
43 | 8 | 1 | 2020 | 7 | 29 | 9 | 30 | 8 | CSF | Fiftyville Regional Airport | Fiftyville

-- 9) I'll check if my three suspects were on any of these two flights using their
-- passport numbers

--ERNEST:
SELECT *
FROM passengers JOIN flights ON passengers.flight_id = flights.id
WHERE year = 2020 AND day = 29 AND month = 7 AND passport_number = 5773159633;
--RESULT:
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
36 | 5773159633 | 4A | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20


--RUSSELL:
SELECT *
FROM passengers JOIN flights ON passengers.flight_id = flights.id
WHERE year = 2020 AND day = 29 AND month = 7 AND passport_number = 3592750733;
--RESULT:
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
18 | 3592750733 | 4C | 18 | 8 | 6 | 2020 | 7 | 29 | 16 | 0


--ROGER:
SELECT *
FROM passengers JOIN flights ON passengers.flight_id = flights.id
WHERE year = 2020 AND day = 29 AND month = 7 AND passport_number = 1695452385;
--RESULT:
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
36 | 1695452385 | 3B | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20

-- 10) Check accomplices phone numbers to get names: (Berthold, Jack, Philip)
--BERTHOLD
SELECT *
FROM people
WHERE name = "Berthold";
-- RESULT:
id | name | phone_number | passport_number | license_plate
864400 | Berthold | (375) 555-8161 |  | 4V16VO0     --NO PASSPORT NUMBER! Ernest called him



--JACK
SELECT *
FROM people
WHERE name = "Jack";
--RESULT:
id | name | phone_number | passport_number | license_plate
567218 | Jack | (996) 555-8899 | 9029462229 | 52R0Y8U

--PHILIP:
SELECT *
FROM people
WHERE name = "Philip";
--RESULT:
id | name | phone_number | passport_number | license_plate
847116 | Philip | (725) 555-3243 | 3391710505 | GW362R6


-- 11) Check if accomplices were on the flights:

--BERTHOLD DOESN'T HAVE A PASSPORT NUMBER - SUSPICIOUS

-- Jack
SELECT *
FROM passengers JOIN flights ON passengers.flight_id = flights.id
WHERE passport_number = 9029462229;
--RESULT -- DOESN'T LOOK LIKE IT'S JACK BECAUSE HE DOESN'T HAVE FLIGHTSBON THE 29
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
22 | 9029462229 | 3D | 22 | 1 | 8 | 2020 | 7 | 28 | 12 | 51

-- PHILIP
SELECT *
FROM passengers JOIN flights ON passengers.flight_id = flights.id
WHERE passport_number = 3391710505;
--RESULT: -- DOESN'T LOOK LIKE IT'S PHILIP BECAUSE HE DOESN'T HAVE FLIGHTSBON THE 29
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
10 | 3391710505 | 2A | 10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55
28 | 3391710505 | 2A | 28 | 3 | 8 | 2020 | 7 | 26 | 22 | 49
47 | 3391710505 | 4D | 47 | 4 | 8 | 2020 | 7 | 30 | 9 | 46

-- 12) THAT LEAVES US WITH ONE SUSPECT: ERNEST AND HIS ACCOMPLICE BERTHOLD
--NOW I'll CHECK WHERE ERNEST IS HEADED USING BELOW INFORMATION FROM A PREVIOUS RESULT
--USING DESTINATION AIRPORT NUMBER 8
-- ERNEST:
--RESULT:
flight_id | passport_number | seat | id | origin_airport_id | destination_airport_id | year | month | day | hour | minute
36 | 5773159633 | 4A | 36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20

-- 13) NOW I'LL FIND THE DESTINATION CITY NUMBER 4:
SELECT *
FROM flights JOIN airports ON destination_airport_id = airports.id
WHERE destination_airport_id = 4;
-- RESULT:
10 | 8 | 4 | 2020 | 7 | 30 | 13 | 55 | 4 | LHR | Heathrow Airport | London
17 | 8 | 4 | 2020 | 7 | 28 | 20 | 16 | 4 | LHR | Heathrow Airport | London
35 | 8 | 4 | 2020 | 7 | 28 | 16 | 16 | 4 | LHR | Heathrow Airport | London
36 | 8 | 4 | 2020 | 7 | 29 | 8 | 20 | 4 | LHR | Heathrow Airport | London
55 | 8 | 4 | 2020 | 7 | 26 | 21 | 44 | 4 | LHR | Heathrow Airport | London


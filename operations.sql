-- -------
-- Part 1 SQL updates
USE assign2db; 

SELECT * FROM course;
UPDATE course SET coursename="Multimedia and Communications" WHERE coursename = "Multimedia";
SELECT * FROM course;
SELECT * FROM hasworkedon;
UPDATE hasworkedon SET hours = 200 WHERE tauserid IN (SELECT tauserid FROM ta WHERE firstname LIKE "R%");
SELECT * FROM hasworkedon;
-- --------------
-- Part 2 SQL Inserts
INSERT course VALUES ("CS2211", "C and Unix",2,1999);
INSERT courseoffer VALUES ("7892",30,"Fall",2000,"CS2211");
INSERT courseoffer  VALUES  ("7893",30,"Spring",2000,"CS2211");
INSERT courseoffer  VALUES  ("7894",30,"Fall",2002,"CS2211");
INSERT ta VALUES ("sbullock","sandra","bullock","252233344","PhD");
INSERT loves VALUES ("sbullock","CS2211");
SELECT * FROM course;
SELECT * FROM courseoffer;
SELECT * FROM ta;
SELECT * FROM loves;
-- ------------------------
-- PART 3 SQL Queries
-- Query 1
SELECT lastname FROM ta;
-- Query 2
SELECT DISTINCT lastname FROM ta;
-- Query 3
SELECT * FROM ta ORDER BY firstname;
-- Query 4
SELECT firstname, lastname, tauserid FROM ta WHERE degreetype = "Masters";
-- Query 5
SELECT coid, term, year, whichcourse FROM courseoffer WHERE whichcourse IN (SELECT coursenum FROM course WHERE coursename LIKE "%Database%");
-- Query 6
SELECT * FROM course,courseoffer WHERE coursenum=whichcourse AND course.year> courseoffer.year;
-- Query 7
SELECT coursename, coursenum FROM course, loves, ta WHERE lastname="Geller" AND tauserid=ltauserid AND lcoursenum=coursenum;
-- Query 8
SELECT sum(numstudent), coursename, coursenum FROM course, courseoffer WHERE coursenum=whichcourse AND coursenum="CS1033";
-- Query 9
SELECT DISTINCT firstname,lastname, coursenum 
FROM course, courseoffer, ta, hasworkedon 
WHERE level=1 AND coursenum=whichcourse AND hasworkedon.tauserid=ta.tauserid AND hasworkedon.coid = courseoffer.coid;
-- Query 10
SELECT firstname, lastname, hours, whichcourse 
FROM ta, courseoffer, hasworkedon 
WHERE ta.tauserid=hasworkedon.tauserid AND hasworkedon.coid=courseoffer.coid AND hours in (SELECT max(hours) FROM hasworkedon);
-- Query 11
SELECT coursename, coursenum 
FROM course 
WHERE coursenum NOT IN (SELECT lcoursenum FROM loves) 
INTERSECT 
SELECT coursename, coursenum 
FROM course 
WHERE coursenum NOT IN (SELECT hcoursenum FROM hates);
-- Query 12
SELECT firstname,lastname, count(coid) 
FROM ta, hasworkedon 
WHERE ta.tauserid=hasworkedon.tauserid 
GROUP BY ta.tauserid HAVING count(coid)>1;
-- Query 13
SELECT DISTINCT firstname, lastname, coursenum, coursename 
FROM course,loves, courseoffer, hasworkedon, ta 
WHERE ta.tauserid=hasworkedon.tauserid AND hasworkedon.coid = courseoffer.coid AND whichcourse = coursenum AND lcoursenum=coursenum and ltauserid=hasworkedon.tauserid;
-- Query 14
CREATE VIEW vfall AS SELECT count(coid) AS fallcount, whichcourse FROM courseoffer WHERE term = "Fall" GROUP BY whichcourse;
SELECT fallcount, whichcourse, coursename FROM course, vfall WHERE whichcourse=coursenum AND  fallcount IN (SELECT max(fallcount) FROM course, vfall);
-- Query 15 Users choice Laura's choice was:Display first name of all the tas in alphabetical order by first name if their name contains the letter e
SELECT firstname FROM ta WHERE firstname LIKE '%e%' ORDER BY firstname;

-- ----------------------
-- PART 4 SQL Views/Deletes
CREATE VIEW vhates AS 
SELECT firstname, lastname, tauserid, coursenum, coursename 
FROM ta, hates, course 
WHERE coursenum=hcoursenum AND tauserid=htauserid 
ORDER BY level;

SELECT * FROM vhates;

SELECT DISTINCT firstname, lastname, coursenum 
FROM vhates, hasworkedon,courseoffer WHERE vhates.tauserid = hasworkedon.tauserid AND courseoffer.coid=hasworkedon.coid AND coursenum=whichcourse;

SELECT * FROM ta;

SELECT * FROM hates;

DELETE FROM ta WHERE tauserid="pbing";

SELECT * FROM ta;

SELECT * FROM hates;

DELETE FROM ta WHERE tauserid="mgeller";
-- Didnt work because there is a restrict on deleing a ta if they ever were a ta for a course offering

ALTER TABLE ta ADD image VARCHAR(200);

SELECT * FROM ta;

UPDATE ta SET image="https://i.pinimg.com/originals/bf/85/8d/bf858d262ce992754e2b78042c9e0fe8.gif" WHERE tauserid="mgeller";

SELECT * FROM ta;
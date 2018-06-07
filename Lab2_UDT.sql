/*
Zoe Rochelle
CSC342
Lab2 UDT Behavior/Structure
*/

/* POINT OBJECT */
CREATE OR REPLACE TYPE POINT As OBJECT
(LABEL VARCHAR(1),
 X INTEGER,
 Y INTEGER,
CONSTRUCTOR FUNCTION POINT
 (LABEL VARCHAR,
  X INTEGER,
  Y INTEGER)
RETURN SELF AS RESULT);
/

/* POINT TYPE BODY */
CREATE OR REPLACE TYPE BODY POINT AS
CONSTRUCTOR FUNCTION POINT
(LABEL VARCHAR,
  X INTEGER,
  Y INTEGER) RETURN SELF AS RESULT
IS
BEGIN
  IF  X < 0 THEN
  RAISE_APPLICATION_ERROR(-20000, 'No Negative Number');
  ELSIF Y < 0 THEN
  RAISE_APPLICATION_ERROR(-20000, 'No Negative Number');
  END IF;
  SELF.LABEL := LABEL;
  SELF.X := X;
  SELF.Y := Y;
  RETURN;
  END;
END;
/

/* CREATE POINT TABLE */
CREATE TABLE POINT_TABLE OF POINT
(UNIQUE(X,Y),
 UNIQUE(label)
);
/

/* INVOKE THE CONSTRUCTOR, Example code: */
INSERT INTO POINT_TABLE 
VALUES (POINT('a', 1, 2));

/* Object LINE type */
CREATE OR REPLACE TYPE LINE1 As OBJECT
(ENDPOINT1 REF POINT,
 ENDPOINT2 REF POINT,
 CONSTRUCTOR FUNCTION LINE1
 (ENDPOINT1 REF POINT,
  ENDPOINT2 REF POINT)
RETURN SELF AS RESULT);
/

/* Create object table for LINE type object:
(1) Include a method for determining Horizontal: 'H'
(2) Include a method for determining Vertical: 'V'
(3) Include a method for calculating the length of a line.

Errors: Review this section.
*/
CREATE OR REPLACE TYPE BODY LINE1 AS
CONSTRUCTOR FUNCTION LINE1
(ENDPOINT1 REF POINT,
 ENDPOINT2 REF POINT) RETURN SELF AS RESULT
 IS
 BEGIN
 	--Include a method for calculating the length of a line.
	DBMS_OUTPUT.PUT_LINE(LENGTH(left));
 IF X.ENDPOINT1 = X.ENDPOINT2 THEN --if horizontal then x1 = x2
	DBMS_OUTPUT.PUT_LINE('H');
 ELSIF Y.ENDPOINT1 = Y.ENDPOINT2 THEN --if vertical then y1 = y2
	DBMS_OUTPUT.PUT_LINE('V');
 RETURN;
 END IF;
END;
/

CREATE TABLE LINE_TABLE OF LINE1;

/* Create Rectangle OBJECT
(1) Include a method to calculate the area. 
(2) Include a method to calculate the perimeter. 
(3) Method that ensures that the four lines form a valid rectangle.
 */
CREATE OR REPLACE TYPE RECTANGLE As OBJECT
(left REF LINE1, --Use DREF
 top REF LINE1,
 right REF LINE1,
 bottom REF LINE1,
 area NUMBER,
 perimeter NUMBER,
 CONSTRUCTOR FUNCTION RECTANGLE(left NUMBER, top NUMBER, right NUMBER, bottom NUMBER)
    RETURN SELF AS RESULT
);
/

/*Create Rectangle TYPE BODY*/
CREATE OR REPLACE TYPE BODY rectangle AS
  CONSTRUCTOR FUNCTION rectangle
  (left NUMBER,
   top NUMBER,
   right NUMBER,
   bottom NUMBER) RETURN SELF AS RESULT
  AS
  BEGIN
	--Include a method for determining the area of the rectangle. 
    SELF.area := left * top;
	--Include a method for calculating the perimeter of the rectangle.
	SELF.perimeter := left + top + right + bottom;
    RETURN;
  END;
END;
/

--insert into boxes, want to have a line constructor
CREATE TABLE BOXES OF RECTANGLE;
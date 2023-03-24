--Write an SQL query to report the first name, last name, city, and state of each person in the Person table. 
--If the address of a personId is not present in the Address table, report null instead.
Select firstName, lastName, city, state 
from Person3 p Left Join Address a 
ON p.personId=a.personId;

Select * from Address;

--Write an SQL query to report all the duplicate emails.
--ANS:
select email, count(email)
from person 
group by email 
having count(email) >1;

--Write a SQL query to rank scores.
-- If there is a tie between two scores, both should have the same ranking. 
-- Note that after a tie, the next ranking number should be the next consecutive integer value. 
-- In other words, there should be no "holes" between ranks.
--ANS:
select *, dense_rank() over (order by Score) as Rnk
from Person2;



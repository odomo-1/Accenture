select * from content
select * from reaction
select * from reaction_type

--- JOINING THE THREE TABLES TOGETHER
create table Accenture as 
(SELECT content."Content ID", content."User ID","content".category, "content"."Type",
reaction."Reaction Type", reaction.datetime,
reaction_type.sentiment, score
from content 
join reaction on reaction."Content ID" = content."Content ID"
join reaction_type on reaction_type."Type" = reaction."Reaction Type")

select * from accenture

--- SELECTING THE BEST FIVE(5) CATEGORIES
select accenture."category", sum(score) as Total_Score from accenture
group by accenture."category"
order by Total_Score DESC
limit 5

----- SELECTING THE BEST CONTENT TYPES
select accenture."Type", sum(score) as Total_Score from accenture
group by accenture."Type"
order by Total_Score DESC


---	HOW MANY REATION ARE THERE TO THE MOST POPULAR CONTENT CATEGORY
SELECT category, count("Reaction Type") as Number_of_Reaction from accenture
GROUP by category
ORDER by Number_of_Reaction DESC
limit 

-- MONTH WITH THE MOST POST
select
	extract (month from to_timestamp(accenture.datetime,'YYYY-MM-DD HH24:MI:SS'))as Month,
	count(score) as Popularity from accenture
group by month 
order by Popularity desc

-- YEAR WITH THE MOST POST
	select
	extract (YEAR from to_timestamp(accenture.datetime,'YYYY-MM-DD HH24:MI:SS'))as Year,
	count(score) as Popularity from accenture
group by year
order by Popularity desc
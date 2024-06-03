use coffee_survey;

select * from result;

-- Data Cleaning
select * from result;

Delete from result
where age = '';

select id_tester, A_notes from result;

update result
set A_notes = ''
where A_notes = 'a' and id_tester = 'Zd694B';

select id_tester, B_notes from result
where B_notes = 's';

update result
set B_notes = ''
where B_notes = 's' and id_tester = 'PABJ8P';

select id_tester, count(*) from result
group by id_tester
having count(*) > 1;

update result
set coffee_nice_A_C = 'Coffee A'
where coffee_nice_A_C = ' not as much as Coffee A. My personal favorite';

SET SQL_SAFE_UPDATES = 0;

UPDATE result
set gender = 'Prefer not to say'
where gender = '';

update result
set gender = 'Other'
where gender in('TRUE', 'FALSE', 'the smellllllllllllll', 'Yes');



-- BAN
-- Total Participant
select count(age) as total_Participant from result;

-- Total Participant based on gender
select gender, count(gender) as total_gender from result
group by gender
order by gender asc;

-- Most Favorite Coffee
with coffee_B as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_B
FROM
    result
    where favorite_overall_coffee = 'Coffee B'
), 
coffee_A as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_A
FROM
    result
    where favorite_overall_coffee = 'Coffee A'
),
coffee_C as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_C
FROM
    result
    where favorite_overall_coffee = 'Coffee C'
),
coffee_D as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_D
FROM
    result
    where favorite_overall_coffee = 'Coffee D'
)

SELECT 
    (SELECT total_coffee_A FROM coffee_A) AS total_coffee_A,
    (SELECT total_coffee_B FROM coffee_B) AS total_coffee_B,
    (SELECT total_coffee_C FROM coffee_C) AS total_coffee_C,
    (SELECT total_coffee_D FROM coffee_D) AS total_coffee_D;


-- FRAGE 1: What is the typical taster persona for the survey?
SELECT 
    gender, 
    age,
    education_level,
    cups_coffee,
    CASE 
        WHEN at_home = 'TRUE' THEN 'At Home'
        WHEN at_office = 'TRUE' THEN 'At Office'
        WHEN at_otw = 'TRUE' THEN 'On the go'
        WHEN at_cafee = 'TRUE' THEN 'At Cafe'
        WHEN none_of_these = 'TRUE' THEN 'None Of These'
        ELSE ''
    END AS Location,
    CASE 
        WHEN espresso = 'TRUE' THEN 'Espresso'
        WHEN pour_over = 'TRUE' THEN 'Pour Over'
        WHEN bean_to_cup_machine = 'TRUE' THEN 'Bean-to-Cup Machine'
        WHEN french_press = 'TRUE' THEN 'French Press'
        WHEN other_brew = 'TRUE' THEN 'Other'
        WHEN pod_capsule_machine = 'TRUE' THEN 'Pod Capsule Machine'
        WHEN cold_brew = 'TRUE' THEN 'Cold Brew'
        ELSE ''
    END AS Brew_Method
FROM result
ORDER BY age ASC;


-- FRAGE 2: Do coffee preferences vary by age? What about by self-rated expertise?
select 
age, 
favorite_coffee_drink, 
specify_favorite_coffee_drink, 
coffee_preferences, 
strong_level, 
coffee_expertise_rate

from result
where favorite_coffee_drink != '' and coffee_expertise_rate != ''
order by coffee_expertise_rate asc;

select ROUND(AVG(coffee_expertise_rate),1) as avg_expertise_rate from result;


-- FRAGE 3: What was the most popular coffee? How did tasters describe it?
-- Searching MOST POPULAR COFFEE FROM THE TESTS
with coffee_B as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_B
FROM
    result
    where favorite_overall_coffee = 'Coffee B'
), 
coffee_A as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_A
FROM
    result
    where favorite_overall_coffee = 'Coffee A'
),
coffee_C as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_C
FROM
    result
    where favorite_overall_coffee = 'Coffee C'
),
coffee_D as
(
SELECT 
   count(favorite_overall_coffee) as total_coffee_D
FROM
    result
    where favorite_overall_coffee = 'Coffee D'
)

SELECT 
    (SELECT total_coffee_A FROM coffee_A) AS total_coffee_A,
    (SELECT total_coffee_B FROM coffee_B) AS total_coffee_B,
    (SELECT total_coffee_C FROM coffee_C) AS total_coffee_C,
    (SELECT total_coffee_D FROM coffee_D) AS total_coffee_D;


with avg_score as
(
select
ROUND(AVG(A_bitterness),2) as avg_bitterness_score_A,
ROUND(AVG(A_acidity),2) as avg_acidity_score_A,
ROUND(AVG(A_personal_preference),2) as avg_personal_preference_score_A,
ROUND(AVG(B_bitterness),2) as avg_bitterness_score_B,
ROUND(AVG(B_acidity),2) as avg_acidity_score_B,
ROUND(AVG(B_personal_preference),2) as avg_personal_preference_score_B,
ROUND(AVG(C_bitterness),2) as avg_bitterness_score_C,
ROUND(AVG(C_acidity),2) as avg_acidity_score_C,
ROUND(AVG(C_personal_preference),2) as avg_personal_preference_score_C,
ROUND(AVG(D_bitterness),2) as avg_bitterness_score_D,
ROUND(AVG(D_acidity),2) as avg_acidity_score_D,
ROUND(AVG(D_personal_preference),2) as avg_personal_preference_score_D

from result
)

select * from avg_score;

-- Description from the Tasters
select A_notes,B_notes,C_notes,D_notes from result
where A_notes != '' and B_notes != '' and C_notes != '' and D_notes != '';


-- Frage 4: Do the taster's stated roast level preferences match their blind test results?
select
roast_level, coffee_nice_A_C, coffee_nice_A_n_D, favorite_overall_coffee
from result
where roast_level != '' and coffee_nice_A_C != '' and coffee_nice_A_n_D != ''
order by roast_level asc;

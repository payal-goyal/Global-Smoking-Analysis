Create Table Smoking_Insights(
Country varchar(100),
Year int,
Total_Smokers_Millions float,
Smoking_Prevalence_percent float,
Male_Smokers_percent float,
Female_Smokers_percent float,
Cigarette_Consumption_Billion_Units float,
Top_Cigarette_Brand_in_Country varchar(200),
Brand_Market_Share_percent float,
Smoking_Related_Deaths int,
Tobacco_Tax_Rate_percent float,
Smoking_Ban_Policy varchar(500)

)

--Total Smokers trend over the years
select Year, sum(Total_Smokers_Millions) as total_smokers
from Smoking_Insights
group by Year
order by Year

--Top 5 Countries with highest smoking related deaths
select country, sum(Smoking_Related_Deaths) as total_deaths
from Smoking_Insights
group by country
order by total_deaths desc
limit 5

--Average Smoking Prevalance by Gender
select
avg(Male_Smokers_percent) as avg_male_smoking,
avg(Female_Smokers_percent) as avg_female_smoking
from Smoking_Insights

--Compare Tobacco tax and smoking prevalance
select
year,
country,
Tobacco_Tax_Rate_percent,
Smoking_Prevalence_percent
from Smoking_Insights
order by Smoking_Prevalence_percent desc

--Countries with a Comprehensive smoking ban policy
select distinct country
from Smoking_Insights
where LOWER(Smoking_Ban_Policy) = 'comprehensive'

--Most Populat cigaratte Brands by Country
select year, country, Top_Cigarette_Brand_in_Country, Brand_Market_Share_percent
from Smoking_Insights
order by Brand_Market_Share_percent desc

--Change in Smoking rate for a specific country(i.e. Germany)
select year, Smoking_Prevalence_percent
from Smoking_Insights
where country = 'Germany'
order by year

--Countries with no smoking policies
select distinct country
from Smoking_Insights
where Lower(Smoking_Ban_Policy) = 'none'

--Smoking prevalance gap between genders(per country & Year )
select country, year,
ABS(Male_Smokers_percent - Female_Smokers_percent) as gender_gap
from Smoking_Insights
order by gender_gap desc

--Compare cigarette consumption per smoker
select country, year,
(Cigarette_Consumption_Billion_Units/ Total_Smokers_Millions) as consumption_per_smoker
from Smoking_Insights
where Total_Smokers_Millions>0
order by consumption_per_smoker desc

--Countries where tobocco tax increased
select country
from Smoking_Insights
group by country
having max(Tobacco_Tax_Rate_percent)>min(Tobacco_Tax_Rate_percent)

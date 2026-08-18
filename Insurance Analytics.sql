CREATE DATABASE PolicyDashboardDB;

USE PolicyDashboardDB;

-- 1 Total Policy

SELECT COUNT(policy_number) AS Total_Policies 
FROM dim_policy;

-- 2 Total Customers

SELECT COUNT(DISTINCT client_name) AS Total_Customers 
FROM dim_policy;

-- 3 Age Bucket Wise Policy Count

SELECT 
    CASE 
        WHEN `Age` < 30 THEN 'Under 30'
        WHEN `Age` BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50' 
    END AS Age_Bucket,
    COUNT(`Customer ID`) AS Customer_Count
FROM `customer information`
GROUP BY 
    CASE 
        WHEN `Age` < 30 THEN 'Under 30'
        WHEN `Age` BETWEEN 30 AND 50 THEN '30-50'
        ELSE 'Over 50' 
    END;
    
-- 4 Gender Wise Policy Count

SELECT `Gender`, COUNT(`Customer ID`) AS Customer_Count
FROM `customer information`
GROUP BY `Gender`;

-- 5 Policy Type Wise Policy Count

SELECT product_group AS Policy_Type, COUNT(policy_number) AS Policy_Count
FROM dim_policy
GROUP BY product_group;

-- 6 Policy Expiring This Year

SELECT COUNT(policy_number) AS Policies_Expiring_2024
FROM dim_policy
WHERE YEAR(policy_end_date) = 2024;

-- 7 Premium Growth Rate

SELECT 
    YEAR(policy_start_date) AS Financial_Year,
    SUM(Amount) AS Total_Premium
FROM brokerage
GROUP BY YEAR(policy_start_date)
ORDER BY Financial_Year;

-- 8 Claim Status Wise Policy Count

SELECT `Claim Status`, COUNT(DISTINCT `Policy ID`) AS Policy_Count
FROM claims
GROUP BY `Claim Status`;

-- 9 Payment Status Wise Policy Count

SELECT `income_class` AS Payment_Status, COUNT(DISTINCT `policy_number`) AS Policy_Count
FROM invoice
GROUP BY `income_class`;

-- 10 Total Claim Amount

SELECT SUM(`Claim Amount`) AS Total_Claim_Payout
FROM claims;

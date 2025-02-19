SELECT TOP (1000) [user_id]
      ,[email_opens]
      ,[email_clicks]
      ,[email_conversions]
      ,[social_impressions]
      ,[social_clicks]
      ,[social_conversions]
      ,[customer_segment]
      ,[total_conversions]
  FROM [Email and Social Media DB].[dbo].[combined_campaign_data]

  -- 3.1. Total Number of Users in the Dataset
-- Purpose: Determine the total number of unique users represented in the campaign data.
-- Insight: Provides a basic understanding of the scale of the dataset.
SELECT COUNT(DISTINCT user_id) AS total_users
FROM combined_campaign_data;  -- Replace 'combined_campaign_data' with your flat file name

-- 3.2. Number of Users Reached by Email Campaigns
-- Purpose: Determine the number of users who opened at least one email.
-- Insight: Shows the reach of the email campaigns.
SELECT COUNT(DISTINCT user_id) AS users_reached_by_email
FROM combined_campaign_data
WHERE email_opens = 1;

-- 3.4. Total Email Conversions
-- Purpose: Calculate the total number of conversions driven by email campaigns.
-- Insight: Provides a measure of the effectiveness of email marketing.
SELECT SUM(CAST(email_conversions AS INT)) AS total_email_conversions
FROM combined_campaign_data;

-- 3.5. Total Social Media Conversions
-- Purpose: Calculate the total number of conversions driven by social media campaigns.
-- Insight: Provides a measure of the effectiveness of social media marketing.
SELECT SUM(CAST(social_conversions AS INT)) AS total_social_conversions
FROM combined_campaign_data;

-- 3.6. Conversion Rate for Email Campaigns
-- Purpose: Calculate the conversion rate for email campaigns (conversions / users reached).
-- Insight: Shows the efficiency of email marketing in converting users.
SELECT
    CAST(SUM(CAST(email_conversions AS INT)) AS REAL) / COUNT(DISTINCT CASE WHEN email_opens = 1 THEN user_id END) AS email_conversion_rate
FROM
    combined_campaign_data;

	-- 3.7. Conversion Rate for Social Media Campaigns
-- Purpose: Calculate the conversion rate for social media campaigns (conversions / users reached).
-- Insight: Shows the efficiency of social media marketing in converting users.
SELECT
    CAST(SUM(CAST(social_conversions AS INT)) AS REAL) / COUNT(DISTINCT CASE WHEN social_impressions > 0 THEN user_id END) AS social_conversion_rate
FROM
    combined_campaign_data;

	-- 3.8. Conversion Rate by Customer Segment (Email)
-- Purpose: Analyze if social has higher effect for all segments
-- Insight: Helps understand where people are buying from
SELECT   customer_segment,
         SUM(CAST(email_conversions AS INT)) AS total_email_conversions,
         SUM(CAST(social_conversions AS INT)) AS total_social_conversions
    FROM   combined_campaign_data
GROUP BY   customer_segment;
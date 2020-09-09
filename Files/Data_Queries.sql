--Queries File

--How can you isolate (or group) the transactions of each cardholder?
select transaction.date as "Date",
	   card_holder.name as "Name",
	   credit_card.card as "Credit Card Number",
	   transaction.amount as "Amount",
	   merchant_category.name as "Category",
	   merchant.name as "Location"
	   
From card_holder 
inner join credit_card ON card_holder.id = credit_card.id_card_holder
inner join transaction on credit_card.card = transaction.card
inner join merchant on transaction.id_merchant = merchant.id
inner join merchant_category on merchant.id_merchant_category = merchant_category.id;

--Consider the time period 7:00 a.m. to 9:00 a.m:
--     1. What are the 100 highest transactions during this time period?
        select transaction.date as "Date",
               card_holder.name as "Name",
               credit_card.card as "Credit Card Number",
               transaction.amount as "Amount",
               merchant_category.name as "Category",
               merchant.name as "Location" 
        
        From card_holder 
        inner join credit_card ON card_holder.id = credit_card.id_card_holder
        inner join transaction on credit_card.card = transaction.card
        inner join merchant on transaction.id_merchant = merchant.id
        inner join merchant_category on merchant.id_merchant_category = merchant_category.id
        WHERE Extract(HOUR FROM Date) >= 7 AND Extract(HOUR FROM Date) < 9
        order by Amount DESC Limit 100;

--      2. Do you see any fraudulent or anomalous transactions? If you answered yes to the 
--         previous question, explain why you think there might be fraudulent transactions during 
--         this time frame.
      
--          Yes, there is suspicious activity among the top 9 of this list because they have spent
--          between $1000 and $2000 at bars and restaurants from 7am to 9am. It is suspicious that 
--          anyone would spend this much at an establishment that, more often than not, is closed 
--          during these early hours. Moreover, we see that Robert Johnson has repeated this type 
--          transaction three times within a 3 month period therefore he raises the most flags.

--Some fraudsters hack a credit card by making several small payments (generally less than $2.00), 
--which are typically ignored by cardholders. Count the transactions that are less than $2.00 per 
--cardholder. 
SELECT card_holder.name as "Name",
	   Count(transaction.amount) as "Count"
	     
From card_holder 
inner join credit_card ON card_holder.id = credit_card.id_card_holder
inner join transaction on credit_card.card = transaction.card
WHERE Amount < 2
Group BY card_holder.name
Order by "Count" DESC;
--Is there any evidence to suggest that a credit card has been hacked? Explain your 
--rationale.

--  It is very hard to determine this information from simply looking at the transaction
--  count. However, I saw that Megan Price had the most transactions under $2, so I 
--  further investigated into these 26 low transaction amounts. When looking into the times 
--  these transactions were made, I found that it is very likely that her credit card has 
--  been hacked since some of these transactions take place at midnight during 4am to 6am.
--  Moreover, the transacitions that take place at night in bars and restaurants also indicate
--  that someone is taking out small increments since it is very hard to spend $0.7 at a bar 
--  restaurant.
SELECT card_holder.name as "Name",
	   transaction.date as "Dates",
	   transaction.amount as "Count",
	   merchant_category.name as "Category",
	   merchant.name as "Location"
	   	     
From card_holder 
inner join credit_card ON card_holder.id = credit_card.id_card_holder
inner join transaction on credit_card.card = transaction.card
inner join merchant on transaction.id_merchant = merchant.id
inner join merchant_category on merchant.id_merchant_category = merchant_category.id
WHERE card_holder.name = 'Megan Price' AND transaction.amount < 2
order by transaction.date;

--What are the top five merchants prone to being hacked using small transactions?

--  Top 5 merchants prone to being hacked are Wood-Ramirez, Hood-Phillips, Baker Inc, 
--  Jarvis-Turner, and Clark & Sons. 
SELECT merchant_category.name as "Category",
	   merchant.name as "Merchant",
	   count(transaction.amount) as "Count"
	      	     
From transaction 
inner join merchant on transaction.id_merchant = merchant.id
inner join merchant_category on merchant.id_merchant_category = merchant_category.id
WHERE transaction.amount < 2
group by "Merchant", "Category"
order by "Count" DESC;

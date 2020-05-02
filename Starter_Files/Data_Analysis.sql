--How can you isolate (or group) the transactions of each cardholder?
SELECT credit_card.id_card_holder,
       transaction.date,
	   transaction.card,
       transaction.amount
FROM card_holder LEFT JOIN credit_card ON card_holder.id = credit_card.id_card_holder
LEFT JOIN transaction ON credit_card.card = transaction.card
order by id_card_holder ASC;

--Consider the time period 7:00 a.m. to 9:00 a.m. What are the 100 highest transactions during this time period?



--Do you see any fraudulent or anomalous transactions?


--If you answered yes to the previous question, explain why you think there might be fraudulent transactions during this time frame.




--Some fraudsters hack a credit card by making several small payments (generally less than $2.00), which are typically ignored by cardholders. Count the transactions that are less than $2.00 per cardholder. Is there any evidence to suggest that a credit card has been hacked? Explain your rationale.


--What are the top five merchants prone to being hacked using small transactions?


--Once you have a query that can be reused, create a view for each of the previous queries.

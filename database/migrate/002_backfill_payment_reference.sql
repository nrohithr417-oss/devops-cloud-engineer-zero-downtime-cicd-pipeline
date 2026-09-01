UPDATE payments
SET payment_reference = 'PAY-' || transaction_id
WHERE payment_reference IS NULL;
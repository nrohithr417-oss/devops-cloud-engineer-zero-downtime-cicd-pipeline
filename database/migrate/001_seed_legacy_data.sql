INSERT INTO payments
    (transaction_id, amount, currency, status, customer_name)
VALUES
    ('TXN-1001', 1500.00, 'INR', 'SUCCESS', 'Customer One'),
    ('TXN-1002', 2500.00, 'INR', 'SUCCESS', 'Customer Two'),
    ('TXN-1003', 750.00, 'INR', 'PENDING', 'Customer Three')
ON CONFLICT (transaction_id) DO NOTHING;
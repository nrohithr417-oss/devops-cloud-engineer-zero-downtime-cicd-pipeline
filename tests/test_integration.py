from fastapi.testclient import TestClient
from application.main import app

client = TestClient(app)


def test_payment_end_to_end_flow():
    # Step 1: Verify service health
    health_response = client.get("/health")

    assert health_response.status_code == 200
    assert health_response.json()["status"] == "healthy"

    # Step 2: Verify service readiness
    ready_response = client.get("/ready")

    assert ready_response.status_code == 200
    assert ready_response.json()["status"] == "ready"

    # Step 3: Create a payment
    payment_request = {
        "source_account": "ACC10001",
        "destination_account": "ACC20001",
        "amount": 2500.00,
        "currency": "INR",
    }

    create_response = client.post(
        "/api/v1/payments",
        json=payment_request,
    )

    assert create_response.status_code == 200

    payment = create_response.json()

    assert payment["source_account"] == "ACC10001"
    assert payment["destination_account"] == "ACC20001"
    assert payment["amount"] == 2500.00
    assert payment["currency"] == "INR"
    assert payment["status"] == "SUCCESS"
    assert "payment_id" in payment

    # Step 4: Retrieve the created payment
    payment_id = payment["payment_id"]

    get_response = client.get(
        f"/api/v1/payments/{payment_id}"
    )

    assert get_response.status_code == 200

    retrieved_payment = get_response.json()

    assert retrieved_payment["payment_id"] == payment_id
    assert retrieved_payment["status"] == "SUCCESS"
    assert retrieved_payment["amount"] == 2500.00


def test_payment_not_found():
    response = client.get(
        "/api/v1/payments/non-existing-payment-id"
    )

    assert response.status_code == 404
    assert response.json()["detail"] == "Payment not found"
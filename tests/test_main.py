from fastapi.testclient import TestClient
from application.main import app


client = TestClient(app)


def test_health():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.json()["status"] == "healthy"


def test_readiness():
    response = client.get("/ready")

    assert response.status_code == 200
    assert response.json()["status"] == "ready"


def test_create_payment():

    payload = {
        "source_account": "ACC10001",
        "destination_account": "ACC20001",
        "amount": 5000,
        "currency": "INR",
    }

    response = client.post(
        "/api/v1/payments",
        json=payload,
    )

    assert response.status_code == 200

    data = response.json()

    assert data["status"] == "SUCCESS"
    assert data["amount"] == 5000
    assert "payment_id" in data


def test_invalid_payment_amount():

    payload = {
        "source_account": "ACC10001",
        "destination_account": "ACC20001",
        "amount": -100,
        "currency": "INR",
    }

    response = client.post(
        "/api/v1/payments",
        json=payload,
    )

    assert response.status_code == 422
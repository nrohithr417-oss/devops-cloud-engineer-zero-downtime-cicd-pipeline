from fastapi.testclient import TestClient

from application.main import app

client = TestClient(app)


def test_create_payment_contract():
    request_payload = {
        "source_account": "ACC10001",
        "destination_account": "ACC20001",
        "amount": 1500.00,
        "currency": "INR",
    }

    response = client.post(
        "/api/v1/payments",
        json=request_payload,
    )

    assert response.status_code == 200

    data = response.json()

    expected_fields = {
        "payment_id",
        "source_account",
        "destination_account",
        "amount",
        "currency",
        "status",
    }

    assert set(data.keys()) == expected_fields

    assert isinstance(data["payment_id"], str)
    assert isinstance(data["source_account"], str)
    assert isinstance(data["destination_account"], str)
    assert isinstance(data["amount"], (int, float))
    assert isinstance(data["currency"], str)
    assert isinstance(data["status"], str)

    assert data["source_account"] == request_payload["source_account"]
    assert data["destination_account"] == request_payload["destination_account"]
    assert data["amount"] == request_payload["amount"]
    assert data["currency"] == "INR"
    assert data["status"] == "SUCCESS"


def test_get_payment_contract():
    create_payload = {
        "source_account": "ACC30001",
        "destination_account": "ACC40001",
        "amount": 999.99,
        "currency": "INR",
    }

    create_response = client.post(
        "/api/v1/payments",
        json=create_payload,
    )

    assert create_response.status_code == 200

    payment_id = create_response.json()["payment_id"]

    response = client.get(
        f"/api/v1/payments/{payment_id}"
    )

    assert response.status_code == 200

    data = response.json()

    expected_fields = {
        "payment_id",
        "source_account",
        "destination_account",
        "amount",
        "currency",
        "status",
    }

    assert set(data.keys()) == expected_fields

    assert data["payment_id"] == payment_id
    assert data["status"] == "SUCCESS"


def test_health_contract():
    response = client.get("/health")

    assert response.status_code == 200
    assert response.headers["content-type"].startswith(
        "application/json"
    )

    data = response.json()

    assert set(data.keys()) == {"status"}
    assert data["status"] == "healthy"
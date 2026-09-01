from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, Field
from prometheus_client import Counter, generate_latest, CONTENT_TYPE_LATEST
from fastapi.responses import Response
from uuid import uuid4
from typing import Dict


app = FastAPI(
    title="NovaPay Digital Bank Payment API",
    description="Sample payment service for Zero Downtime CI/CD Assessment",
    version="1.0.0",
)


PAYMENT_COUNTER = Counter(
    "novapay_payments_total",
    "Total number of payment requests",
)


class PaymentRequest(BaseModel):
    source_account: str = Field(..., min_length=5)
    destination_account: str = Field(..., min_length=5)
    amount: float = Field(..., gt=0)
    currency: str = Field(default="INR", min_length=3, max_length=3)


class PaymentResponse(BaseModel):
    payment_id: str
    source_account: str
    destination_account: str
    amount: float
    currency: str
    status: str


payments: Dict[str, PaymentResponse] = {}


@app.get("/")
def root():
    return {
        "service": "NovaPay Payment API",
        "version": "1.0.0",
        "status": "running",
    }


@app.get("/health")
def health():
    return {
        "status": "healthy",
    }


@app.get("/ready")
def readiness():
    return {
        "status": "ready",
    }


@app.post("/api/v1/payments", response_model=PaymentResponse)
def create_payment(payment: PaymentRequest):

    payment_id = str(uuid4())

    result = PaymentResponse(
        payment_id=payment_id,
        source_account=payment.source_account,
        destination_account=payment.destination_account,
        amount=payment.amount,
        currency=payment.currency.upper(),
        status="SUCCESS",
    )

    payments[payment_id] = result

    PAYMENT_COUNTER.inc()

    return result


@app.get("/api/v1/payments/{payment_id}", response_model=PaymentResponse)
def get_payment(payment_id: str):

    payment = payments.get(payment_id)

    if not payment:
        raise HTTPException(
            status_code=404,
            detail="Payment not found",
        )

    return payment


@app.get("/metrics")
def metrics():

    return Response(
        generate_latest(),
        media_type=CONTENT_TYPE_LATEST,
    )
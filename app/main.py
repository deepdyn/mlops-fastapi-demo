from fastapi import FastAPI
from pydantic import BaseModel

app = FastAPI(title="Tiny ML API", version="0.1.0")

class InferenceRequest(BaseModel):
    x: float
    y: float | None = None

@app.get("/healthz")
def healthz():
    return {"status": "ok"}

# "Model": a tiny deterministic function so we focus on infra, not ML details
def tiny_model(x: float, y: float | None) -> float:
    return 2.0 * x + (y or 0.0)

@app.post("/predict")
def predict(req: InferenceRequest):
    return {"prediction": tiny_model(req.x, req.y)}

# Small, production-friendly base
FROM python:3.11-slim

# System hygiene
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Workdir inside the image
WORKDIR /app

# Install deps first to maximize build cache
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy only the app code
COPY app ./app

# Use a non-root user for better security
RUN useradd -m appuser
USER appuser

# Cloud Run will set $PORT; default to 8080 for local use
ENV PORT=8080
EXPOSE 8080

# Start the server
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8080"]

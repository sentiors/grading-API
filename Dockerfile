FROM python:3.10-slim

# Set workdir
WORKDIR /opt/grading

# System deps (opsional, buat debugging dan sqlite CLI)
RUN apt-get update && apt-get install -y --no-install-recommends \
    sqlite3 curl jq && \
    rm -rf /var/lib/apt/lists/*

# Copy requirements dan install
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy source code + db.sqlite
COPY . .

# Expose port internal container
EXPOSE 8000

# Command jalankan Gunicorn, pakai app.api:app
CMD ["gunicorn", "--workers", "3", "--bind", "0.0.0.0:8000", "app.api:app"]

# syntax=docker/dockerfile:1
# Base image: slim python for smaller size. Ensure AMD64 platform.
FROM --platform=linux/amd64 python:3.10-slim

# Prevent Python from writing pyc files and buffering stdout/stderr
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

# Set work directory
WORKDIR /app

# Install system dependencies (none required for CPU-only PyMuPDF wheel)
# If additional system libraries are required, add them here.

# Install python dependencies first to leverage Docker cache
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy project source
COPY . .

# Create mount point directories (they will be over-mounted at runtime)
RUN mkdir -p /app/input /app/output

# Default command – process all PDFs in /app/input and write JSONs to /app/output
CMD ["python", "run_in_container.py"] 
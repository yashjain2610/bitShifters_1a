FROM --platform=linux/amd64 python:3.9-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y \
    libffi-dev \
    libssl-dev \
    fontconfig \
    fonts-dejavu-core \
    fonts-liberation \
    locales \
    libfreetype6-dev \
    libjpeg-dev \
    libopenjp2-7-dev \
    libfontconfig1-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up locale for proper Unicode handling
RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# Copy requirements first for better Docker caching
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy all source code
COPY . .

# Create input and output directories
RUN mkdir -p /app/input /app/output

# Set the main script as the entry point
CMD ["python", "main_pipeline_pdfs.py"] 
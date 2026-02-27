# Base image
FROM python:3.11-slim

# Environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Working directory
WORKDIR /app

# System dependencies install karo
RUN apt-get update && apt-get install -y \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Requirements copy karo
COPY requirements.txt /app/

# Dependencies install karo
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Project files copy karo
COPY . /app/

# Static files collect karo (optional but recommended)
RUN python manage.py collectstatic --noinput

# Port expose karo
EXPOSE 8000

# Gunicorn start command
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "projectname.wsgi:application"]

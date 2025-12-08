FROM python:3.10-slim

# Install system dependencies including PortAudio
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    libportaudio2 \
    portaudio19-dev \
    && rm -rf /var/lib/apt/lists/*

# Set work directory
WORKDIR /app

# Copy all files
COPY . .

# Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN pip install -r requirements.txt

# Install flash-attn (ignore failure on CPU machines)
RUN pip install flash-attn --no-build-isolation || true

# Install your app
RUN python setup.py install

# Expose port for FastAPI
EXPOSE 8000

# Start server
CMD ["python", "main.py"]

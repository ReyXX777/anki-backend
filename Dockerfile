# Use Alpine instead of Ubuntu (Lightweight)
FROM alpine:latest

# Set environment variables to reduce memory usage
ENV PYTHONUNBUFFERED=1 \
    PYTHONMALLOC=malloc \
    DEBIAN_FRONTEND=noninteractive

# Install dependencies (Minimal Install)
RUN apk add --no-cache \
    python3 py3-pip xvfb wget bash \
    && rm -rf /var/cache/apk/*

# Install Anki (Low-memory Setup)
RUN wget https://github.com/ankitects/anki/releases/download/2.1.54/anki-2.1.54-linux-qt6.tar.zst && \
    tar --use-compress-program=unzstd -xf anki-2.1.54-linux-qt6.tar.zst && \
    mv anki-2.1.54-linux-qt6 /opt/anki && \
    rm -rf anki-2.1.54-linux-qt6.tar.zst

# Install Python dependencies (Minimize cache usage)
COPY requirements.txt /app/requirements.txt
RUN pip3 install --no-cache-dir -r /app/requirements.txt

# Copy application source code
WORKDIR /app
COPY . /app

# Expose API port
EXPOSE 8000

# Start Anki and API
CMD ["bash", "start.sh"]

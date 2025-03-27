FROM ubuntu:latest

# Install dependencies
RUN apt update && apt install -y \
    python3 python3-pip wget xvfb

# Install Anki
RUN wget https://github.com/ankitects/anki/releases/download/2.1.54/anki-2.1.54-linux-qt6.tar.zst && \
    tar -xf anki-2.1.54-linux-qt6.tar.zst && \
    cd anki-2.1.54-linux-qt6 && \
    make install

# Install Python dependencies
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r /app/requirements.txt

# Copy source code
WORKDIR /app
COPY . /app

# Expose port
EXPOSE 8000

# Start Anki & API
CMD ["bash", "start.sh"]

# Use official Python image
FROM python:3.11

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install required system libraries
RUN apt-get update && apt-get install -y libaio1 unzip

# Copy Oracle Instant Client zip file from local project directory
COPY lib/instantclient-basic-linux.x64-23.8.0.25.04.zip /tmp/

# Extract and configure Oracle Instant Client
RUN unzip /tmp/instantclient-basic-linux.x64-23.8.0.25.04.zip -d /opt/oracle && \
    ln -s /opt/oracle/instantclient_23_8 /opt/oracle/instantclient && \
    rm /tmp/instantclient-basic-linux.x64-23.8.0.25.04.zip
    
# Set Oracle environment variables
ENV LD_LIBRARY_PATH=/opt/oracle/instantclient
ENV ORACLE_HOME=/opt/oracle/instantclient

# Copy application code into the container
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose Flask port
EXPOSE 5000

# Run the Flask app
CMD ["python", "oss.py"]

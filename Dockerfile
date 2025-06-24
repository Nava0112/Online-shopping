# Use official Python image
FROM python:3.11

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install required system libraries
RUN apt-get update && apt-get install -y libaio1 wget unzip

# Download and install Oracle Instant Client 23.8.0.25.04
RUN wget https://download.oracle.com/otn_software/linux/instantclient/2380000/instantclient-basic-linux.x64-23.8.0.25.04.zip && \
    unzip instantclient-basic-linux.x64-23.8.0.25.04.zip && \
    mv instantclient_23_8 /opt/oracle && \
    rm instantclient-basic-linux.x64-23.8.0.25.04.zip

# Configure Oracle client environment
ENV LD_LIBRARY_PATH=/opt/oracle
ENV ORACLE_HOME=/opt/oracle

# Copy application files
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Expose Flask port
EXPOSE 5000

# Run the Flask app
CMD ["python", "oss.py"]
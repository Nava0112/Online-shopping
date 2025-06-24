# Use official Python image
FROM python:3.10

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Set working directory
WORKDIR /app

# Install OS dependencies for cx_Oracle
RUN apt-get update && apt-get install -y libaio1 unzip

# Copy your Oracle Instant Client zip to image
COPY instantclient-basic-linux.x64-23.8.0.25.04.zip .

# Unzip and install Oracle Instant Client
RUN unzip instantclient-basic-linux.x64-23.8.0.25.04.zip && \
    mv instantclient_23_8 /opt/oracle && \
    rm instantclient-basic-linux.x64-23.8.0.25.04.zip

# Set environment variables for Oracle Client
ENV LD_LIBRARY_PATH=/opt/oracle
ENV ORACLE_HOME=/opt/oracle

# Copy project files
COPY . /app

# Install Python dependencies
RUN pip install --upgrade pip 
RUN pip install -r requirements.txt

# Expose Flask port
EXPOSE 5000

# Run Flask app
CMD ["python", "oss.py"]

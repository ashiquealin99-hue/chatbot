# FROM python:3.10-slim-buster  
  
# WORKDIR /app  
  
# COPY requirements.txt requirements.txt  
  
# RUN python -m venv venv  
# ENV PATH="/app/venv/bin:$PATH"  

# RUN pip install --upgrade pip && \  
#     pip install --no-cache-dir -r requirements.txt  
  
# COPY . .

# RUN chmod -R 777 translations  
  
# CMD ["python3", "./run.py"]  

# Use a lightweight Python image
FROM python:3.10-slim-buster

# Set working directory
WORKDIR /app

# Copy and install dependencies first (cached layer)
COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the rest of your project files
COPY . .

# Make sure translations folder has write permissions
RUN chmod -R 777 translations || true

# Set a default port for the app (can be overridden)
ENV PORT=1338

# Expose the port your app listens on
EXPOSE ${PORT}

# Start the app with environment-based port
CMD ["sh", "-c", "python ./run.py --port $PORT"]

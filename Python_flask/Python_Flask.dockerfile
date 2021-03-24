# Start with Python default slim image.
FROM python:3.8-slim

# Add new user and create home directory.
ENV USER=flaskuser
RUN useradd --create-home $USER
ENV API_DIR=/home/$USER/api
WORKDIR $API_DIR

# Install packages via pip without cache.
COPY requirements.txt ./
RUN pip install --no-cache-dir --requirement requirements.txt

# Copy local files and required files.
COPY server.py ./
COPY entrypoint.sh ./
COPY gunicorn_config.py ./
COPY wsgi.py ./

# Set file permissions and default user.
RUN chown -R $USER:$USER $API_DIR \
    && chmod -R u=rw,g=r,o=r $API_DIR \
    && chmod -R a+X $API_DIR

USER $USER

# Set command to run.
ENV JCI_API_HOST=0.0.0.0
ENV JCI_API_PORT=5000
EXPOSE $JCI_API_PORT
ENV PYTHONPATH=$API_DIR

RUN chmod +x ./entrypoint.sh
ENTRYPOINT ["sh", "entrypoint.sh"]
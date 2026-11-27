FROM python:3.11-slim
WORKDIR /app
COPY app.py .
ARG APP_VERSION=dev
RUN echo "$APP_VERSION" > VERSION
CMD ["python", "app.py"]

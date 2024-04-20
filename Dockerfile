FROM python:3.8-slim

WORKDIR /app

COPY api/ . 
COPY requirements.txt .

RUN pip install --no-cache-dir -r requirements.txt

ENV FLASK_RUN_HOST=0.0.0.0
ENV FLASK_RUN_PORT=8080
EXPOSE 8080

CMD ["flask", "run"]
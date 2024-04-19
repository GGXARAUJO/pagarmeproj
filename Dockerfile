FROM python:3.8-slim

WORKDIR /app

RUN pip install --no-cache-dir flask

COPY api/ . 

CMD ["flask", "run", "--host=0.0.0.0"]
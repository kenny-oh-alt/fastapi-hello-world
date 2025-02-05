# Use the official Python base image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Poetry lock file and pyproject.toml first to leverage Docker cache
COPY poetry.lock pyproject.toml ./

# Install Poetry
RUN pip install poetry

# Install dependencies
RUN poetry install --no-root --no-dev

# Copy the entire application code to the working directory
COPY app ./app
COPY global-bundle.pem ./

# Set the entrypoint for the application
CMD ["poetry", "run", "python", "-m", "app.main"]
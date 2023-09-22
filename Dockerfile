# Use a base image with Python
FROM python:3.9-slim

# Install mitmproxy
RUN pip install mitmproxy

# Expose the default mitmproxy port
EXPOSE 8180 8181

# Command to run mitmproxy
CMD ["mitmdump"]

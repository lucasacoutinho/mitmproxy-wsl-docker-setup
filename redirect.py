# redirect.py
def request(flow):
    # Check if the request URL matches a specific base URL
    if "google.com" in flow.request.pretty_url:
        # Change the base URL
        flow.request.host = "instagram.com"
        flow.request.scheme = "https"
        flow.request.port = 443

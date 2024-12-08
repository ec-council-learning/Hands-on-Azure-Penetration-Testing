import requests

# Get username input from the user
username = input("Enter the username: ")

# Create the JSON payload
body = '{"Username":"' + username + '"}'

# Send the HTTP POST request
response = requests.post("https://login.microsoftonline.com/common/GetCredentialType", data=body)

# Check if the request was successful
if response.status_code == 200:
    # Parse the JSON response
    data = response.json()
    # Check if the user exists
    if data.get("IfExistsResult") == 0:
        print("Valid User")
    else:
        print("Invalid User")
else:
    print(f"Failed to check user. Status code: {response.status_code}")

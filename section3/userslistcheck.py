import requests

# Open the file containing the usernames
with open('usernames.txt', 'r') as file:
    usernames = file.readlines()

# Iterate through each username in the file
for username in usernames:
    username = username.strip()  # Remove any whitespace characters

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
            print(f"Valid User: {username}")
        else:
            print(f"Invalid User: {username}")
    else:
        print(f"Failed to check user {username}. Status code: {response.status_code}")

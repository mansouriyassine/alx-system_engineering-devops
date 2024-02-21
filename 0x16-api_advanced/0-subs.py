#!/usr/bin/python3
"""
Module to query the Reddit API and return the number
of subscribers for a given subreddit
"""
import sys
import requests as r
import requests.auth as ra

def number_of_subscribers(subreddit):
    client_id = "F6ijbTc-PzNiNQD2sohpvA"
    secret = "V2OPLAqA0dUJGVdNNr2_6EM_Q0rCgw"
    username = "Forsaken_Tomorrow815"
    password = "ALXYASSINE2024"

    client_auth = ra.HTTPBasicAuth(client_id, secret)
    post_data = {"grant_type": "password", "username": username, "password": password}
    headers = {"User-Agent": "ChangeMeClient/0.1 by {}".format(username)}
    response = r.post("https://www.reddit.com/api/v1/access_token",
                      auth=client_auth, data=post_data, headers=headers)
    token = response.json().get("access_token")
    bearer = response.json().get("token_type")

    sub_url = "https://oauth.reddit.com/r/{}/about".format(subreddit)

    headers = {"Authorization": "{} {}".format(bearer, token),
               "User-Agent": "ChangeMeClient/0.1 by {}".format(username)}
    response = r.get(sub_url, headers=headers)

    if response.status_code != 200:
        return 0
    else:
        response_json = response.json().get('data')
        result = response_json.get('subscribers')
        return result

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python3 0-main.py <subreddit>")
        sys.exit(1)

    subreddit = sys.argv[1]
    print(number_of_subscribers(subreddit))

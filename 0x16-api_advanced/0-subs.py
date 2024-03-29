#!/usr/bin/python3
"""
Module to query the Reddit API and return the number
of subscribers for a given subreddit
"""
import requests


def number_of_subscribers(subreddit):
    url = ('https://www.reddit.com/r/'
           f'{subreddit}/about.json')
    headers = {
        'User-Agent': ('Python:subreddit.subscriber.counter:v1.0 '
                       '(by /u/yourusername)')
    }

    try:
        response = requests.get(url, headers=headers, allow_redirects=False)
        print("Status Code:", response.status_code)
        if response.status_code == 200:
            subscribers = response.json().get('data', {}).get('subscribers', 0)
            print("Subscribers:", subscribers)
            return subscribers
        else:
            print("Response:", response.text)
            return 0
    except requests.RequestException as e:
        print("Error:", e)
        return 0


if __name__ == '__main__':
    import sys

    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        print("{:d}".format(number_of_subscribers(sys.argv[1])))

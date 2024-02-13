#!/usr/bin/python3
"""
Module to query the Reddit API and print the titles of the first
10 hot posts listed for a given subreddit
"""
import requests


def top_ten(subreddit):
    """Prints the titles of the first 10 hot posts of a subreddit."""
    url = (
        'https://www.reddit.com/r/{}/hot.json?limit=10'
        .format(subreddit)
    )
    headers = {
        'User-Agent': (
            'Python:subreddit.top.ten:v1.0 '
            '(by /u/yourusername)'
        )
    }

    try:
        response = requests.get(url, headers=headers,
                                allow_redirects=False)
        if response.status_code == 200:
            posts = response.json().get('data', {})\
                                  .get('children', [])
            for post in posts:
                title = post.get('data', {}).get('title')
                print(title)
        else:
            print(None)
    except requests.RequestException:
        print(None)


if __name__ == '__main__':
    import sys

    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        top_ten(sys.argv[1])

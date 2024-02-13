#!/usr/bin/python3
"""
Module to recursively query the Reddit API and return a list of titles
of all hot articles for a given subreddit.
"""
import requests


def recurse(subreddit, hot_list=[], after=""):
    """Recursively queries Reddit API for all hot article titles."""
    url = (
        'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    )
    headers = {
        'User-Agent': 'Python:subreddit.recursive:v1.0 (by /u/yourusername)'
    }
    params = {'limit': 100, 'after': after}

    try:
        response = requests.get(url, headers=headers, params=params,
                                allow_redirects=False)
        if response.status_code != 200:
            return None

        data = response.json().get('data')
        after = data.get('after')
        posts = data.get('children', [])

        for post in posts:
            hot_list.append(post.get('data', {}).get('title'))

        if after is not None:
            return recurse(subreddit, hot_list, after)
        return hot_list
    except requests.RequestException:
        return None


if __name__ == '__main__':
    import sys

    if len(sys.argv) < 2:
        print("Please pass an argument for the subreddit to search.")
    else:
        result = recurse(sys.argv[1])
        if result is not None:
            print(len(result))
        else:
            print("None")

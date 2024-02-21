#!/usr/bin/python3
"""
Module to query the Reddit API and return the number
of subscribers for a given subreddit
"""
import requests


def number_of_subscribers(subreddit):
    """Returns the number of subscribers for a given subreddit."""
    user_agent = ("Python:SubredditSubscribers:v1.0 "
                  "(by /u/yourusername)")
    headers = {"User-Agent": user_agent}
    base_url = "https://www.reddit.com/r/"
    about_ext = "/about.json"
    url = f"{base_url}{subreddit}{about_ext}"
    response = requests.get(url, headers=headers, allow_redirects=False)

    if response.status_code == 200:
        data = response.json().get("data")
        subscribers = data.get("subscribers")
        return subscribers
    else:
        return 0

#!/usr/bin/python3
"""
Module to recursively query the Reddit API, parse titles of all hot
articles, and print a sorted count of given keywords.
"""
import requests


def count_words(subreddit, word_list, after='', word_counts={}):
    if not after:
        for word in word_list:
            word_counts[word.lower()] = 0
    url = 'https://www.reddit.com/r/{}/hot.json'.format(subreddit)
    headers = {
        'User-Agent': 'Python:subreddit.word.counter:v1.0 (by /u/yourusername)'
    }
    params = {'limit': 100, 'after': after}

    response = requests.get(url, headers=headers, params=params,
                            allow_redirects=False)
    if response.status_code != 200:
        return

    data = response.json().get('data')
    after = data.get('after')
    posts = data.get('children', [])

    for post in posts:
        title = post.get('data', {}).get('title').lower()
        for word in word_list:
            word_counts[word.lower()] += title.split().count(word.lower())

    if after is not None:
        count_words(subreddit, word_list, after, word_counts)
    else:
        sorted_words = sorted(word_counts.items(), key=lambda x: (-x[1], x[0]))
        for word, count in sorted_words:
            if count > 0:
                print('{}: {}'.format(word, count))


if __name__ == '__main__':
    import sys

    if len(sys.argv) < 3:
        print("Usage: {} <subreddit> <list of keywords>".format(
            sys.argv[0]))
        sys.exit(1)

    word_list = sys.argv[2].split()
    count_words(sys.argv[1], word_list)

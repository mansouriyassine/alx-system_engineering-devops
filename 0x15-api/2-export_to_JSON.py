#!/usr/bin/python3
"""
This module uses the JSONPlaceholder API to fetch the TODO list of an
employee based on their ID and exports it to a JSON file. It retrieves
the employee's task information and exports it in a JSON format with
each task represented as a dictionary in a list under the employee's ID.

The script accepts an employee ID as a command-line argument and creates
a JSON file named after the user's ID containing their TODO list.

Usage:
    python3 2-export_to_JSON.py [employee_id]
    example: python3 2-export_to_JSON.py 2
"""

import json
import requests
import sys


def get_employee_info(user_id):
    """Fetches the user's information including username."""
    response = requests.get(
        f'https://jsonplaceholder.typicode.com/users/{user_id}'
    )
    user = response.json()
    return user.get('username'), user.get('id')


def get_todo_list(user_id):
    """Fetches the TODO list for a given user ID."""
    response = requests.get(
        f'https://jsonplaceholder.typicode.com/users/{user_id}/todos'
    )
    return response.json()


def export_to_json(user_id, username, todos):
    """Exports the TODO list data to a JSON file."""
    tasks = [
        {
            "task": todo['title'],
            "completed": todo['completed'],
            "username": username
        }
        for todo in todos
    ]
    with open(f'{user_id}.json', 'w') as file:
        json.dump({str(user_id): tasks}, file)


def main(user_id):
    """Main function to fetch data and export to JSON."""
    username, user_id = get_employee_info(user_id)
    todos = get_todo_list(user_id)
    export_to_json(user_id, username, todos)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        try:
            user_id = int(sys.argv[1])
            main(user_id)
        except ValueError:
            print("Please provide a valid integer for the employee ID.")
    else:
        print("Employee ID not provided.")

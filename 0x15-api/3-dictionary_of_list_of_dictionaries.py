#!/usr/bin/python3
"""
This script fetches the TODO list of all employees from the JSONPlaceholder
API and exports the data to a JSON file named todo_all_employees.json.
Each user's tasks are stored in a dictionary under their user ID.
"""

import json
import requests


def fetch_all_users():
    """Fetches a list of all users."""
    response = requests.get('https://jsonplaceholder.typicode.com/users')
    return response.json()


def fetch_todos_for_user(user_id):
    """Fetches TODO list for a given user ID."""
    response = requests.get(
        f'https://jsonplaceholder.typicode.com/users/{user_id}/todos'
    )
    return response.json()


def export_to_json(users):
    """Exports users' TODO lists to a JSON file."""
    all_todos = {}
    for user in users:
        user_id = user['id']
        username = user['username']
        todos = fetch_todos_for_user(user_id)
        all_todos[user_id] = [
            {"username": username, "task": todo['title'], 
             "completed": todo['completed']} 
            for todo in todos
        ]
    
    with open('todo_all_employees.json', 'w') as file:
        json.dump(all_todos, file)


def main():
    """Main function to orchestrate data fetching and exporting."""
    users = fetch_all_users()
    export_to_json(users)


if __name__ == "__main__":
    main()

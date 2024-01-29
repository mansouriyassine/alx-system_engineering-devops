#!/usr/bin/python3
"""
This script uses the JSONPlaceholder API to fetch and display the TODO
list progress of an employee based on their ID. It outputs the employee's
name, the number of completed tasks, and the titles of these tasks.
"""

import requests
import sys


def get_employee_name(user_id):
    """Fetches the name of the employee with the given user ID."""
    response = requests.get(
        f'https://jsonplaceholder.typicode.com/users/{user_id}'
    )
    user = response.json()
    return user.get('name')


def get_todo_list_progress(user_id):
    """Fetches the TODO list for a given user ID and calculates progress."""
    response = requests.get(
        f'https://jsonplaceholder.typicode.com/users/{user_id}/todos'
    )
    todos = response.json()
    total_tasks = len(todos)
    completed_tasks = sum(1 for task in todos if task.get('completed'))
    completed_titles = [
        task['title'] for task in todos if task.get('completed')
    ]
    return completed_tasks, total_tasks, completed_titles


def main(user_id):
    """Main function to display the TODO list progress."""
    employee_name = get_employee_name(user_id)
    completed, total, titles = get_todo_list_progress(user_id)

    print(f"Employee {employee_name} is done with tasks({completed}/{total}):")
    for title in titles:
        print(f"\t {title}")


if __name__ == "__main__":
    if len(sys.argv) > 1:
        try:
            user_id = int(sys.argv[1])
            main(user_id)
        except ValueError:
            print("Please provide a valid integer for the employee ID.")
    else:
        print("Employee ID not provided.")

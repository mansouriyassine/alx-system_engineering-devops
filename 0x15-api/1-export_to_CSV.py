#!/usr/bin/python3
"""
This module uses the JSONPlaceholder API to fetch the TODO list of an
employee based on their ID and exports it to a CSV file. It retrieves
the employee's task information and exports it in a CSV format with
the structure "USER_ID","USERNAME","TASK_COMPLETED_STATUS","TASK_TITLE".

The script accepts an employee ID as a command-line argument and creates
a CSV file named after the user's ID containing their TODO list.

Usage:
    python3 1-export_to_CSV.py [employee_id]
    example: python3 1-export_to_CSV.py 2
"""

import csv
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


def export_to_csv(user_id, username, todos):
    """Exports the TODO list data to a CSV file."""
    with open(f'{user_id}.csv', mode='w', newline='') as file:
        writer = csv.writer(file, quoting=csv.QUOTE_ALL)
        for todo in todos:
            writer.writerow(
                [user_id, username, todo['completed'], todo['title']]
            )


def main(user_id):
    """Main function to fetch data and export to CSV."""
    username, user_id = get_employee_info(user_id)
    todos = get_todo_list(user_id)
    export_to_csv(user_id, username, todos)


if __name__ == "__main__":
    if len(sys.argv) > 1:
        try:
            user_id = int(sys.argv[1])
            main(user_id)
        except ValueError:
            print("Please provide a valid integer for the employee ID.")
    else:
        print("Employee ID not provided.")

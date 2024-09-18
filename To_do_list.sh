#!/bin/bash

# Define the file where tasks will be stored
todo_file="todo.txt"

# Function to display the menu
show_menu() {
    echo "To-Do List Menu:"
    echo "1. Add a task"
    echo "2. View tasks"
    echo "3. Remove a task"
    echo "4. Exit"
}

# Function to add a task
add_task() {
    read -p "Enter the task description: " task
    echo "$task" >> "$todo_file"
    echo "Task added."
}

# Function to view tasks
view_tasks() {
    if [ -s "$todo_file" ]; then
        echo "Tasks:"
        cat "$todo_file"
    else
        echo "No tasks found."
    fi
}

# Function to remove a task
remove_task() {
    if [ -s "$todo_file" ]; then
        echo "Select the task number to remove:"
        awk '{print NR ": " $0}' "$todo_file"
        read -p "Enter the task number: " task_num
        sed -i "${task_num}d" "$todo_file"
        echo "Task removed."
    else
        echo "No tasks to remove."
    fi
}

# Main script loop
while true; do
    show_menu
    read -p "Choose an option (1-4): " choice
    case $choice in
        1) add_task ;;
        2) view_tasks ;;
        3) remove_task ;;
        4) echo "Exiting. Goodbye!" ; exit 0 ;;
        *) echo "Invalid option. Please choose a number between 1 and 4." ;;
    esac
done

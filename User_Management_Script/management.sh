#!/bin/bash

# create a new user
create_user() {
    read -p "Enter username: " username
    if id "$username" &>/dev/null; then
        echo "User $username already exists!"
    else
        sudo useradd -m "$username"
        sudo passwd "$username"
        echo "User $username created successfully!"
    fi
}

# delete a user
delete_user() {
    read -p "Enter username to delete: " username
    if id "$username" &>/dev/null; then
        sudo userdel -r "$username"
        echo "User $username deleted!"
    else
        echo "User $username does not exist!"
    fi
}

# list all users
list_users() {
    cut -d: -f1 /etc/passwd | nl
}

# lock a user
lock_user() {
    read -p "Enter username to lock: " username
    if id "$username" &>/dev/null; then
        sudo usermod -L "$username"
        echo "User $username has been locked!"
    else
        echo "User $username does not exist!"
    fi
}

# unlock a user
unlock_user() {
    read -p "Enter username to unlock: " username
    if id "$username" &>/dev/null; then
        sudo usermod -U "$username"
        echo "User $username has been unlocked!"
    else
        echo "User $username does not exist!"
    fi
}

#Output
while true; do
    echo "============================"
    echo "Dreamline User Management Tool "
    echo "============================"
    echo "1️⃣ Create User"
    echo "2️⃣ Delete User"
    echo "3️⃣ List Users"
    echo "4️⃣ Lock User"
    echo "5️⃣ Unlock User"
    echo "6️⃣ Exit"
    read -p "Select an option (1-6): " option

    case $option in
        1) create_user ;;
        2) delete_user ;;
        3) list_users ;;
        4) lock_user ;;
        5) unlock_user ;;
        6) echo "Exiting..."; break ;;
        *) echo "Invalid option! Try again." ;;
    esac
done


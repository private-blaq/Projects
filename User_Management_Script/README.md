Automated Linux User Management Script

📌 Project Overview


## **🚀 Features**

✅ Create new users with passwords\
✅ Delete users and their home directories\
✅ List all system users\
✅ Lock/unlock user accounts for security\
✅ Menu-driven interface for easy use

## 🛠 Prerequisites

- A Linux system (Ubuntu, Debian, CentOS, etc.)
- Bash shell (default on Linux)
- Root or sudo access


Create a new script file and open it for editing:

nano user_manager.sh

#!/bin/bash

# Function to create a new user
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

# Function to list all users
list_users() {
    cut -d: -f1 /etc/passwd | nl
}

# Function to lock a user
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

# Display menu
while true; do
    echo "============================"
    echo " Linux User Management Tool "
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

### 2️⃣ Make the Script Executable


chmod +x user_manager.sh


### **3️⃣ Run the Script**


./user_manager.sh

============================
Dreamline User Management Tool
============================
1️⃣ Create User
2️⃣ Delete User
3️⃣ List Users
4️⃣ Lock User
5️⃣ Unlock User
6️⃣ Exit
Select an option (1-6):

- Enter `1` to create a new user.
- Enter `2` to delete a user.
- Enter `3` to list all system users.
- Enter `4` to lock a user.
- Enter `5` to unlock a user.
- Enter `6` to exit the program.





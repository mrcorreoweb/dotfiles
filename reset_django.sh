#!/usr/bin/env bash

# Script to reset the Django database and migrations.
# Usage: reset_django.sh app1 [app2 ...]


# Check if at least one app name is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 app1 [app2 ...]"
    exit 1
fi

# Function to find the manage.py file and change to its directory
find_manage_py() {
    local manage_py_path=$(find . -name manage.py -print -quit)
    if [ -z "$manage_py_path" ]; then
    echo "Error: manage.py not found in the current directory tree."
    exit 1
    fi
    cd "$(dirname "$manage_py_path")"
}

# Function to remove migration files
remove_migrations() {
    local app=$1
    echo "Removing migrations for $app..."
    find . -path "./$app/migrations/*.py" -not -name "__init__.py" -delete
    find . -path "./$app/migrations/*.pyc" -delete
}

# Find the manage.py file and change to its directory
echo "Finding manage.py..."
find_manage_py

# Remove the database
echo "Removing database..."
rm -f db.sqlite3

# Remove migrations for each app
for app in "$@"
do
    remove_migrations $app
done

# Make new migrations
echo "Creating new migrations..."
python manage.py makemigrations

# Apply migrations
echo "Applying migrations..."
python manage.py migrate

echo "Database and migrations reset complete!"

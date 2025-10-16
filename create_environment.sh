#!/bin/bash
echo " --- Remindr. Environment setup ---"
read -p "Please enter your name (e.g., LeBron): " USER_NAME

if [ -z "$USER_NAME" ]; then 
echo "Error: Must input a name. Exiting."
exit 1
fi
APP_DIR="submission_reminder_${USER_NAME}"

if [ -d "$APP_DIR" ]; then 
echo "Warning: Directory '$APP_DIR' already exists. Resetting directory ..."
rm -rf "$APP_DIR"
fi
echo "Creating app root directory: $APP_DIR"
mkdir "$APP_DIR"

DIRS=("config" "modules" "assets" "bin")
for dir in "${DIRS[@]}"; do
mkdir -p "${APP_DIR}/${dir}"
done

echo "Simulating files ..."

cat > "${APP_DIR}/config/config.env" << 'EOF'
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF

cat > "${APP_DIR}/modules/functions.sh" << 'EOF'
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF

cat > "${APP_DIR}/bin/reminder.sh" << 'EOF'
#!/bin/bash


# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions "$submissions_file"
EOF

cat > "${APP_DIR}/assets/submissions.txt" << 'EOF'

student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
EOF

cat > "${APP_DIR}/startup.sh" << 'EOF'
#!/bin/bash

APP_ROOT=$(dirname "$0")

echo "---------------------------------------------------"
echo "  Starting Remindr, the Assignment Reminder App"
echo "---------------------------------------------------"


if [ -x "$APP_ROOT/bin/reminder.sh" ]; then
    (cd "$APP_ROOT" && ./bin/reminder.sh)
else
    echo "Error: The main application script ($APP_ROOT/bin/reminder.sh) is missing or not executable."
fi

echo "Application finished."
EOF

echo "Setting executable permissions for all .sh files..."
find "${APP_DIR}" -name "*.sh" -exec chmod +x {} \;

echo "Environment successfully created in: ./${APP_DIR}"
echo "Run the application using: ./${APP_DIR}/startup.sh"
echo "---------------------------------------------------"





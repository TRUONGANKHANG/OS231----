#!/bin/bash

# Initialize ANS variable with 0
ANS=0
# Initialize array to store calculation history
HISTORY=()

# Function to display the prompt for entering a calculation
display_prompt() {
    echo -n ">> "
}

# Function to display syntax error message
syntax_error() {
    echo "SYNTAX ERROR"
}

# Function to display math error message
math_error() {
    echo "MATH ERROR"
}

# Function to display calculation history
display_history() {
    echo "History:"
    for ((i=0; i<${#HISTORY[@]}; i++)); do
        echo "$(($i + 1)). ${HISTORY[$i]}"
    done
}

# Main loop
while true; do
    display_prompt
    read input

    # Check if input is EXIT command
    if [ "$input" = "EXIT" ]; then
        exit 0
    fi

    # Check if input is HIST command
    if [ "$input" = "HIST" ]; then
        display_history
        continue
    fi

    # Replace ANS with the value stored in ANS variable
    input=$(echo "$input" | sed "s/ANS/$ANS/g")

    # Split input into operands and operator
    read num1 operator num2 <<< "$input"

    # Check if operator is valid
    case "$operator" in
        +|-|x|/|%) ;;
        *)
            syntax_error
            continue
            ;;
    esac

    # Perform calculation
    case "$operator" in
        +)
            result=$(printf "%.2f" $(echo "scale=10; $num1 + $num2" | bc))
            ;;
        -)
            result=$(printf "%.2f" $(echo "scale=10; $num1 - $num2" | bc))
            ;;
        x)
            result=$(printf "%.2f" $(echo "scale=10; $num1 * $num2" | bc))
            ;;
        /)
            if [ "$num2" = "0" ]; then
                math_error
                continue
            fi
            result=$(printf "%.2f" $(echo "scale=10; $num1 / $num2" | bc))
            ;;
        %)
            if [ "$num2" = "0" ]; then
                math_error
                continue
            fi
            result=$(printf "%.2f" $(echo "scale=10; $num1 % $num2" | bc))
            ;;
    esac

    # Update ANS variable
    ANS=$result
    # Add calculation to history
    HISTORY=("$input = $result" "${HISTORY[@]}")

    # Display result
    echo $result

done


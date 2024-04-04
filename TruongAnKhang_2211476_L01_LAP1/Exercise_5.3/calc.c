#include <stdio.h>
#include "calculator.h"

int main(){
    double num1, num2, result;
    char operator;

    printf("Enter first number, operator, and second number: ");
    scanf("%lf %c %lf", &num1, &operator, &num2);

    switch(operator) {
        case '+':
            result = add(num1, num2);
            break;
        case '-':
            result = subtract(num1, num2);
            break;
        case '*':
            result = multiply(num1, num2);
            break;
        case '/':
            result = divide(num1, num2);
            break;
        default:
            printf("Invalid operator\n");
            return 1;
    }

    printf("Result: %.2lf\n", result);

    return 0;
}


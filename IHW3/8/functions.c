#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <time.h>

#define precision 0.0005

double readValue() {
  double number;
  printf("Enter the x value to compute function: ");
  scanf("%lf", &number);
  if (number < -1 || number > 1) {
    printf("Function diverges with x = %lf, available values are (-1, 1).\n", number);
    exit(0);
  }
  return number;
}

double readValueFromFile(char **argv) {
  double number;
  FILE *file = fopen(argv[1], "r");
  fscanf(file, "%lf", &number);
  fclose(file);
  printf("End up reading file.\n");
  if (number < -1 || number > 1) {
    printf("Function diverges with x = %lf, available values are (-1, 1).\n", number);
    exit(0);
  }
  return number;
}

double computeResult(double number) {
  double result = 1;
  double remainder = 0.5 * number;
  int k = 2;
  while (fabs(remainder) >= precision) {
    result += remainder;
    remainder = pow(number, k) * pow(-1, k-1);
    int coef = 1;
    for (int i = 0; i < k-1; ++i) {
      remainder *= coef;
      ++coef;
      remainder /= coef;
      ++coef;
    }
    remainder /= ++coef;
    ++k;
  }
  return result;
}

void printResult(double result) {
  printf("Result: %lf\n", result);
}

void outputResultToFile(double result, char **argv) {
  FILE *file = fopen(argv[2], "w+");
  fprintf(file, "Result: %lf\n", result);
  fclose(file);
  printf("Result is in output file.\n");
}

double generateValue() {
  srand(time(0));
  double value;
  value = (double)rand()/RAND_MAX*1.999999-0.999999;
  printf("Generated number: %lf\n", value);
  return value;
}

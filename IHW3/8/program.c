#include <stdio.h>
#include "functions.h"
#include <stdlib.h>
#include <time.h>
#include <string.h>
int main(int argc, char **argv) {
  if (argc != 1 && argc != 3) {
    printf("Incorrect number of parameters.\n");
    return 1;
  }
  double number, result;
  if (argc == 1) {
    number = readValue();
  }
  if (argc == 3 && (strcmp(argv[1], "-s") == 0 || strcmp(argv[1], "-g") == 0)) {
    number = generateValue();
  } else if (argc == 3) {
   number =  readValueFromFile(argv);
  }
  clock_t start = clock();
  if (argc == 3 && strcmp(argv[1], "-s") == 0) {
    for (int i = 0; i < 3000000; ++i) {
      result = computeResult(number);
    }
  }
  result = computeResult(number);
  clock_t stop = clock();
  if (argc == 1) {
    printResult(result);
  }
  if (argc == 3) {
    outputResultToFile(result, argv);
  }
  double elapsed_time = (double)(stop-start) / CLOCKS_PER_SEC;
  printf("Elapsed time: %f\n", elapsed_time);
  return 0;
}


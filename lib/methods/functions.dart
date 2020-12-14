import 'dart:math';

double getRandomNumber(){
  double random = new Random().nextDouble();
  double result = 1 + (random * (100 - 1));
  return result;
}
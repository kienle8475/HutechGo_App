class CostCalcalationService {
  double costCalculation(double distance) {
    double price = 0;
    int d = distance.ceil();
    List<double> initPrice = [50, 70];
    List<double> nextPrice = [12, 12, 12, 8, 8, 8, 6];
    //List<double> overPrice = [600 , 800, 800, 800, 900];
    if (d <= 2) {
      price = initPrice[d - 1];
    } else if (d <= 8) {
      int dNext = d - 2;
      price = initPrice[1];
      for (int i = 0; i < dNext; i++) {
        price += nextPrice[i];
      }
    } else {
      price = initPrice[1];
      for (int i = 0; i < 6; i++) {
        price += nextPrice[i];
      }
      price += (d - 8) * nextPrice[6];
    }

    return (price / 10).roundToDouble() * 1000;
  }
}

/// Redondeo monetario único del dominio (2 decimales, half-up).
double roundMoney(double value) => (value * 100).roundToDouble() / 100;

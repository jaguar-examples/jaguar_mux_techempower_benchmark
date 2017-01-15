library bin.common;

import 'dart:math' show Random;

const String kPgUrl = 'postgres://postgres:dart_jaguar@localhost/postgres';

const int kWorldTableSize = 10000;

final Random kRandom = new Random();

const List<String> kFortunes = const <String>[
  "Today is a great day!",
  "Tomorrow is going to be even greater!",
  "Today its up to you to create the peacefulness you long for.",
  "A friend asks only for your time not your money.",
  "If you refuse to accept anything but the best, you very often get it.",
  "A smile is your passport into the hearts of others.",
  "Your high-minded principles spell success."
];

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:r_connect/data/meal_data.dart';

class MessMenuScreen extends StatelessWidget {
  MessMenuScreen({super.key});
  final now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//appbar
        appBar: AppBar(
          title: const Text("Mess Menu for today"),
          backgroundColor: Colors.redAccent,
        ),
        backgroundColor: const Color.fromARGB(67, 158, 158, 158),
//body
        body: ListView.builder(
            itemCount: mealinfo.length,
            itemBuilder: (ctx, index) => Column(
                  children: [
                    mealinfo[index].day ==
                            DateFormat.EEEE().format(now).toString()
                        ? Column(
                            children: [
                              Text(
                                "Today - ${DateFormat.EEEE().format(now)}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              //Breakfast
                              const Text(
                                "Breakfast",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                "Main_Menu:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items in mealinfo[index].breakfast)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const SizedBox(height: 10),
                              const Text(
                                "Extras:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items
                                  in mealinfo[index].breakfastExtras)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const SizedBox(height: 25),
                              //Lunch
                              const Text(
                                "Lunch",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Main_Menu:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items in mealinfo[index].lunch)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const Text(
                                "Extras:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items in mealinfo[index].lunchExtras)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const SizedBox(height: 25),
                              //snacks
                              const Text(
                                "Snacks",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Main_Menu:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items in mealinfo[index].snacks)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const Text(
                                "Extras:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items in mealinfo[index].snacksExtras)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const SizedBox(height: 25),
                              //dinner
                              const Text(
                                "Dinner",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 30,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 5),
                              const Text(
                                "Main_Menu:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items in mealinfo[index].dinner)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const Text(
                                "Extras:",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              for (final items in mealinfo[index].dinnerExtras)
                                Text(items,
                                    textAlign: TextAlign.center,
                                    style:
                                        const TextStyle(color: Colors.white)),
                              const SizedBox(height: 16),
                            ],
                          )
                        : Container(),
                  ],
                )));
  }
}

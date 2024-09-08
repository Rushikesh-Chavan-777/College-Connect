import 'package:flutter/material.dart';
import 'package:r_connect/chats_compilers/vibes_compiler.dart';
import 'package:r_connect/vibes/vibes_borrow.dart';
import 'package:r_connect/vibes/vibes_registrar.dart';
import 'package:r_connect/vibes/vibes_slot.dart';

class VibesIncreen extends StatelessWidget {
  const VibesIncreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//appbar
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "Vibes Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: const Color.fromARGB(67, 158, 158,
          158), // Colors.black,//const Color.fromARGB(240, 255, 255, 255),
//body
      body: SingleChildScrollView(
        child: Column(
          children: [
//gesture detector Vibes Registrar
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const VibesRegistrarScreen()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.child_friendly,
                      color: Colors.white,
                    ),
                    Text(
                      " Registrar",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
//gesture detector Slot Booking
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const VibesSlotScreen()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.two_wheeler, color: Colors.white),
                    Text(
                      " Slot Booking",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
//gesture detector Borrow Instruments
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const VibesBorrowScreen()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.electric_rickshaw, color: Colors.white),
                    Text(
                      " Borrow Instruments",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

//gesture detector vibes
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const VibesChatScreen()));
              },
              child: Container(
                margin: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 10,
                  bottom: 10,
                ),
                padding: const EdgeInsets.only(
                  right: 20,
                  left: 20,
                  top: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.music_note, color: Colors.white),
                        Text(
                          " Vibes Chat Area",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

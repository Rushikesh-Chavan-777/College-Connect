import 'package:flutter/material.dart';
import 'package:popover/popover.dart';
import 'package:r_connect/vibes/vibes_borrow.dart';
import 'package:r_connect/vibes/vibes_registrar.dart';
import 'package:r_connect/vibes/vibes_slot.dart';

class Popover extends StatefulWidget {
  const Popover({super.key});

  @override
  State<Popover> createState() => _PopoverState();
}

class _PopoverState extends State<Popover> {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () => showPopover(
        width: 220,
        height: 170,
        context: context,
        bodyBuilder: (context) => Column(
          children: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VibesRegistrarScreen()));
                },
                child: const Text("Vibes Registrar",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VibesSlotScreen()));
                },
                child: const Text("Slot Booking",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600))),
            TextButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const VibesBorrowScreen()));
                },
                child: const Text("Borrow Instruments",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.w600))),
          ],
        ),
      ),
    );
  }
}

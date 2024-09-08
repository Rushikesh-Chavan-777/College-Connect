import 'package:flutter/material.dart';
import 'package:r_connect/chats_compilers/aero_compiler.dart';
import 'package:r_connect/chats_compilers/ecell_compiler.dart';
import 'package:r_connect/chats_compilers/epoch_compiler.dart';
import 'package:r_connect/chats_compilers/fcc_compiler.dart';
import 'package:r_connect/chats_compilers/gymkhana_compiler.dart';
import 'package:r_connect/chats_compilers/infero_compiler.dart';
import 'package:r_connect/chats_compilers/kludge_compiler.dart';
import 'package:r_connect/chats_compilers/lambda_compiler.dart';
import 'package:r_connect/chats_compilers/ncc_compiler.dart';
import 'package:r_connect/chats_compilers/nso_compiler.dart';
import 'package:r_connect/chats_compilers/nss_compiler.dart';
import 'package:r_connect/chats_compilers/qurve_compiler.dart';
import 'package:r_connect/chats_compilers/shuffle_compiler.dart';
import 'package:r_connect/chats_compilers/torque_compiler.dart';
import 'package:r_connect/chats_compilers/year_four_compiler.dart';
import 'package:r_connect/chats_compilers/year_one_compiler.dart';
import 'package:r_connect/chats_compilers/year_three_compiler.dart';
import 'package:r_connect/chats_compilers/year_two_compiler.dart';
import 'package:r_connect/vibes/vibes_in.dart';

class ChatsMainScreen extends StatelessWidget {
  const ChatsMainScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//appbar
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: const Text(
          "Chat Rooms",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor:Colors.black,  // Colors.black,//const Color.fromARGB(240, 255, 255, 255),
//body
      body: SingleChildScrollView(
        child: Column(
          children: [
//gesture detector 1st year
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const YearOneChatScreen()));
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
                  color: Colors.black,//const Color.fromARGB(67, 158, 158, 158),
                  border: Border.all(color: Colors.white),
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.child_friendly, color: Colors.white,),
                    Text(" Freshermen", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector 2nd year
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const YearTwoChatScreen()));
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
                    Icon(Icons.two_wheeler,color: Colors.white),
                    Text(" Sophomores", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector 3rd year
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const YearThreeChatScreen()));
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
                    Icon(Icons.electric_rickshaw,color: Colors.white),
                    Text(" Juniors", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector 4th year
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const YearFourChatScreen()));
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
                    Icon(Icons.four_g_mobiledata_sharp,color: Colors.white),
                    Text(" Seniors", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector vibes
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const VibesIncreen()));
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
                        CircleAvatar(backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzZ5NVp-Yi_vRPjMG96xsGCXAz8snudtCDisVu4gnNhA&s'),),
                        Text("   Vibes", style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ],
                ),
              ),
            ),
//gesture detector ecell
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const EcellChatScreen()));
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
                    Icon(Icons.business,color: Colors.white),
                    Text(" E-Cell", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector fcc
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const FccChatScreen()));
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
                    Icon(Icons.attach_money_outlined,color: Colors.white),
                    Text(" FCC", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector lambda
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const LambdaChatScreen()));
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
                    Icon(Icons.code,color: Colors.white),
                    Text(" Lambda", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector kludge
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const KludgeChatScreen()));
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
                    Icon(Icons.bug_report_outlined,color: Colors.white),
                    Text(" Kludge", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector infero
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const InferoChatScreen()));
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
                    Icon(Icons.laptop_chromebook_outlined,color: Colors.white),
                    Text(" Infero", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector epoch
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const EpochChatScreen()));
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
                    Icon(Icons.smart_toy_outlined,color: Colors.white),
                    Text(" Epoch", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector gymkhana
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const GymkhanaChatScreen()));
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
                    Icon(Icons.cell_tower_outlined,color: Colors.white),
                    Text(" GymKhana", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),

//gesture detector shufflecrew
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const ShuffleChatScreen()));
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
                    Icon(Icons.celebration_outlined,color: Colors.white),
                    Text(" Shuffle Crew", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector aero
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const AeroChatScreen()));
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
                    Icon(Icons.flight_land_outlined,color: Colors.white),
                    Text(" Aero", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector torque
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const TorqueChatScreen()));
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
                    Icon(Icons.car_crash_outlined,color: Colors.white),
                    Text(" Torque", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector qurve
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => const QurveChatScreen()));
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
                    Icon(Icons.star,color: Colors.white),
                    Text(" Qurve", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector nss
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const NssChatScreen()));
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
                    Icon(Icons.delete_sweep_outlined,color: Colors.white),
                    Text(" NSS", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector nso
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const NsoChatScreen()));
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
                    Icon(Icons.sports_cricket,color: Colors.white),
                    Text(" NSO", style: TextStyle(color: Colors.white),),
                  ],
                ),
              ),
            ),
//gesture detector ncc
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => const NccChatScreen()));
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
                    Icon(Icons.local_police_outlined,color: Colors.white),
                    Text(" NCC", style: TextStyle(color: Colors.white),),
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

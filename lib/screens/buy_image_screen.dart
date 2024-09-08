import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/widgets/buy_image_picker.dart';
import 'package:widget_zoom/widget_zoom.dart';

class BuyDisplayScreen extends StatefulWidget {
  const BuyDisplayScreen({super.key});

  @override
  State<BuyDisplayScreen> createState() => _BuyDisplayScreenState();
}

class _BuyDisplayScreenState extends State<BuyDisplayScreen> {
  @override
  Widget build(BuildContext context) {
    void _openAddExpenseOverlay() {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (ctx) => const BuyImagePickerScreen());
    }

    return Scaffold(
//appbar
      appBar: AppBar(
        title: const Text("Market Place"),
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add)),
        ],
      ),
//body
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('market_doc')
              .orderBy('createdAt', descending: true)
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text("No buy and sell items found!", style: TextStyle(color: Colors.white),),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong!", style: TextStyle(color: Colors.white),),
              );
            }

            final loadedmessages = snapshot.data!.docs;

            return SingleChildScrollView(
              //child: Expanded( 
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: loadedmessages.length,
                      itemBuilder: (ctx, index) => Column(
                        children: [
                          Container( 
                            margin: const EdgeInsets.all(16),
                            padding: const EdgeInsets.all(10),
                            width: double.infinity,
                            height: 520,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              border: Border.all(color: Colors.white),
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.35,
                                    width: double.infinity,
                                    //decoration: BoxDecoration(
                                        //image: DecorationImage(
                                      child: WidgetZoom(
                                        heroAnimationTag: 'tag',
                                        zoomWidget: Image.network(
                                            loadedmessages[index].get('image'), fit:BoxFit.cover),
                                      ),
                                    //)),
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.bubble_chart, color: Colors.blue),
                                          Text(" Item Description",
                                              style: TextStyle(
                                                color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                              '${loadedmessages[index].get('description')}', style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.price_change,
                                              color: Colors.orange),
                                          Text(" Price",
                                              style: TextStyle(
                                                color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          Text('${loadedmessages[index].get('price')}', style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Row(
                                        children: [
                                          Icon(Icons.phone, color: Colors.green),
                                          Text(" Contact of the uploader",
                                              style: TextStyle(
                                                color: Colors.white,
                                                  fontWeight: FontWeight.bold)),
                                        ],
                                      ),
                                      Wrap(
                                        children: [
                                          Text(
                                              '${loadedmessages[index].get('contact')}', style: TextStyle(color: Colors.white),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              //),
                            //),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              //),
            );
          }),
      backgroundColor:  const Color.fromARGB(67, 158, 158, 158),    //const Color.fromARGB(240, 255, 255, 255),
    );
  }
}

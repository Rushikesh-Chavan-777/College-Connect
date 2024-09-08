import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:r_connect/screens/profile_search_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  @override
  State<SearchScreen> createState() {
    return _SearchScreenState();
  }
}



class _SearchScreenState extends State<SearchScreen> {
  List allresults = [];
  List _resultlist = [];
  final TextEditingController _searchcontroller = TextEditingController();

  @override
  void initState() {
    _searchcontroller.addListener(onsearchchanged);
    super.initState();
  }

  void onsearchchanged() {
    searchResultList();
  }

  searchResultList() {
    var showresults = [];
    if (_searchcontroller.text != "") {
      for (var clientsnapshots in allresults) {
        var name = clientsnapshots['username'].toString().toLowerCase();
        if (name.contains(_searchcontroller.text.toLowerCase())) {
          showresults.add(clientsnapshots);
        }
      }
    } else {
      showresults = List.from(allresults);
    }
    setState(() {
      _resultlist = showresults;
    });
  }

  getclientstream() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('username')
        .get();
    setState(() {
      allresults = data.docs;
    });
    searchResultList();
  }

  @override
  void dispose() {
    _searchcontroller.removeListener(onsearchchanged);
    _searchcontroller.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    getclientstream();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.black,
//appbar
      appBar: AppBar(
        iconTheme: IconThemeData(
    color: Colors.white, //change your color here
  ),
        backgroundColor: Colors.black,
        title: CupertinoSearchTextField(itemColor: Colors.white,style: TextStyle(color: Colors.white),
          controller: _searchcontroller,
        ),
      ),
//body
      body: ListView.builder(
          itemCount: _resultlist.length,
          itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      CircleAvatar(
                        foregroundImage:
                            NetworkImage(_resultlist[index]['image_url']),
                      ),
                      const SizedBox(width: 10),
                      Text(_resultlist[index]['username'], style: TextStyle(color: Colors.white),),
                    ],
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileSearchScreen(userid: _resultlist[index]['userId']),));
                  },
                ),
              )),
    );
  }
}

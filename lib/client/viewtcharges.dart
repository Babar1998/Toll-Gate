import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class viewcharges extends StatefulWidget {
  const viewcharges({super.key});

  @override
  State<viewcharges> createState() => _viewchargesState();
}

class _viewchargesState extends State<viewcharges> {
  final dbShowRefrence = FirebaseDatabase.instance.ref('TollGatePrice');
  DatabaseReference ref = FirebaseDatabase.instance.ref('TollGatePrice');
  //controllers
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VIew charges Page"),
        centerTitle: true,
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         FirebaseAuth.instance.signOut().then((value) {
        //           Navigator.pushReplacement(
        //             context,
        //             MaterialPageRoute(
        //               builder: (context) => const CheckLogin(),
        //             ),
        //           );
        //           TostMessage().tostMessage("Logout Successfully!");
        //         }).onError((FirebaseAuthException error, stackTrace) {
        //           TostMessage().tostMessage(error.message);
        //         });
        //       },
        //       icon: const Icon(Icons.logout_rounded))
        // ],
      ),
      body: Column(
        children: [
          // Text("total sum = $sum"),
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextFormField(
              // keyboardType: TextInputType.phone,
              controller: searchController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search',
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (String value) {
                setState(() {});
              },
            ),
          ),
          const SizedBox(
            height: 15,
          ),

          Expanded(
            child: FirebaseAnimatedList(
                query: dbShowRefrence,
                itemBuilder: (context, snapshot, animation, index) {
                  final city = snapshot.child('city').value.toString();
                  final location = snapshot.child('location').value.toString();
                  final id = snapshot.child('id').value.toString();
                  final price = snapshot.child('price').value.toString();
                  final vehicle = snapshot.child('vehicle').value.toString();

                  // Map cust = snapshot.value as Map;
                  // cust[Key] = snapshot.key;

                  if (searchController.text.isEmpty) {
                    return Container();
                  } else if (city
                      .toLowerCase()
                      .contains(searchController.text.toLowerCase())) {
                    return Container(
                      margin:
                          const EdgeInsets.only(top: 12, left: 10, right: 12),
                      // color: Colors.white,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.blue,
                            blurRadius: 3.0, // soften the shadow
                            spreadRadius: 2.0, //extend the shadow
                            offset: Offset(
                              2.0, // Move to right 5  horizontally
                              2.0, // Move to bottom 5 Vertically
                            ),
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                padding: const EdgeInsets.all(08),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.blue,
                                    width: 2,
                                  ),
                                ),
                                child: Text(
                                  price,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    location,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    location + ": " + vehicle,
                                    style: const TextStyle(
                                      color: Colors.grey,
                                      // fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
          ),
        ],
      ),
    );
  }
}

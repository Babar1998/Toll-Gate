import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toll_gate/admin/admin.dart';

class TollDetails extends StatefulWidget {
  const TollDetails({Key? key}) : super(key: key);

  @override
  State<TollDetails> createState() => _TollDetailsState();
}

class _TollDetailsState extends State<TollDetails> {
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  final vehicleController = TextEditingController();
  final priceController = TextEditingController();
  String id = DateTime.now().microsecondsSinceEpoch.toString();

  void tollcharges() {
    setState(() {
      String abc = cityController.text.toLowerCase();
      String ab = locationController.text.toLowerCase();
      String a = vehicleController.text.toLowerCase();
    });
    final dbRefrence = FirebaseDatabase.instance.ref('TollGatePrice');
    dbRefrence.child(id).set({
      'id': id,
      'city': cityController.text.toString(),
      'location': locationController.text.toString(),
      'vehicle': vehicleController.text.toString(),
      'price': priceController.text.toString(),
    });
  }

  final _formKey = GlobalKey<FormState>();
  String location = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Toll Gate Details"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// city
                TextFormField(
                  controller: cityController,
                  decoration: const InputDecoration(
                    labelText: 'city',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter City';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },
                  onChanged: (value) => location = value,
                ),

                const SizedBox(
                  height: 15,
                ),

                /// location
                TextFormField(
                  controller: locationController,
                  decoration: const InputDecoration(
                      labelText: 'location', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Location';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },
                  onChanged: (value) => location = value,
                ),
                const SizedBox(
                  height: 15,
                ),

                /// price
                TextFormField(
                  controller: priceController,
                  decoration: const InputDecoration(
                      labelText: 'price', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter Price';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },
                  onChanged: (value) => location = value,
                ),
                const SizedBox(
                  height: 15,
                ),

                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              String car = 'car';
                              vehicleController.text = car;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text(
                            "Car",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              String truck = 'truck';
                              vehicleController.text = truck;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            textStyle: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          child: const Text(
                            "truck",
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 15,
                ),

                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        if (_formKey.currentState!.validate()) {
                          tollcharges();
                          setState(() {
                            String vehicle = vehicleController.text.toString();
                          });
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AdminPage(),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Detail Added Successfully')),
                          );
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

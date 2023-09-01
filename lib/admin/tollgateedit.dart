import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:toll_gate/admin/admin.dart';
import 'package:toll_gate/admin/tollgatecharges.dart';
import 'package:toll_gate/admin/deletetollgate.dart';

class TollEdit extends StatefulWidget {
  final String city;
  final String location;
  final String id;
  final String price;
  final String vehicle;
  const TollEdit(this.city, this.location, this.id, this.price, this.vehicle,
      {Key? key})
      : super(key: key);

  @override
  State<TollEdit> createState() => _TollEditState();
}

class _TollEditState extends State<TollEdit> {
  final cityController = TextEditingController();
  final locationController = TextEditingController();
  final vehicleController = TextEditingController();
  final priceController = TextEditingController();
  final dbShowRefrence = FirebaseDatabase.instance.ref('TollGatePrice');
  DatabaseReference ref = FirebaseDatabase.instance.ref('TollGatePrice');
  String? id;

  void initState() {
    cityController.text = widget.city;
    locationController.text = widget.location;
    vehicleController.text = widget.vehicle;
    priceController.text = widget.price;

    id = widget.id;
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  String location = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Toll Gate Details"),
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
                      labelText: 'city', border: OutlineInputBorder()),
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
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DeleteToolGate(),
                            ),
                          );
                          ref.child(id!).update({
                            'id': id,
                            'city': cityController.text.toString(),
                            'location': locationController.text.toString(),
                            'vehicle': vehicleController.text.toString(),
                            'price': priceController.text.toString(),
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Detail updated Successfully')),
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

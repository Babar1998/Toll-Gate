import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

void main() {
  runApp(const MaterialApp(home: RegisterVehicle()));
}

class RegisterVehicle extends StatefulWidget {
  const RegisterVehicle({Key? key}) : super(key: key);

  @override
  State<RegisterVehicle> createState() => _RegisterVehicleState();
}

class _RegisterVehicleState extends State<RegisterVehicle> {
  final _formKey = GlobalKey<FormState>();
  final companyController = TextEditingController();
  final modelController = TextEditingController();
  final noplateController = TextEditingController();

  String vehicleCompany = '';
  String vehicleModel = '';
  String vehicleNoPlate = '';

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(vehicleCompany);
      debugPrint(vehicleModel);
      debugPrint(vehicleNoPlate);

      /*
      Continute proccessing the provided information with your own logic
      such us sending HTTP requests, savaing to SQLite database, etc.
      */
    }
  }

  void registervehicle() {
    final dbRefrence = FirebaseDatabase.instance.ref('VehicleInfo');
    dbRefrence.child(noplateController.text.toString()).set({
      'company': companyController.text.toString(),
      'model': modelController.text.toString(),
      'noplate': noplateController.text.toString(),
    }).then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => HomePage()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registered Successfully')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Register Vehicle"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: companyController,
                  decoration: const InputDecoration(
                      labelText: 'Vehicle Company Name',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your Vehicle Company Name';
                    }
                    // Return null if the entered username is valid
                    return null;
                  },
                  onChanged: (value) => vehicleCompany = value,
                ),
                const SizedBox(
                  height: 15,
                ),

                /// Vehicle Model
                TextFormField(
                  controller: modelController,
                  decoration: const InputDecoration(
                      labelText: 'Vehicle Model', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your Vehicle Model';
                    }
                    // Return null if the entered username is valid
                    return null;
                  },
                  onChanged: (value) => vehicleCompany = value,
                ),
                const SizedBox(
                  height: 15,
                ),

                /// Vehicle No. Plate
                TextFormField(
                  controller: noplateController,
                  decoration: const InputDecoration(
                      labelText: 'Vehicle Number Plate',
                      border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your Vehicle Number Plate';
                    }
                    // if (!RegExp(r'^[A-Z-0-9]+$').hasMatch(value)) {
                    //   return 'Please enter a Number Plate';
                    // }
                    return null;
                  },
                  onChanged: (value) => vehicleNoPlate = value,
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
                          registervehicle();
                        }
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 16.0),
                //   child: ElevatedButton(
                //     onPressed: () {
                //       // Validate returns true if the form is valid, or false otherwise.
                //       if (_formKey.currentState!.validate()) {
                //         // If the form is valid, display a snackbar. In the real world,
                //         // you'd often call a server or save the information in a database.
                //         ScaffoldMessenger.of(context).showSnackBar(
                //           const SnackBar(content: Text('Processing Data')),
                //         );
                //       }
                //     },
                //     child: const Text('Submit'),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

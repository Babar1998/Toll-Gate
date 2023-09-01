import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toll_gate/admin/admin.dart';

class RegisteredCust extends StatefulWidget {
  const RegisteredCust({Key? key}) : super(key: key);

  @override
  State<RegisteredCust> createState() => _RegisteredCustState();
}

class _RegisteredCustState extends State<RegisteredCust> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confrmpasswordController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;

  String userEmail = '';
  // String userName = '';
  String password = '';
  String confirmPassword = '';

  // This function is triggered when the user press the "Sign Up" button
  void _trySubmitForm() {
    final bool? isValid = _formKey.currentState?.validate();
    if (isValid == true) {
      debugPrint('Everything looks good!');
      debugPrint(userEmail);
      // debugPrint(userName);
      debugPrint(password);
      debugPrint(confirmPassword);

      /*
      Continute proccessing the provided information with your own logic
      such us sending HTTP requests, savaing to SQLite database, etc.
      */
    }
  }

  // //for password confrmation
  // bool passwordconfrm() {
  //   if (passwordController.text.toString() ==
  //       confrmpasswordController.text.toString()) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  //sign up useers email
  void signup() {
    auth
        .createUserWithEmailAndPassword(
      email: emailController.text.toString(),
      password: passwordController.text.toString(),
    )
        .then((value) {
      Navigator.pop(context, MaterialPageRoute(builder: (_) => AdminPage()));
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account Created Successfully')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text("SignUp"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// username
                // TextFormField(
                //   decoration: const InputDecoration(
                //       labelText: 'Username', border: OutlineInputBorder()),
                //   validator: (value) {
                //     if (value == null || value.trim().isEmpty) {
                //       return 'This field is required';
                //     }
                //     if (value.trim().length < 4) {
                //       return 'Username must be at least 4 characters in length';
                //     }
                //     // Return null if the entered username is valid
                //     return null;
                //   },
                //   onChanged: (value) => userName = value,
                // ),
                const SizedBox(
                  height: 15,
                ),

                /// Email
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                      labelText: 'Email', border: OutlineInputBorder()),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
                  },
                  onChanged: (value) => userEmail = value,
                ),

                const SizedBox(
                  height: 15,
                ),

                /// Password
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      labelText: 'Password', border: OutlineInputBorder()),
                  obscureText: true,
                  obscuringCharacter: "*",
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'This field is required';
                    }
                    if (value.trim().length < 6) {
                      return 'Password must be at least 6 characters in length';
                    }
                    // Return null if the entered password is valid
                    return null;
                  },
                  onChanged: (value) => password = value,
                ),
                const SizedBox(
                  height: 15,
                ),

                /// Confirm Password
                TextFormField(
                  controller: confrmpasswordController,
                  decoration: const InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder()),
                  obscureText: true,
                  obscuringCharacter: "*",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'This field is required';
                    }

                    if (value != password) {
                      return 'Confirmation password does not match the entered password';
                    }

                    return null;
                  },
                  onChanged: (value) => confirmPassword = value,
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
                          signup();
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

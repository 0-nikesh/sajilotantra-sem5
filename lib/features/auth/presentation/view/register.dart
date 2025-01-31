import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sajilotantra/features/auth/presentation/view/login.dart';

import '../view_model/register/register_bloc.dart';
import '../view_model/register/register_event.dart';
import '../view_model/register/register_state.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // Check for camera permission
  Future<void> checkCameraPermission() async {
    if (await Permission.camera.request().isRestricted ||
        await Permission.camera.request().isDenied) {
      await Permission.camera.request();
    }
  }

  File? _img;
  Future _browseImage(ImageSource imageSource) async {
    try {
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        setState(() {
          _img = File(image.path);
          // Send image to server
          // context.read<RegisterBloc>().add(
          //       UploadImage(file: _img!),
          //     );
        });
      } else {
        return;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isSuccess) {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(builder: (context) => Otp()),
            // );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(
                //   height: 300,
                //   child: Stack(
                //     children: <Widget>[
                //       Center(
                //         child: FadeInUp(
                //           duration: const Duration(milliseconds: 1000),
                //           child: Container(
                //             height: 200,
                //             decoration: const BoxDecoration(
                //               image: DecorationImage(
                //                 image:
                //                     AssetImage('assets/images/tantra-logo.png'),
                //               ),
                //             ),
                //           ),
                //         ),
                //       )
                //     ],
                //   ),
                // ),
                const SizedBox(
                  height: 80,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        FadeInUp(
                          duration: const Duration(milliseconds: 0),
                          child: const Center(
                            child: Text(
                              "Register",
                              style: TextStyle(
                                color: Color.fromRGBO(49, 39, 79, 1),
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        InkWell(
                          onTap: () {
                            showModalBottomSheet(
                              backgroundColor: Colors.grey[300],
                              context: context,
                              isScrollControlled: true,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20),
                                ),
                              ),
                              builder: (context) => Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        checkCameraPermission();
                                        _browseImage(ImageSource.camera);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.camera),
                                      label: const Text('Camera'),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        _browseImage(ImageSource.gallery);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.image),
                                      label: const Text('Gallery'),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          child: Center(
                            child: SizedBox(
                              height: 200,
                              width: 200,
                              child: CircleAvatar(
                                radius: 60,
                                backgroundImage: _img != null
                                    ? FileImage(_img!)
                                    : const AssetImage(
                                            'assets/images/avatar.png')
                                        as ImageProvider,
                                // backgroundImage:
                                //     const AssetImage('assets/images/profile.png')
                                //         as ImageProvider,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        FadeInUp(
                          duration: const Duration(milliseconds: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                color: const Color.fromRGBO(196, 135, 198, .3),
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromRGBO(196, 135, 198, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10),
                                )
                              ],
                            ),
                            child: Column(
                              children: <Widget>[
                                //first name field
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(196, 135, 198, .3),
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _fnameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "First Name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'First Name is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),

                                //last name
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(196, 135, 198, .3),
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _lnameController,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Last Name",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700),
                                      prefixIcon: Icon(
                                        Icons.person,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Last Name is Required';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Email Field
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(196, 135, 198, .3),
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700),
                                      prefixIcon: Icon(
                                        Icons.email,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your email';
                                      } else if (!RegExp(r'^\S+@\S+\.\S+$')
                                          .hasMatch(value)) {
                                        return 'Please enter a valid email';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Password Field
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color:
                                            Color.fromRGBO(196, 135, 198, .3),
                                      ),
                                    ),
                                  ),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700),
                                      prefixIcon: Icon(
                                        Icons.lock,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please enter your password';
                                      } else if (value.length < 6) {
                                        return 'Password must be at least 6 characters';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                // Confirm Password Field
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  child: TextFormField(
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Confirm Password",
                                      hintStyle: TextStyle(
                                          color: Colors.grey.shade700),
                                      prefixIcon: Icon(
                                        Icons.lock_outline,
                                        color: Colors.grey.shade700,
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please confirm your password';
                                      } else if (value !=
                                          _passwordController.text) {
                                        return 'Passwords do not match';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        FadeInUp(
                          duration: const Duration(milliseconds: 0),
                          child: MaterialButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RegisterBloc>().add(
                                      RegisterUserEvent(
                                        context: context,
                                        fname: _fnameController.text,
                                        lname: _lnameController.text,
                                        email: _emailController.text,
                                        password: _passwordController.text,
                                        confirmPassword:
                                            _confirmPasswordController.text,
                                        file: _img!,
                                      ),
                                    );
                              }
                            },
                            color: const Color.fromRGBO(234, 241, 248, 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            height: 50,
                            child: const Center(
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0),
                                  fontSize: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        FadeInUp(
                          duration: const Duration(milliseconds: 1000),
                          child: Center(
                            child: TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Login(),
                                  ),
                                );
                              },
                              child: const Text(
                                "Already have an account? Log in",
                                style: TextStyle(
                                    color: Color.fromRGBO(49, 39, 79, .6)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

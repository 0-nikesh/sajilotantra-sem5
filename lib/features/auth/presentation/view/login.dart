// import 'package:animate_do/animate_do.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sajilotantra/features/auth/presentation/view/register.dart';
// import 'package:sajilotantra/features/auth/presentation/view_model/login/login_bloc.dart';
// import 'package:sajilotantra/features/home/presentation/view/home.dart';

// class Login extends StatelessWidget {
//   Login({super.key});

//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: BlocConsumer<LoginBloc, LoginState>(
//         listener: (context, state) {
//           if (state.isLoading) {
//             // Show loading indicator if needed
//           } else if (state.isSuccess) {
//             // Navigate to the Dashboard if login is successful
//             Navigator.pushReplacement(
//               context,
//               MaterialPageRoute(
//                 builder: (context) => const Dashboard(),
//               ),
//             );
//           }
//         },
//         builder: (context, state) {
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 SizedBox(
//                   height: 400,
//                   child: Stack(
//                     children: <Widget>[
//                       Center(
//                         child: FadeInUp(
//                           duration: const Duration(milliseconds: 1000),
//                           child: Container(
//                             height: 200,
//                             decoration: const BoxDecoration(
//                                 image: DecorationImage(
//                               image:
//                                   AssetImage('assets/images/tantra-logo.png'),
//                             )),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 40),
//                   child: Form(
//                     key: _formKey,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1500),
//                           child: const Center(
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                   color: Color.fromRGBO(49, 39, 79, 1),
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 30),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 30),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1700),
//                           child: Container(
//                             decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: Colors.white,
//                                 border: Border.all(
//                                     color: const Color.fromRGBO(
//                                         196, 135, 198, .3)),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: Color.fromRGBO(196, 135, 198, .3),
//                                     blurRadius: 20,
//                                     offset: Offset(0, 10),
//                                   )
//                                 ]),
//                             child: Column(
//                               children: <Widget>[
//                                 // Email Field
//                                 Container(
//                                   padding: const EdgeInsets.all(10),
//                                   decoration: const BoxDecoration(
//                                       border: Border(
//                                           bottom: BorderSide(
//                                               color: Color.fromRGBO(
//                                                   196, 135, 198, .3)))),
//                                   child: TextFormField(
//                                     controller: _emailController,
//                                     keyboardType: TextInputType.emailAddress,
//                                     decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: "Email",
//                                       hintStyle: TextStyle(
//                                           color: Colors.grey.shade700),
//                                       prefixIcon: Icon(Icons.email,
//                                           color: Colors.grey.shade700),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your email';
//                                       } else if (!RegExp(r'^\S+@\S+\.\S+$')
//                                           .hasMatch(value)) {
//                                         return 'Please enter a valid email';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 ),
//                                 // Password Field
//                                 Container(
//                                   padding: const EdgeInsets.all(10),
//                                   child: TextFormField(
//                                     controller: _passwordController,
//                                     obscureText: true,
//                                     decoration: InputDecoration(
//                                       border: InputBorder.none,
//                                       hintText: "Password",
//                                       hintStyle: TextStyle(
//                                           color: Colors.grey.shade700),
//                                       prefixIcon: Icon(Icons.lock,
//                                           color: Colors.grey.shade700),
//                                     ),
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Please enter your password';
//                                       } else if (value.length < 6) {
//                                         return 'Password must be at least 6 characters';
//                                       }
//                                       return null;
//                                     },
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 20),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1700),
//                           child: Center(
//                             child: TextButton(
//                               onPressed: () {},
//                               child: const Text(
//                                 "Forgot Password?",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(196, 135, 198, 1)),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 1900),
//                           child: MaterialButton(
//                             onPressed: () {
//                               if (_formKey.currentState!.validate()) {
//                                 context.read<LoginBloc>().add(
//                                       LoginUserEvent(
//                                         context: context,
//                                         email: _emailController.text,
//                                         password: _passwordController.text,
//                                       ),
//                                     );
//                               }
//                             },
//                             color: const Color.fromRGBO(234, 241, 248, 1),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             height: 50,
//                             child: const Center(
//                               child: Text(
//                                 "Login",
//                                 style: TextStyle(
//                                     color: Color.fromARGB(255, 0, 0, 0),
//                                     fontSize: 24),
//                               ),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 10),
//                         FadeInUp(
//                           duration: const Duration(milliseconds: 2000),
//                           child: Center(
//                             child: TextButton(
//                               onPressed: () {
//                                 context.read<LoginBloc>().add(
//                                       NavigateRegisterScreenEvent(
//                                         context: context,
//                                         destination: const Register(),
//                                       ),
//                                     );
//                               },
//                               child: const Text(
//                                 "Create Account",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(49, 39, 79, .6)),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }


import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sajilotantra/features/auth/presentation/view/register.dart';
import 'package:sajilotantra/features/auth/presentation/view_model/login/login_bloc.dart';
import 'package:sajilotantra/features/home/presentation/view/home.dart';

class Login extends StatelessWidget {
  Login({super.key});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: BlocConsumer<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Dashboard()),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FadeInUp(
                    duration: const Duration(milliseconds: 1000),
                    child: SizedBox(
                      height: 250,
                      child: Center(
                        child: Image.asset(
                          'assets/images/tantra-logo.png',
                          height: 150,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FadeInUp(
                            duration: const Duration(milliseconds: 1500),
                            child: Text(
                              "Login",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .textTheme
                                        .headlineSmall
                                        ?.color,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 32),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1700),
                            child: Card(
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Theme.of(context).cardColor,
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  children: <Widget>[
                                    // Email Field
                                    TextFormField(
                                      controller: _emailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        hintText: "Email",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color
                                                  ?.withOpacity(0.6),
                                            ),
                                        prefixIcon: Icon(
                                          Icons.email,
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.8),
                                      ),
                                      style: Theme.of(context).textTheme.bodyMedium,
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
                                    const SizedBox(height: 12),
                                    // Password Field
                                    TextFormField(
                                      controller: _passwordController,
                                      obscureText: true,
                                      decoration: InputDecoration(
                                        hintText: "Password",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              color: Theme.of(context)
                                                  .textTheme
                                                  .bodyMedium
                                                  ?.color
                                                  ?.withOpacity(0.6),
                                            ),
                                        prefixIcon: Icon(
                                          Icons.lock,
                                          color: Theme.of(context).iconTheme.color,
                                        ),
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        filled: true,
                                        fillColor: Theme.of(context)
                                            .cardColor
                                            .withOpacity(0.8),
                                      ),
                                      style: Theme.of(context).textTheme.bodyMedium,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'Please enter your password';
                                        } else if (value.length < 6) {
                                          return 'Password must be at least 6 characters';
                                        }
                                        return null;
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1700),
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Forgot Password?",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 1900),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  context.read<LoginBloc>().add(
                                        LoginUserEvent(
                                          context: context,
                                          email: _emailController.text,
                                          password: _passwordController.text,
                                        ),
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                minimumSize: const Size(double.infinity, 50),
                                elevation: 2,
                              ),
                              child: Text(
                                "Login",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInUp(
                            duration: const Duration(milliseconds: 2000),
                            child: TextButton(
                              onPressed: () {
                                context.read<LoginBloc>().add(
                                      NavigateRegisterScreenEvent(
                                        context: context,
                                        destination: const Register(),
                                      ),
                                    );
                              },
                              child: Text(
                                "Create Account",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                      color: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.color
                                          ?.withOpacity(0.6),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
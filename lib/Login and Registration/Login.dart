
import 'package:flutter/material.dart';
import 'package:womensafteyhackfair/Dashboard/Dashboard.dart';
import 'package:womensafteyhackfair/Dashboard/Home.dart';
import 'package:womensafteyhackfair/Login%20and%20Registration/RegistrationForm.dart';
// import 'package:shesecure/RegistrationForm.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginPageState();
}

class _LoginPageState extends State<Login> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //bool _keepMeLoggedIn = false;
  final _formKey = GlobalKey<FormState>();
  bool isPasswordshown = false;

  @override
  void dispose() {
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // bool _validateFields() {
  //   if (_userController.text.isEmpty) {
  //     _showSnackbar("Please enter the user Name.");
  //     return false;
  //   }
  //   if (_emailController.text.isEmpty) {
  //     _showSnackbar("Please enter a valid Email Address.");
  //     return false;
  //   }
  //   if (_passwordController.text.isEmpty) {
  //     _showSnackbar("Please select a password.");
  //     return false;
  //   }
  //   return true;
  // }

  // void _showSnackbar(String message) {
  //   final snackBar = SnackBar(content: Text(message));
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image.asset('lib/assets/womenSafety.png',width: 350,height: 200,),
           SizedBox(height:10,),
           const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.purple,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
         Container(
          color:Colors.white, 
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(   
              child:Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                //username
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter User Name';
                    }
                    return null;
                  },
                  controller: _userController,
                  decoration: const InputDecoration(
                    // iconColor: Colors.blue,
                    labelText: 'User Name',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person_outline_rounded),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                //email
                TextFormField(
                  validator: (email) {
                    if (email!.isEmpty || !email.contains("@")) {
                      return 'Please enter Email';
                    }
                    return null;
                  },
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email address',
                     border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email_rounded),
                  
                  ),
                ),
                const SizedBox(height: 10),
                //password
                TextFormField(
                  validator: (password) {
                    if (password == null) {
                      return 'Please enter Your password';
                    }
                    if (password.length < 8) {
                      return 'password should be 8 digits';
                    }
                    return null;
                  },
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      labelText: 'Password',
                       border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.password),
                      suffix: IconButton(
                          onPressed: () {
                            setState(() {
                            isPasswordshown = !isPasswordshown;
                            });
                          },
                          icon: const Icon(Icons.visibility))),
                ),
                const SizedBox(height: 10),
          
                // login button
               
                    ElevatedButton(
                        style: const ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(Colors.purple),
                        ),
                        onPressed: () {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>Home()));
                          // // Implement login logic here
                          if (_formKey.currentState!.validate()) {
                            /* ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );*/
                            print('Email: ${_emailController.text}');
                            print('Password: ${_passwordController.text}');
                            Navigator.push(context,MaterialPageRoute(builder: (context)=> Home()
                            // Dashboard()
                            ));
                          }
                        },
                        child: const Text(
                          'Log in',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        )),
              
          
                
                const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     const Text("Don't have a ID? "),
                //     TextButton(
                //       onPressed: () {
                //         // Implement create account logic here
                //       },
                //       child: const Text('Create account'),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {
                    // Implement forgot password logic here
                  },
                  child: const Text('Forgot your password?'),
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement login with Google logic here
                      },
                      icon: Image.asset(
                        'lib/assets/google.png', // Replace with your Google logo path
                        height: 30,
                        width: 30,
                      ),
                      label: const Text('Continue with Google'),
                    ),
                    const SizedBox(width : 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Implement login with Apple logic here
                      },
                      icon: Image.asset(
                        'lib/assets/facebook.png', // Replace with your Apple logo path
                        height: 30,
                        width: 30,
                      ),
                      label: const Text('Continue with facebook'),
                    ),
                  ],
                ),
              ],
            ),
          ),
                ),
              )
              ),]
        )
    );
  }
}

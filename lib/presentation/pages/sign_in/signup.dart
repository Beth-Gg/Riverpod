import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/signup_service.dart';

class Signup extends ConsumerStatefulWidget {
  Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var isVisible = true;
  var isAdmin = false;

  @override
  Widget build(BuildContext context) {
    final ApiService _apiService = ApiService();
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image.asset("/assets/pic.svg"),
                const ListTile(
                    title: Text("Create new account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(0.2)),
                  child: TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        } else if (value.length < 5) {
                          return 'Username must be at least 5 characters long';
                        }
                        return null;
                      }),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(0.2)),
                  child: TextFormField(
                      controller: _passwordController,
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible = !isVisible;
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 5) {
                          return 'Password must be at least 5 characters long';
                        }
                        return null;
                      }),
                ),
                SwitchListTile(
                  title: const Text('Do you want to be an admin?'),
                  value: isAdmin,
                  onChanged: (bool value) {
                    setState(() {
                      isAdmin = value;
                    });
                  },
                ),
                Container(height: 30),
                const SizedBox(height: 10),
                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton(
                      onPressed: () async {
                        if (formKey.currentState?.validate() ?? false) {
                          final username = _usernameController.text;
                          final password = _passwordController.text;
                          final role = isAdmin ? 'admin' : 'user';
                          try {
                            final response = await _apiService.signUp(
                                username, password, role, context);
                            if (response != null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('Sign-up successful!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              context.go('/login');
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Sign-up failed: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Please fill in the form correctly'),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                      },
                      child: const Text("SIGNUP",
                          style: TextStyle(color: Colors.white))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: const Text('LOGIN'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}

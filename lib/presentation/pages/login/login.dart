import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:grocery_shopping_list/providers/login_provider.dart';

final usernameProvider = StateProvider<String>((ref) => '');
final passwordProvider = StateProvider<String>((ref) => '');

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  bool isVisible = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AuthService _authService = AuthService();

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Image.asset('../assets/picture.png', width: 210),
                  const ListTile(
                      title: Text("Welcome back,",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 15),
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
                        )),
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
                                  // setState(() {
                                  //   isVisible = !isVisible;
                                  // });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)))),
                  ),
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
                          final authService = ref.read(authoProvider);
                          try {
                            final token = await authService.login(
                                _usernameController.text,
                                _passwordController.text,
                                context);

                            // context.go('/userShops');
                          } catch (e) {
                            // Handle login error
                            print('Login failed: $e');
                          }
                        },
                        child: const Text("LOGIN",
                            style: TextStyle(color: Colors.white))),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          context.go('/');
                        },
                        child: const Text('SIGN UP'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

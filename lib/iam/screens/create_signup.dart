import 'package:flutter/material.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  /*final AuthService _authService = AuthService();*/

  /*void _register() async {
    final response = await _authService.signUp(
      _usernameController.text,
      _emailController.text,
      "farmer",
      _passwordController.text,
    );
    if (response.statusCode == 201) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginScreen()),
      );
      // Registro exitoso
    } else {
      // Error en el registro
    }
  }*/

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(title: const Text('Register')),  
      body: Container(  
        decoration: const BoxDecoration(),  
        child: Padding(  
          padding: const EdgeInsets.all(24.0),  
          child: Card(  
            elevation: 8.0,  
            child: Padding(  
              padding: const EdgeInsets.all(16.0),  
              child: Column(  
                mainAxisAlignment: MainAxisAlignment.center,  
                crossAxisAlignment: CrossAxisAlignment.stretch,  
                children: [  
                  _buildTextField(  
                    controller: _usernameController,  
                    labelText: 'Username',  
                    prefixIcon: Icons.person,  
                  ),  
                  const SizedBox(height: 16.0),  
                  _buildTextField(  
                    controller: _emailController,  
                    labelText: 'Email',  
                    prefixIcon: Icons.email,  
                  ),  
                  const SizedBox(height: 16.0),  
                  _buildTextField(  
                    controller: _passwordController,  
                    labelText: 'Password',  
                    prefixIcon: Icons.lock,  
                    obscureText: true,  
                  ),  
                  const SizedBox(height: 24.0),  
                  ElevatedButton(  
                    onPressed: () {  
                      // _register();  
                    }, 
                    style: ButtonStyle(  
                      backgroundColor: MaterialStateProperty.all(Colors.orange),  
                      foregroundColor: MaterialStateProperty.all(Colors.white),  
                      elevation: MaterialStateProperty.all(4.0),  
                      shape: MaterialStateProperty.all(  
                        RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(10.0),  
                        ),  
                      ),  
                    ), 
                    child: const Text('Register'),  
                  ),  
                ],  
              ),  
            ),  
          ),  
        ),  
      ),  
    );  
  }  
  
  Widget _buildTextField({  
    required TextEditingController controller,  
    required String labelText,  
    IconData? prefixIcon,  
    bool obscureText = false,  
  }) {  
    return TextField(  
      controller: controller,  
      obscureText: obscureText,  
      decoration: InputDecoration(  
        labelText: labelText,  
        prefixIcon: prefixIcon!= null? Icon(prefixIcon) : null,  
        border: OutlineInputBorder(  
          borderRadius: BorderRadius.circular(10.0),  
        ),  
        focusedBorder: OutlineInputBorder(  
          borderRadius: BorderRadius.circular(10.0),  
          borderSide: const BorderSide(  
            color: Colors.lightGreen,
            width: 2.0,  
          ),  
        ),  
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),  
      ),  
    );  
  }  
}  
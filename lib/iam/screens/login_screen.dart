
import 'package:flutter/material.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  //final AuthService _authService = AuthService();

  /*void _login() async {
    final response = await _authService.signIn(
      _usernameController.text,
      _passwordController.text,
    );

    if (response.statusCode == 202) {
      final responseData = jsonDecode(response.body);
      final userId = responseData['id'];
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      await sharedPreferences.setInt('userId', userId);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProductsListScreen()),
      );
    } else {
      // Error en el inicio de sesión
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SignupScreen()),
      );
    }
  }*/

  @override  
  Widget build(BuildContext context) {  
    return Scaffold(  
      appBar: AppBar(  
        title: const Text('Login'),  
        centerTitle: true,  
      ),  
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
                      backgroundColor: MaterialStateProperty.all(Colors.lightGreen),
                      foregroundColor: MaterialStateProperty.all(Colors.white),  
                      elevation: MaterialStateProperty.all(4.0),  
                      shape: MaterialStateProperty.all(  
                        RoundedRectangleBorder(  
                          borderRadius: BorderRadius.circular(10.0),  
                        ),  
                      ),  
                    ),
                    child: const Text('Login'),  
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
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 2.0,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
      ),
    );
  }
}
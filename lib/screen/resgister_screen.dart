import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/handle/auth_methods.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/widget/text_field_input.dart';

class ResgisterScreen extends StatefulWidget{
  const ResgisterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ResgisterScreenState();

}

class _ResgisterScreenState extends State<ResgisterScreen>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
    _addressController.dispose();
  }

  void userResgister() async{
    String res = await AuthMethods().userResgister(email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        address: _addressController.text);
    print(res);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          width: double.infinity,
          padding:const EdgeInsets.symmetric(horizontal: 30,),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset('assets/ic_instagram.svg', color: Colors.white,height: 50,),
              const SizedBox(height: 24,),
              TextFieldInput(
                textFieldController: _emailController, hinttext: 'Enter your email',
              ),
              const SizedBox(height: 24,),
              TextFieldInput(
                textFieldController: _passwordController, isPass :true, hinttext: 'Enter your password',
              ),
              const SizedBox(height: 24,),
              TextFieldInput(
                textFieldController: _usernameController, hinttext: 'Enter your username',
              ),
              const SizedBox(height: 24,),
              TextFieldInput(
                textFieldController: _addressController, hinttext: 'Enter your address',
              ),
              const SizedBox(height: 24,),
              InkWell(
                onTap: userResgister,
                child: Container(
                  color: Colors.blue,
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding:const EdgeInsets.symmetric(vertical: 20),
                  child:const Text('Resgister', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.white,
                  ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
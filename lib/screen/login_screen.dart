import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram_clone/handle/auth_methods.dart';
import 'package:instagram_clone/provider/provider_user.dart';
import 'package:instagram_clone/screen/home_page_screen.dart';
import 'package:instagram_clone/screen/resgister_screen.dart';
import 'package:instagram_clone/widget/text_field_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget{

  const LoginScreen({Key? key}) : super(key : key);
  @override
  State<StatefulWidget> createState() {
    return _LoginScreenState();
  }

}

class _LoginScreenState extends State<LoginScreen>{
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async{
    ProviderUser userProvider = Provider.of(context, listen: false);
    await userProvider.refestUser();
  }

  void userLogin() async{
    String res= await AuthMethods().userLogin(email: _emailController.text,
        password: _passwordController.text);
    if(res == 'success'){
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const HomePageScreen()));

      // Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) =>const ResgisterScreen()));
    }
  }

  void navivagaRes(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) =>const ResgisterScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            width: double.infinity,
            color: Colors.black,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/ic_instagram.svg', color: Colors.white, height: 40,),
                const SizedBox(height: 20,),
                TextFieldInput(textFieldController: _emailController, hinttext: 'Enter your email',
                ),
                const SizedBox(height: 20,),
                TextFieldInput(textFieldController: _passwordController, isPass: true, hinttext: 'Enter your password',
                ),
                const SizedBox(height: 24,),
                InkWell(
                  onTap: userLogin,
                  child:Container(
                    color: Colors.blue,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: const Text('Login', style: TextStyle(
                      color: Colors.white,
                    ),),
                  ),
                ),
                const SizedBox(height: 70,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    const Text('Do you have accout?', style: TextStyle(color: Colors.white),),
                    InkWell(
                      onTap: navivagaRes,
                      child:const Text('Sign up',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),),
                    )
                  ],
                ),
              ],

            ),
          ),
        )


      ),
    );
  }

}
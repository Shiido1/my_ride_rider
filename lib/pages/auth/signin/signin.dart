import 'package:flutter/material.dart';
import 'package:my_ride/components/loading_button.dart';
import 'package:my_ride/constants/colors.dart';
import 'package:my_ride/constants/constants.dart';
import 'package:my_ride/controllers/auth_controller.dart';
import 'package:my_ride/partials/mixins/validations.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

class SigninPage extends StatefulWidget {
  SigninPage({Key? key}) : super(key: key);

  @override
  State createState() => _SigninPageState();
}

class _SigninPageState extends StateMVC<SigninPage> with ValidationMixin {
  _SigninPageState() : super(AuthController()) {
    con = controller as AuthController;
  }
  late AuthController con;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(leading: const SizedBox(), elevation: 0, backgroundColor: Colors.transparent),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Adaptive.w(5), vertical: 10),
        child: SingleChildScrollView(
          child: SizedBox(
            height: Adaptive.h(100) - 100,
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: con.model.loginFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Center(
                        child: Image(
                          height: 100,
                          image: AssetImage(
                            'assets/images/logo.png',
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            'Sign In',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextFormField(
                        // validator: validateF,
                        controller: con.model.emailController,
                        decoration: Constants.inputDecoration.copyWith(
                          labelText: "Email",
                        ),
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        obscureText: true,
                        controller: con.model.passwordController,
                        decoration: Constants.inputDecoration.copyWith(
                          labelText: "Password",
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 40, right: Adaptive.w(15), left: Adaptive.w(15)),
                        child: LoadingButton(
                          label: "Sign In",
                          onPressed: con.signIn,
                          disabled: false,
                          isLoading: con.model.isLoading,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot password?',
                          style: TextStyle(
                            fontSize: 18.sp,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


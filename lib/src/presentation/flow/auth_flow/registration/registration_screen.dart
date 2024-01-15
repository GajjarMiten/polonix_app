import 'package:flutter/material.dart';
import 'package:poloniexapp/src/presentation/core/enums/routes_enum.dart';
import 'package:poloniexapp/src/presentation/core/extensions/num_extensions/number_extension.dart';
import 'package:poloniexapp/src/presentation/cubit/all_cubits.dart';
import 'package:poloniexapp/src/presentation/routing/app_router.dart';
import 'package:poloniexapp/src/presentation/shared/buttons/common_button.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFF21899C),
      body: SafeArea(
        child: Column(
          children: [
            const Expanded(
              flex: 1,
              child: Center(),
            ),
            Expanded(
              flex: 11,
              child: _buildCard(size),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Size size) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        color: Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //build minimize icon
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 35,
                height: 4.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey,
                ),
              ),
            ),
            10.heightBox,

            //welcome text
            const Text(
              'Welcome!',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            10.heightBox,
            registrationText(),
            10.heightBox,

            //email textField
            const Text(
              'Email',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            emailTextField(size),
            SizedBox(
              height: size.height * 0.02,
            ),

            //password textField
            const Text(
              'Password',
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            10.heightBox,
            passwordTextField(size),
            10.heightBox,
            registerButton(size),
            10.heightBox,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text.rich(
                  TextSpan(
                    style: const TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                    children: [
                      const TextSpan(
                        text: 'Already have an account? ',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      WidgetSpan(
                          child: InkWell(
                        onTap: () => AppRouter.pushReplace(Routes.loginScreen),
                        child: const Text(
                          'Sign In here',
                          style: TextStyle(
                            color: Color(0xFFFF7248),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ))
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget registrationText() {
    return const Text(
      'REGISTER',
      style: TextStyle(
        fontWeight: FontWeight.w800,
        fontSize: 24,
        color: Color(0xFF21899C),
      ),
    );
  }

  Widget emailTextField(Size size) {
    return TextField(
      controller: emailController,
      style: const TextStyle(
        fontSize: 18.0,
        color: Color(0xFF151624),
      ),
      maxLines: 1,
      keyboardType: TextInputType.emailAddress,
      cursorColor: const Color(0xFF151624),
      decoration: InputDecoration(
        hintText: 'Enter your email',
        hintStyle: TextStyle(
          fontSize: 16.0,
          color: const Color(0xFF151624).withOpacity(0.5),
        ),
        filled: true,
        fillColor: emailController.text.isEmpty
            ? const Color.fromRGBO(248, 247, 251, 1)
            : Colors.transparent,
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: emailController.text.isEmpty
                  ? Colors.transparent
                  : const Color.fromRGBO(44, 185, 176, 1),
            )),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(
              color: Color.fromRGBO(44, 185, 176, 1),
            )),
        prefixIcon: Icon(
          Icons.mail_outline_rounded,
          color: emailController.text.isEmpty
              ? const Color(0xFF151624).withOpacity(0.5)
              : const Color.fromRGBO(44, 185, 176, 1),
          size: 16,
        ),
        suffix: Container(
          alignment: Alignment.center,
          width: 24.0,
          height: 24.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            color: const Color.fromRGBO(44, 185, 176, 1),
          ),
          child: emailController.text.isEmpty
              ? const Center()
              : const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 13,
                ),
        ),
      ),
    );
  }

  Widget passwordTextField(Size size) {
    return Container(
      height: size.height / 13,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color.fromRGBO(248, 247, 251, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: [
            const Icon(
              Icons.lock_outline_rounded,
              size: 16,
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: TextField(
                controller: passController,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF151624),
                ),
                cursorColor: const Color(0xFF151624),
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(
                    fontSize: 16.0,
                    color: const Color(0xFF151624).withOpacity(0.5),
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),
            passController.text.isEmpty
                ? const Center()
                : Container(
                    height: 30,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(249, 225, 224, 1),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                          color: const Color.fromRGBO(254, 152, 121, 1),
                        )),
                    child: const Text(
                      'View',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color(0xFFFE9879),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  Widget registerButton(Size size) {
    return CommonButton(
      title: "Register",
      onPressed: () {
        AppCubits.authCubit.registerUser(
          email: emailController.text,
          password: passController.text,
        );
      },
    );
  }
}

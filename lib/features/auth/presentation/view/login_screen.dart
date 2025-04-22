import 'package:flutter/material.dart';
import 'package:logiology_machinetest/features/home/view/home_screen.dart';
import 'package:logiology_machinetest/general/utils/app_colors.dart';
import 'package:logiology_machinetest/general/widgets/CTextform_widget.dart';
import 'package:logiology_machinetest/general/widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32),
        child: Center(
          child: Column(
            children: [
              Text(
                "Login",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: AppColors.blackColor,
                ),
              ),
              SizedBox(height: 20),

              Center(
                child: Text(
                  "Hi, Welcome back👋",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.blackColor,
                  ),
                ),
              ),
              SizedBox(height: 40),
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        " UserName",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  CTextFormField(
                    height: 45,
                    borderRadius: 25,
                    labelText: "enter userName",
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Text(
                        " password",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blackColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  CTextFormField(
                    height: 45,
                    borderRadius: 25,
                    labelText: "enter password",
                  ),
                ],
              ),
              SizedBox(height: 78),
              CustomButton(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                  );
                },
                buttontext: "login",
                color: AppColors.primaryColor,
                textColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

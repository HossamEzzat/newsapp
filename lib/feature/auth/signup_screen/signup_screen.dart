import 'package:flutter/material.dart';
import 'package:newsapp/feature/auth/login_screen/login_screen.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/customTextField.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool obscureText = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confirmPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset("assets/images/Vector.png", height: 45),
                ),
                const SizedBox(height: 40),
                Text(
                  "Welcome to Newts",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: AppColors.textSecondColor,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  "Email",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.textSecondColor,
                  ),
                ),
                // Email field
                CustomTextfield(
                  hintText: "hoss@gmail.com",
                  controller: emailController,
                  isPassword: false,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }

                    // Regex pattern for email validation
                    final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
                    );

                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Text(
                  "Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.textSecondColor,
                  ),
                ),
                // Password field
                CustomTextfield(
                  hintText: "***********",
                  controller: passController,
                  isPassword: obscureText,
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    // Regex pattern for password validation
                    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
                    final passwordRegex = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                    );

                    if (!passwordRegex.hasMatch(value)) {
                      return 'Password must contain:\n• 8+ characters\n• 1 uppercase letter\n• 1 lowercase letter\n• 1 number\n• 1 special character (@\$!%*?&)';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    color: AppColors.textSecondColor,
                  ),
                ),
                CustomTextfield(
                  hintText: "***********",
                  controller: confirmPassController,
                  isPassword: obscureText,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    // Regex pattern for password validation
                    // At least 8 characters, 1 uppercase, 1 lowercase, 1 number, 1 special character
                    final passwordRegex = RegExp(
                      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
                    );

                    if (!passwordRegex.hasMatch(value)) {
                      return 'Password must contain:\n• 8+ characters\n• 1 uppercase letter\n• 1 lowercase letter\n• 1 number\n• 1 special character (@\$!%*?&)';
                    }
                    return null;
                  },
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        obscureText = !obscureText;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Login button
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add login logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Sign up option
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Have an account ?",
                      style: TextStyle(color: AppColors.textSecondColor),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Sign IN',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

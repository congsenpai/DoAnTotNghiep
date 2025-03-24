import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_event.dart';

import '../../../constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  bool _obscureText = true;

  String userName = "";
  String passWord = "";
  String confirmPassword = "";
  String phoneNumber = "";
  String email = "";

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // User Name Field
          TextFormField(
            validator: userNameValidator.call,
            onSaved: (value) {
              userName = value ?? '';
            },
            textInputAction: TextInputAction.next,
            decoration: const InputDecoration(hintText: "User Name"),
          ),
          const SizedBox(height: defaultPadding),

          // Password Field
          TextFormField(
            obscureText: _obscureText,
            validator: passwordValidator.call,
            textInputAction: TextInputAction.next,
            onSaved: (value) {
              passWord = value ?? '';
            },
            decoration: InputDecoration(
              hintText: "Password",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: bodyTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Confirm Password Field
          TextFormField(
            obscureText: _obscureText,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please confirm your password';
              }
              if (value != passWord) {
                return 'Passwords do not match';
              }
              return null;
            },
            onSaved: (value) {
              confirmPassword = value ?? '';
            },
            decoration: InputDecoration(
              hintText: "Confirm Password",
              suffixIcon: GestureDetector(
                onTap: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
                child: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: bodyTextColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),

          // Phone Number Field
          TextFormField(
            validator: phoneNumberValidator.call,
            onSaved: (value) {
              phoneNumber = value ?? '';
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(hintText: "Phone Number"),
          ),
          const SizedBox(height: defaultPadding),

          // Email Field
          TextFormField(
            validator: emailValidator.call,
            onSaved: (value) {
              email = value ?? '';
            },
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: "Email"),
          ),
          const SizedBox(height: defaultPadding),

          // Sign Up Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState!.save();
                context
                    .read<AuthBloc>()
                    .add(RegisterEvent(userName, passWord, phoneNumber, email));
              }
            },
            child: const Text("Sign Up"),
          ),

          // Navigate to Phone Login
          TextButton(
            onPressed: () {
              context.read<AuthBloc>().add(RegisterEvent(userName, passWord, phoneNumber, email));
            },
            child: const Text("Sign up with phone number"),
          ),
        ],
      ),
    );
  }
}


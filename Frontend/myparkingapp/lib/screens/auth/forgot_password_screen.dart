import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/bloc/auth/auth_bloc.dart';
import 'package:myparkingapp/bloc/auth/auth_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import '../../app/locallization/app_localizations.dart';
import 'reset_email_sent_screen.dart';

import '../../components/welcome_text.dart';
import '../../constants.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate("Forgot Password")),
      ),
      body: BlocConsumer<AuthBloc,AuthState>(builder: (context,state) {
        if(state is AuthLoadingState){
          return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 18),);
        }
      
        return SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WelcomeText(
                title: "Forgot password",
                text:
                    "Enter your email address and we will \nsend you a reset instructions."),
            SizedBox(height: defaultPadding),
            ForgotPassForm(),
          ],
        ),
      );
      }, listener: (context,state){
        if(state is AuthSuccessState){
          return AppDialog.showSuccessEvent(context, state.mess,);
        }
        else if(state is AuthErrorState){
          return AppDialog.showErrorEvent(context, state.mess);
        }
      })
    );
  }
}

class ForgotPassForm extends StatefulWidget {
  const ForgotPassForm({super.key});

  @override
  State<ForgotPassForm> createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Email Field
          TextFormField(
            validator: emailValidator.call,
            onSaved: (value) {

            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: AppLocalizations.of(context).translate("Email Address")),
          ),
          const SizedBox(height: defaultPadding),

          // Reset password Button
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // If all data are correct then save data to out variables
                _formKey.currentState!.save();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ResetEmailSentScreen(),
                  ),
                );
              }
            },
            child: Text(AppLocalizations.of(context).translate("Reset password")),
          ),
        ],
      ),
    );
  }
}

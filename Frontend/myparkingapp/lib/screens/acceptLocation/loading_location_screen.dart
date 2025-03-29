import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:myparkingapp/data/response/user__response.dart';
import '../../app/locallization/app_localizations.dart';
import '../../main_screen.dart';

import '../../components/buttons/secondery_button.dart';
import '../../components/welcome_text.dart';
import '../../constants.dart';

class AcceptLocationScreen extends StatelessWidget {
  final UserResponse user;
  const AcceptLocationScreen({super.key, required this.user,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainScreen(user: user,),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const WelcomeText(
                title: "Find parking slot near you ",
                text:
                    "Please enter your location or allow access to \nyour location to find parking lot near you.",
              ),

              // Getting Current Location
              SeconderyButton(
                press: () {
                  

                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/location.svg",
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                        primaryColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "Use current location",
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: primaryColor),
                    )
                  ],
                ),
              ),
              const SizedBox(height: defaultPadding),

              // New Address Form
              Form(
                child: Column(
                  children: [
                    TextFormField(
                      // onSaved: (value) => _location = value,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(color: titleColor),
                      cursorColor: primaryColor,
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SvgPicture.asset(
                            "assets/icons/marker.svg",
                            colorFilter: const ColorFilter.mode(
                                bodyTextColor, BlendMode.srcIn),
                          ),
                        ),
                        hintText: AppLocalizations.of(context).translate("Enter a new address"),
                        contentPadding: kTextFieldPadding,
                      ),
                    ),
                    const SizedBox(height: defaultPadding),
                    ElevatedButton(
                      onPressed: () {
                        // Use your onw way how you combine both New Address and Current Location
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainScreen(user: user,),
                          ),
                        );
                      },
                      child:  Text(AppLocalizations.of(context).translate("Continue")),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: defaultPadding),
            ],
          ),
        ),
      ),
    );
  }
}

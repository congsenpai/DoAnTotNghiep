import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:myparkingapp/bloc/location/location_bloc.dart';
import 'package:myparkingapp/bloc/location/location_event.dart';
import 'package:myparkingapp/bloc/location/location_state.dart';
import 'package:myparkingapp/components/app_dialog.dart';
import 'package:myparkingapp/data/response/user_response.dart';
import 'package:myparkingapp/screens/onboarding/components/image_no_content.dart';
import '../../app/locallization/app_localizations.dart';
import '../../main_screen.dart';

import '../../components/buttons/secondery_button.dart';
import '../../constants.dart';

class AcceptLocationScreen extends StatefulWidget {
  final UserResponse user;
  const AcceptLocationScreen({super.key, required this.user,});

  @override
  State<AcceptLocationScreen> createState() => _AcceptLocationScreenState();
}

class _AcceptLocationScreenState extends State<AcceptLocationScreen> {
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
                builder: (context) => MainScreen(user: widget.user,),
              ),
            );
          },
        ),
      ),
      body: BlocConsumer<LocationBloc,LocationState>(
        builder: (context,state){
          if(state is LocationLoading){
            return Center(child: LoadingAnimationWidget.staggeredDotsWave(color: Colors.greenAccent , size: 25),);
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  ImageContent(
                    illustration: "assets/Illustrations/register.svg",
                    title: "Find parking slot near you",
                    text: "Please allow access to \nyour location to find parking lot near you.",),
                  Spacer(
                    
                  ),

                  // Getting Current Location
                  SeconderyButton(
                    press: () {
                    context.read<LocationBloc>().add(GetLocationEvent());
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
                  ElevatedButton(
                          onPressed: () {
                            // Use your onw way how you combine both New Address and Current Location
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainScreen(user: widget.user,),
                              ),
                            );
                          },
                          child:  Text(AppLocalizations.of(context).translate("Continue")),
                        ),
                  Spacer(),
                  const SizedBox(height: defaultPadding),

                ],
              ),
            ),
          );
    
        }, listener: (context,state){
        if(state is LocationSuccessState){
          return AppDialog.showSuccessEvent(context, state.mess,);
        }
        else if(state is LocationErrorState){
          return AppDialog.showErrorEvent(context, state.mess);
        }
      })
      );
  }
}

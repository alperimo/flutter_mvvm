import 'package:flutter/material.dart';
import 'package:readytostart_base_mvvm_project/locator.dart';
import 'package:readytostart_base_mvvm_project/services/auth_service.dart';

import 'package:readytostart_base_mvvm_project/views/widgets/circularprogressindicator.dart' as custom_circular;

class StarterScreen extends StatefulWidget{
  const StarterScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => StarterScreenState();
}

class StarterScreenState extends State<StarterScreen>{
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context){
    locator<AuthService>().listenAuth(context);

    return const Center(
      child: custom_circular.CircularProgressIndicator()
    );
  }
}
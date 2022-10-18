import 'dart:math';
import 'package:bmi_app/score_screen.dart';
import 'package:page_transition/page_transition.dart';

import 'package:bmi_app/age_weight_widget.dart';
import 'package:bmi_app/height_widget.dart';
import 'package:flutter/material.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';

import 'gender_widget.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int _gender = 0;
  int _height = 150;
  int _age = 30;
  int _weight = 50;
  bool _isFinished = false;
  double _bmiScore = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("BMI Calculator"),),
      body: SingleChildScrollView(
        child: Container(

          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 12,

            shape: const RoundedRectangleBorder(),
            child: Column(
              children: [
                // lets create gender widget
                GenderWidget(onChange: (genderVal){
                  _gender = genderVal;
                },),
                HeightWidget(onChange: (heightVal){
                  _height = heightVal;
                }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AgeWeightWidget(
                        onChange:(ageVal){
                          _age = ageVal;
                        }, title: "Age",
                        intValue: 30,
                        min: 0,
                        max: 100),
                    AgeWeightWidget(
                        onChange:(weightVal){
                          _weight = weightVal;
                        }, title: "Weight(Kg)",
                        intValue: 50,
                        min: 0,
                        max: 200),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0,
                  horizontal: 60.0,),
                  child: SwipeableButtonView(
                    isFinished: _isFinished,
                      onFinish: () async{
                      await Navigator.push(context,
                          PageTransition(
                              child: ScoreScreen(
                                bmiScore: _bmiScore,
                                age: _age,
                              ), type: PageTransitionType.fade));
                      setState(() {
                        _isFinished = false;
                      });
                      },
                      onWaitingProcess: (){
                      // Calculate BMI here
                        calculateBmi();
                      Future.delayed(Duration(seconds: 1),(){
                        setState(() {
                          _isFinished = true;
                        });
                      });
                      },
                      activeColor: Colors.cyan,
                      buttonWidget: Icon(
                        Icons.arrow_forward_ios_rounded,
                        color: Colors.black,
                      ),
                      buttonText: "CALCULATE"),
                ),

              ],
            ),
          ),

        ),
      ),
    );
  }
  void calculateBmi(){
    _bmiScore = _weight/pow(_height/100, 2);
  }
}

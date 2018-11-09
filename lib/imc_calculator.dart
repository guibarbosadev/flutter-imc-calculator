import 'package:flutter/material.dart';
import 'package:imc_calculator/models/imc.dart';
import 'colors.dart';

class ImcCalculator extends StatefulWidget {
  @override
  _ImcCalculatorState createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  Widget _buildTextfield(String labelText, String suffixText) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Theme(
        data: Theme.of(context)
            .copyWith(primaryColor: Colors.black, hintColor: kShrineBrown),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            suffixText: suffixText,
            labelText: labelText
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Widget logo = Padding(
      padding: EdgeInsets.only(
        top: 40.0,
        bottom: 10.0,
      ),
      child: Image.asset(
        'assets/images/calculator.png',
        height: 100.0,
        width: 100.0,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de IMC'),
      ),
      body: Container(
          padding: EdgeInsets.all(20.0),
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    logo,
                    _buildTextfield('Altura', 'cm'),
                    _buildTextfield('Massa', 'kg'),
                  ])
            ],
          )),
    );
  }
}

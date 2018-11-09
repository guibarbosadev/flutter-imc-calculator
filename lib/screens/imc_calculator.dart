import 'package:flutter/material.dart';
import 'package:imc_calculator/colors.dart';

class ImcCalculator extends StatefulWidget {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController massController = TextEditingController();

  @override
  _ImcCalculatorState createState() => _ImcCalculatorState();
}

class _ImcCalculatorState extends State<ImcCalculator> {
  String result = '';

  Widget _buildTextfield(String labelText, String suffixText,
      TextInputAction inputAction, TextEditingController controller,
      {FocusNode focusNode, Function onSubmitted}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Theme(
        data: Theme.of(context)
            .copyWith(primaryColor: Colors.black, hintColor: kShrineBrown),
        child: TextField(
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixText: suffixText,
              labelText: labelText),
          controller: controller,
          keyboardType: TextInputType.numberWithOptions(
            decimal: true
          ),
          textInputAction: inputAction,
          focusNode: focusNode,
          onSubmitted: onSubmitted == null
              ? (String value) {
                  print('doing nothing');
                }
              : onSubmitted,
        ),
      ),
    );
  }

  void focusMassTextfield(BuildContext buildContext, FocusNode focusNode) {
    FocusScope.of(buildContext).requestFocus(focusNode);
  }

  void calculateResult(String height, String mass) {
    print('aqui dentro estou $height $mass');
    if (height != null && mass != null) {
      try {
        double heightValue = double.parse(height);
        double massValue = double.parse(mass);
        setState(() {
          double result = heightValue * heightValue;
          result = massValue / result;
          this.result = result.toStringAsFixed(2);
        });
      } catch (error) {
        print('$error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final FocusNode focusNode = FocusNode();

    final heightTextField = _buildTextfield(
        'Altura', 'metros', TextInputAction.next, widget.heightController,
        onSubmitted: (String value) {
      focusMassTextfield(context, focusNode);
    });

    final massTextField = _buildTextfield(
        'Massa', 'kg', TextInputAction.done, widget.massController,
        focusNode: focusNode, onSubmitted: (String value) {
      calculateResult(widget.heightController.text, widget.massController.text);
    });

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
      body: Container(
          color: Color(0xFFFFFBFA),
          padding: EdgeInsets.all(20.0),
          width: double.infinity,
          height: double.infinity,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  logo,
                  heightTextField,
                  massTextField,
                  result != ''
                      ? Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text('IMC normal: ${this.result}'),
                        )
                      : Container()
                ],
              )
            ],
          )),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sailors/src/core/extensions/extensions.dart';
import '../../core/utils/colors_constants.dart';
import '../../core/utils/dimens_constants.dart';

class ChooseLoginRegisterScreen extends StatelessWidget {
  const ChooseLoginRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround  ,
        children: [
          Container(
            color: ColorsConstant.kWhiteColor,
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            height: 150,
            child: Image.asset(
              "images/dummy.png",
              fit: BoxFit.none,
            ),
          ),
          Column(
            children: [
              _createLoginButtonWidget(),
              _createRegisterButtonWidget()
            ],
          )
        ],
      ),
    );
  }

  Builder _createLoginButtonWidget() =>
      Builder(builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorsConstant.kAccentColor,
            borderRadius: BorderRadius.circular(
              DimensConstants.kDimens_8,
            ),
          ),
          child: TextButton(
            onPressed: () => _navigateToLoginScreen,
            child: Text(
              context.translate('login'),
            ),
          ),
        );
      });

  Builder _createRegisterButtonWidget() =>
      Builder(builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: ColorsConstant.kWhiteColor,
            borderRadius: BorderRadius.circular(
              DimensConstants.kDimens_8,
            ),
            border: Border.all(color: ColorsConstant.kAccentColor,width: DimensConstants.kDimens_2),
          ),
          child: TextButton(
            onPressed: () => _navigateToRegisterScreen,
            child: Text(
              context.translate('register'),
            ),
          ),
        );
      });

  _navigateToLoginScreen() {}

  _navigateToRegisterScreen() {}
}

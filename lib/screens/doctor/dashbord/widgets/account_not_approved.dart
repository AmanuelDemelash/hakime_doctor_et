import 'package:flutter/material.dart';

class AccountNotApproved extends StatelessWidget {
  const AccountNotApproved({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(30),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Image(
              image: AssetImage("assets/images/onhold.png"),
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
            Text(
              "Your account is onhold please wait untile it approved",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
            Text(
              "Build your profile to make it active",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

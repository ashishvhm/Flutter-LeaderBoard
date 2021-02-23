import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:leaderboard/winners.dart';

import 'background.dart';
import 'constants.dart';

class ListOfGames extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("List Of Games",style: TextStyle(fontSize: 30),),
            SizedBox(height: size.height * 0.05),
            Card(
              color: kPrimaryColor,
              elevation: 10,
              margin: EdgeInsets.all(10),
              child: InkWell(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListOfWinners('Cricket',"cricket.jpg")),
                  );
                },
              child: Padding(
                padding: EdgeInsets.all(15),
                child:  Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/cricket.jpg'),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Cricket",
                      style: TextStyle(color: Colors.white,
                      fontSize: 20,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
            SizedBox(height: size.height * 0.05),
            Card(
              color: kPrimaryColor,
              elevation: 10,
              margin: EdgeInsets.all(10),
              child:  InkWell(
                onTap:(){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ListOfWinners('FootBall',"football.jpg")),
                  );
                },
                child: Padding(
                padding: EdgeInsets.all(15),
                child:  Row(
                  children: [
                    CircleAvatar(
                      radius: 30.0,
                      backgroundImage: AssetImage('assets/images/football.jpg'),
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "FootBall",
                      style: TextStyle(color: Colors.white,
                      fontSize: 20,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

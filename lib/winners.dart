import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:leaderboard/registerusers.dart';
import 'constants.dart';
import 'dbmanager.dart';

class ListOfWinners extends StatefulWidget {
  String _game,_icon;

  ListOfWinners(this._game,this._icon);
  @override
  _ListOfWinnersState createState() => _ListOfWinnersState();
}

class _ListOfWinnersState extends State<ListOfWinners>{
  final DbUser dbuser = new DbUser();
  var formatter = new DateFormat.yMd().add_jm();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 40,),
            Align(
              alignment: Alignment.topRight,
              child:  RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterUser()),
                  );
                },
                child: Text('Add Users',style: TextStyle(fontSize: 15),),
              )
            ),

            Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(90),
              ),
            child: CircleAvatar(
              radius: 90.0,
              backgroundImage: AssetImage('assets/images/'+widget._icon),
            ),
        ),
            SizedBox(height: 15,),
            Card(
              color: kPrimaryColor,
              elevation: 10,
              margin: EdgeInsets.all(10),
             child: FutureBuilder(
                  future: dbuser.getUserList(widget._game),
                  builder: (context, snapshot) {
                    return snapshot.data != null
                        ? listViewWidget(snapshot.data)
                        : Center();
                  }),
            ),
            SizedBox(height: size.height * 0.05),

          ],
        ),
      ),
    );
  }


  Widget listViewWidget(List<User> article) {
      return Container(
        child: ListView.builder(
            shrinkWrap: true,
            primary: false,
            physics: NeverScrollableScrollPhysics(),
            itemCount: article.length,
            padding: const EdgeInsets.all(2.0),
            itemBuilder: (context, position) {
              return ListTile(
                title: Text(
                  article[position].name,
                  style: TextStyle(color: Colors.white,
//                    fontSize: 15,
                    fontFamily: 'Quicksand',
                    fontWeight: FontWeight.w700,
                  ),
                ),
               leading: Text((position+1).toString(),style: TextStyle(fontSize: 25,color: Colors.white),),
               /* leading: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 25.0,
                  backgroundImage: AssetImage('assets/drlogo.png'),
                ),*/
                subtitle: Row(
                  children: <Widget>[
                    Text(
                 DateFormat('yMd').add_jm().format(DateTime.parse(article[position].created_at)),
                      style: TextStyle(color: Colors.white,
                        fontSize: 12,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }),
      );

  }
}

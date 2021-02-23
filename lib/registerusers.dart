

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'dbmanager.dart';

class RegisterUser extends StatefulWidget {
  RegisterUser({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> _games = ['Cricket', 'FootBall'];
  List<String> _score = ['1', '2', '3', '4','5','6','7','8','9','10'];
  String _selectedGames="Cricket";
  String _selectScore="1";
  TextEditingController nameController=new TextEditingController();
  final DbUser dbuser = new DbUser();

  @override
  void initState() {
    super.initState();
  }

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title,TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              controller: controller,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  void _showToast(BuildContext context,final String msg) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(msg),
        action: SnackBarAction(
            label: 'cancel', onPressed: _scaffoldKey.currentState.hideCurrentSnackBar),
      ),
    );
  }

  Widget _submitButton(BuildContext context) {
    return GestureDetector(
        onTap: (){
          var now = new DateTime.now();
      User ur=new User(name: nameController.text, created_at: now.toIso8601String(), score: _selectScore, game: _selectedGames);
          dbuser.insertUser(ur);
          Navigator.pop(context);
        },
        child:  Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.symmetric(vertical: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.shade200,
                    offset: Offset(2, 4),
                    blurRadius: 5,
                    spreadRadius: 2)
              ],
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xfffbb448), Color(0xfff7892b)])),
          child: Text(
            'Submit',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        )
    );
  }

  Widget _title() {
    return Text("Register User",style: TextStyle(color: kPrimaryColor, fontSize: 30),);
  }




  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(height: 30),
                    _entryField('UserName',nameController),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Select Score',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(_selectScore,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blue ),),
                        SizedBox(
                          width: 10,
                        ),
                        DropdownButton<String>(
                            items: _score.map((String val) {
                              return new DropdownMenuItem<String>(
                                value: val,
                                child: new Text(val,style: TextStyle(color: Colors.black54),),
                              );
                            }).toList(),
                            //   hint: Text("Please choose a location"),
                            onChanged: (newVal) {

                              this.setState(() {
                                _selectScore   = newVal;

                              });
                            }),

                      ],
                    ),
                  ),


                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Select Games',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15,),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(_selectedGames,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20,color: Colors.blue ),),
                          SizedBox(
                            width: 10,
                          ),
                          DropdownButton<String>(
                              items: _games.map((String val) {
                                return new DropdownMenuItem<String>(
                                  value: val,
                                  child: new Text(val,style: TextStyle(color: Colors.black54),),
                                );
                              }).toList(),
                              //   hint: Text("Please choose a location"),
                              onChanged: (newVal) {

                                this.setState(() {
                                  _selectedGames   = newVal;

                                });
                              }),

                        ],
                      ),
                    ),

                    SizedBox(
                      height: 50,
                    ),
                    _submitButton(context),

                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}

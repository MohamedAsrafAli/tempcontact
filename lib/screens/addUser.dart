import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitleda/model/User.dart';
import 'package:untitleda/services/userService.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}


class _AddUserState extends State<AddUser> {
  final _userNameController = TextEditingController();
  final _userContactController = TextEditingController();
  final _userDescriptionController = TextEditingController();

  bool _validateName = false;
  bool _validateContact = false;
  bool _validateDescription = false;

  var _userServices = UserService();
  
  double h =100;
  double w =100;


  doAnimate()
  {
    setState(() {
      h = h ==100 ? 200:100;
      w = w ==100 ? 200:100;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New User'),
      ),
      body:SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:  [
              InkWell(
                child: AnimatedContainer(duration: Duration(seconds: 5),
                  child: Image.asset('images/user.png'),
                  curve: Curves.bounceInOut,
                  height: h,
                  width: w,
                ),onTap: ()=>doAnimate(),
              ),


              const Text('Add New Details',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15,color:Colors.lightBlueAccent),
              ),
              const SizedBox(height: 20.0,),

              TextField(
                controller: _userNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter Name',
                  label: Text('Name'),
                  errorText: _validateName ?'Name Value Can\'t Be Empty': null,
                ),

              ),

              const SizedBox(height: 20.0,),

              TextField(
                controller: _userContactController,
                decoration:  InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter Number',
                    label: Text('Number'),
                  errorText: _validateContact ?'Contact Value Can\'t Be Empty': null,
                ),

              ),

              const SizedBox(height: 20.0,),

              TextField(
                controller: _userDescriptionController,
                decoration:  InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Enter Description',
                    label: Text('Description'),
                  errorText: _validateDescription ?'Description Value Can\'t Be Empty': null,
                ),

              ),

              const SizedBox(height: 20.0,),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.white,
                      backgroundColor: Colors.green,
                      textStyle: const TextStyle(fontSize:15)
                    ), onPressed: () async {
                      setState(() {
                        _userNameController.text.isEmpty?_validateName=true:_validateName=false;
                        _userContactController.text.isEmpty?_validateContact=true:_validateContact=false;
                        _userDescriptionController.text.isEmpty?_validateDescription=true:_validateDescription=false;
                      });

                      if(_validateName==false&&_validateContact==false&&_validateDescription==false) {
                        var _user = User();
                        _user.name = _userNameController.text;
                        _user.contact = _userContactController.text;
                        _user.description = _userDescriptionController.text;

                        var result = await _userServices.SaveUser(_user);
                        Navigator.pop(context,result);
                      }


                  },
                      child: const Text('Save Details')),

                  const SizedBox(width: 10.0,),

                  TextButton(
                      style: TextButton.styleFrom(
                          primary: Colors.white,
                          backgroundColor: Colors.red,
                          textStyle: const TextStyle(fontSize:15)
                      ),
                      onPressed: () {
                        _userNameController.text = '';
                        _userContactController.text = '';
                        _userDescriptionController.text = '';

                        }, child: const Text('Clear Details')),


                ],

              )

            ],
          ),
        ),

      )

    );
  }
}

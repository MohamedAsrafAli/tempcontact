import 'package:flutter/material.dart';
import 'package:untitleda/model/User.dart';
import 'package:untitleda/screens/addUser.dart';
import 'package:untitleda/screens/editUser.dart';
import 'package:untitleda/screens/viewUser.dart';
import 'package:untitleda/services/userService.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),

    );
  }
}



class MyHomePage extends StatefulWidget {

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList;
  final _userServices = UserService();
  getAllUserDetails()async
  {

    var users = await _userServices.readAllUsers();
    _userList=<User>[];

    users.forEach((user){
    setState(() {
      var userModel = User();
      userModel.id = user['id'];
      userModel.name=user['name'];
      userModel.contact=user['contact'];
      userModel.description=user['description'];
      _userList.add(userModel);
    });

    });
  }

  @override
  void initState()
  {
    getAllUserDetails();
    super.initState();
  }


  _showSucessSnakBar(String messgae)
  {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
              content: Text(messgae,style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,



    )
    );
  }

  _deleteFormDialog(BuildContext context,userId)
  {
    return showDialog(
      context: context,
        builder:(param){
        return AlertDialog(
          title: const Text('Delete contact?',style:TextStyle(color: Colors.blue),),
          actions: [
            TextButton(
                onPressed: () async{
                  var result = await _userServices.deleteUser(userId);
                  if(result!=null)
                  {
                    Navigator.pop(context);
                    getAllUserDetails();
                    _showSucessSnakBar("User Detail Deleted Success");
                  }

                }, child: Text('Delete',style:TextStyle(color: Colors.red),)),

            TextButton(


                onPressed: () {
                  Navigator.pop(context);
                }, child: Text('Close',style:TextStyle(color: Colors.green),)),

          ],
        );


        }


    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Contact App'),
      ),
      body: ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context,index){
          return Card(
            child: ListTile(
              onTap: ()
              {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context)=>ViewUser(user: _userList[index])));
              },
              leading: Icon(Icons.person_rounded,color: Colors.lightBlueAccent,),
              title:Text(_userList[index].name ?? ''),
              subtitle:Text(_userList[index].contact ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context)=>EditUser(user: _userList[index],))).then((data) {
                          if(data!=null)
                          {
                            getAllUserDetails();
                            _showSucessSnakBar("User Detail Updated Success");
                          }
                        });;
                      },
                      icon :const Icon(Icons.edit_outlined),color: Colors.black45, ),
                  IconButton(
                    onPressed: () {
                      _deleteFormDialog(context,_userList[index].id);

                    },
                    icon :const Icon(Icons.delete_rounded),color: Colors.red, ),
                ],
              ),
            )

          );
        }


      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context)=>AddUser(),),)
                .then((data) {
              if(data!=null)
                {
                  getAllUserDetails();
                  _showSucessSnakBar("User Detail Added Success");
                }
            });

          },
          child: const Icon(Icons.add),
        )

    );
  }
}






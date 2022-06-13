import 'package:flutter/material.dart';
import '../model/User.dart';

class ViewUser extends StatefulWidget {
  final User user;

  const ViewUser({Key? key,required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
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
      appBar: AppBar(
        title:const Text('Full Details'),
      ),
      body: Container(

        padding:const EdgeInsets.all(16.0),
        child: Column(


          children: [

            InkWell(
              child: AnimatedContainer(duration: const Duration(seconds: 5),
                child: Image.asset('images/people.png'),
                curve: Curves.bounceOut,
                height: h,
                width: w,
              ),onTap: ()=>doAnimate(),
            ),
            const SizedBox(height: 35,),

            Row(


              children: [
                const Text('Name:',
                  style: TextStyle(color: Colors.brown,fontSize: 16,fontWeight: FontWeight.w500)),

                  Padding(
                    padding:  const EdgeInsets.only(left: 40),
                    child: Text(widget.user.name??'',style:const TextStyle(fontSize: 18)),
                  ),


              ],
            ),
            const SizedBox(height: 20,),
            Row(

              children: [
                const Text('Contact:',
                    style: TextStyle(color: Colors.brown,fontSize: 16,fontWeight: FontWeight.w500)),

                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Text(widget.user.contact??'',style:const TextStyle(fontSize: 18)),
                ),


              ],
            ),
            const SizedBox(height: 20,),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [
                const Text('Description:',
                    style: TextStyle(color: Colors.brown,fontSize: 16,fontWeight: FontWeight.w500)),
                const SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(25),

                  child: Text(widget.user.description??'',style: const TextStyle(fontSize: 18)),
                ),


              ],
            ),
          ],
        ),
      ),
    );
  }
}

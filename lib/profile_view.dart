import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final proController = TextEditingController();
  final phnController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          centerTitle: true,
        ),
        body: ChangeNotifierProvider(
          create: (context) => MyModel(),
          child: Consumer<MyModel>(builder: (context, profile, child) {
            profile.initialPhone();
            profile.initialPic();
            profile.initialProfile();
            return Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(padding: EdgeInsets.only(left: 20.0, top: 20.0)),
                CircleAvatar(
                  backgroundImage: profile.getImage(),
                  radius: 50.0,
                  child: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => profile.imagePick(),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                SizedBox(
                    height: 100.0,
                    width: 300.0,
                    child: TextFormField(
                        enabled: profile.ifEnabled,
                        decoration: InputDecoration(
                            labelText: 'Name',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0))),
                        initialValue: '${profile.getProfileName}',
                        onChanged: (text) {
                          Provider.of<MyModel>(context, listen: false)
                              .setProfileName(text);
                        })),
                SizedBox(
                  height: 100.0,
                  width: 300.0,
                  child: TextFormField(
                    enabled: profile.ifEnabled,
                    initialValue: '${profile.getPhoneNumber}',
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                        labelText: 'Phone',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0))),
                    validator: profile.validateMobile,
                    onChanged: (text) {
                      Provider.of<MyModel>(context, listen: false)
                          .setPhone(text);
                    },
                  ),
                ),
                RaisedButton(
                    color: Colors.blueAccent,
                    child: profile.ifEnabled
                        ? Text(
                            "Save",
                            style: TextStyle(color: Colors.white),
                          )
                        : Text("Edit", style: TextStyle(color: Colors.white)),
                    onPressed: () => profile.setEnabled())
              ],
            ));
          }),
        ));
  }
}

import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/models/user_model.dart';
import 'package:brew_crew/screens/home/brew_list.dart';
import 'package:brew_crew/screens/home/settings_form.dart';
import 'package:brew_crew/services/auth_service.dart';
import 'package:brew_crew/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    //Show bottom sheet
    // void _showSettingsPanel() {
    //   final userModel = Provider.of<UserModel>(context, listen: false);
    //   showModalBottomSheet(
    //     context: context,
    //     builder: (_) {
    //       return Provider.value(
    //         value: userModel,
    //         child: Container(
    //           padding: const EdgeInsets.symmetric(
    //             vertical: 20.0,
    //             horizontal: 60.0,
    //           ),
    //           child: const SettingsForm(),
    //         ),
    //       );
    //     },
    //   );
    // }

    // Show bottom sheet
    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 60.0,
            ),
            child: const SettingsForm(),
          );
        },
      );
    }

    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: null,
      child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
          title: const Text('Brew Crew'),
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          actions: <Widget>[
            ElevatedButton.icon(
              icon: const Icon(Icons.person),
              label: const Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
            ElevatedButton.icon(
              icon: Icon(Icons.settings),
              label: Text('settings'),
              onPressed: () {
                _showSettingsPanel();
              },
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}






// import 'package:brew_crew/models/user_model.dart';
// import 'package:brew_crew/services/database.dart';
// import 'package:brew_crew/shared/constants.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class SettingsForm extends StatefulWidget {
//   const SettingsForm({Key? key}) : super(key: key);

//   @override
//   _SettingsFormState createState() => _SettingsFormState();
// }

// class _SettingsFormState extends State<SettingsForm> {
//   final _formKey = GlobalKey<FormState>();
//   final List<String> sugars = ['0', '1', '2', '3', '4'];

//   String? _currentName;
//   String? _currentSugars;
//   int? _currentStrength;
//   bool _strengthChangedManually = false;

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<UserModel>(context);

//     return StreamBuilder<UserData>(
//       stream: DatabaseService(uid: user.uid).userData,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           UserData? userData = snapshot.data;
//           // set initial data.
//           if (!_strengthChangedManually) {
//             _currentName = userData!.name;
//             _currentSugars = userData.sugars;
//             _currentStrength = userData.strength;
//           }

//           return Form(
//             key: _formKey,
//             child: Column(
//               children: <Widget>[
//                 const Text(
//                   'Update your brew settings.',
//                   style: TextStyle(
//                     fontSize: 18.0,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 TextFormField(
//                   decoration: textInputDecoration,
//                   initialValue: _currentName,
//                   validator: (val) =>
//                       val!.isEmpty ? 'Please enter a name' : null,
//                   onChanged: (val) => setState(() => _currentName = val),
//                 ),
//                 const SizedBox(
//                   height: 20.0,
//                 ),
//                 DropdownButtonFormField(
//                   value: _currentSugars,
//                   items: sugars.map((sugar) {
//                     return DropdownMenuItem(
//                       value: sugar,
//                       child: Text('$sugar sugar'),
//                     );
//                   }).toList(),
//                   onChanged: (val) {
//                     setState(() => _currentSugars = val.toString());
//                   },
//                 ),
//                 Slider(
//                   min: 100.0,
//                   max: 900.0,
//                   divisions: 8,
//                   value: (_currentStrength ?? userData!.strength).toDouble(),
//                   activeColor: Colors.brown[_currentStrength!],
//                   onChanged: (val) => setState(() {
//                     _strengthChangedManually = true;
//                     _currentStrength = val.round();
//                   }),
//                 ),
//                 ElevatedButton(
//                   child: const Text('Update'),
//                   onPressed: () async {
//                     print(_currentName);
//                     print(_currentSugars);
//                     print(_currentStrength);
//                   },
//                 )
//               ],
//             ),
//           );
//         } else {
//           return Container();
//         }
//       },
//     );
//   }
// }
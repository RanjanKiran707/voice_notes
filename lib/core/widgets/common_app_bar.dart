import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get_it/get_it.dart';
import 'package:voice_notes/core/nav_utils.dart';
import 'package:voice_notes/core/services/dependency_service.dart';
import 'package:voice_notes/core/widgets/add_dialog.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CommonAppBar(
      {super.key, required this.onAddPress, required this.title});

  final VoidCallback onAddPress;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      actions: [
        // IconButton(
        //   onPressed: () {
        //     FirebaseAuth.instance.signOut();
        //     Dep.atlas.close();
        //     Dep.local.close();
        //   },
        //   icon: Icon(Icons.logout),
        // ),
        IconButton(
          onPressed: () {
            onAddPress();
          },
          icon: Icon(Icons.add),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

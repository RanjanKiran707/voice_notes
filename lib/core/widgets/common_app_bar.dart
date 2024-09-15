import 'package:flutter/material.dart';
import 'package:voice_notes/core/services/dependency_service.dart';

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
        IconButton(
          onPressed: () {
            final ctrl = TextEditingController();

            final pref = Dep.prefService;

            final curSpeed = pref.getSpeed();

            ctrl.text = curSpeed.toString();
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text("Set playback speed"),
                  content: TextField(
                    keyboardType: TextInputType.number,
                    controller: ctrl,
                  ),
                  actions: [
                    FilledButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel")),
                    ElevatedButton(
                        onPressed: () {
                          final val = ctrl.text;

                          final doubleVal = double.tryParse(val) ?? 1;

                          pref.setSpeed(doubleVal);
                          Navigator.pop(context);
                        },
                        child: const Text("Save")),
                  ],
                );
              },
            );
          },
          icon: const Icon(Icons.settings),
        ),
        IconButton(
          onPressed: () {
            onAddPress();
          },
          icon: const Icon(Icons.add),
        ),
        const SizedBox(
          width: 10,
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

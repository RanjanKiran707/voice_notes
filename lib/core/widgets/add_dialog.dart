import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:voice_notes/domain/database.dart';

class AddDialog extends StatelessWidget {
  AddDialog({super.key, required this.hintText, required this.onSubmit});
  final formKey = GlobalKey<FormBuilderState>();
  final String hintText;
  final void Function({required String name}) onSubmit;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: FormBuilder(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FormBuilderTextField(
                name: "name",
                validator: FormBuilderValidators.compose(
                    [FormBuilderValidators.required()]),
                decoration: InputDecoration(
                  hintText: hintText,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              FilledButton(
                  onPressed: () {
                    submitMethod(context);
                  },
                  child: Text("Submit"))
            ],
          ),
        ),
      ),
    );
  }

  void submitMethod(BuildContext context) {
    if (formKey.currentState?.saveAndValidate() ?? false) {
      final value = formKey.currentState!.value;
      final name = value["name"];
      onSubmit(name: name);
    }
    Navigator.pop(context);
  }
}

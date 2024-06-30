// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class GenericListView<T extends AsyncValue> extends StatelessWidget {
//    const GenericListView({super.key,required this.provider});

//   final ProviderListenable<T> provider;

//   @override
//   Widget build(BuildContext context) {
//      return Scaffold(
//       body: Consumer(
//         builder: (context, ref, child) {
//           final subjects = ref.watch(provider);
//           return subjects.when(
//             data: (data) {
//               final subjectList = data.list;
//               return ListView.builder(
//                 itemBuilder: (context, index) {
//                   return ListTile(
//                     title: Text(subjectList[index].name),
//                     onTap: (){
                      
//                     },
//                   );
//                 },
//                 itemCount: subjectList.length,
//               );
//             },
//             error: (error, stackTrace) {
//               return Center();
//             },
//             loading: () {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             },
//           );
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {
//            showDialog(
//             context: context,
//             builder: (context) {
//               return AddDialog(
//                 hintText: "Enter chapter name",
//                 onSubmit: ({required name}) {
//                   final realm = GetIt.I.get<Realm>();
//                   realm.write(() {
//                     subject.chapters.add(
//                         Chapter(ObjectId(), name));
//                   });
//                 },
//               );
//             },
//           );
//         },
//         label: Text("Add chapter"),
//         icon: Icon(Icons.add),
//       ),
//     );
//   }
// }
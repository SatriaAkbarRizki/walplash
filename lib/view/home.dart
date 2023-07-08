import 'package:flutter/material.dart';
import 'package:walplash/model/imagemodel.dart';
import 'package:walplash/presenter/presenter.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Presenter presenter = Presenter();
  List<ImageModel>? _image;

  @override
  void initState() {
    showImage();
    super.initState();
  }

  void showImage() async {
    _image = await presenter.fetchUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ImageModel>?>(
        future: presenter.fetchUser(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (context, index) => CircleAvatar(
                    foregroundImage:
                        NetworkImage(snapshot.data![index].urls.raw)),
              );
            } else {
              return Center(
                child: Text('Not Found'),
              );
            }
          }
        },
      ),
    );
  }
}

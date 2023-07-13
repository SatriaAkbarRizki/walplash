import 'package:flutter/material.dart';
import 'package:walplash/model/imagemodel.dart';
import 'package:walplash/presenter/presenter.dart';
import 'package:walplash/view/fullimage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Presenter presenter = Presenter();
  List<ImageModel>? _image;
  bool isClick = true;

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
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          'Walplash',
          style: TextStyle(fontFamily: 'Lobster'),
        ),
      ),
      backgroundColor: Color(0xff0f393646),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.only(left: 5),
            child: itemUn(),
          ),
          FutureBuilder<List<ImageModel>?>(
            future: presenter.fetchUser(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.hasData) {
                  return Expanded(
                      child: Container(
                    padding: EdgeInsets.all(10),
                    child: GridView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return ImageUn(snapshot, context, index);
                      },
                    ),
                  ));
                } else {
                  return Center(
                    child: Text('Not Found'),
                  );
                }
              }
            },
          )
        ],
      ),
    );
  }

  Widget itemUn() {
    return Row(
      children: [
        TextButton(
          onPressed: () {
            setState(() {
              if (isClick == false) {
                isClick = true;
              } else {
                isClick = false;
              }
            });
          },
          child: Row(
            children: [
              Container(
                width: 160,
                decoration: BoxDecoration(
                    border: isClick == true
                        ? Border(
                            bottom: BorderSide(color: Colors.white, width: 1))
                        : null),
                child: const Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 28,
                      child: Text(
                        'Explore',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        ),
        TextButton(
          onPressed: () {
            setState(() {
              if (isClick == false) {
                isClick = true;
              } else {
                isClick = false;
              }
            });
          },
          child: Row(
            children: [
              Container(
                width: 160,
                decoration: BoxDecoration(
                    border: isClick == false
                        ? Border(
                            bottom: BorderSide(color: Colors.white, width: 1))
                        : null),
                child: Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: 28,
                      child: Text(
                        'Category',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget ImageUn(AsyncSnapshot<List<ImageModel>?> snapshot,
      BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.all(5.0), // Atur jarak sesuai kebutuhan
      child: InkWell(
        onTap: () {
          print('index of image: $index');
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FullImage(
                  list: [snapshot.data![index]],
                ),
              ));
        },
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(snapshot.data![index].urls.small),
              fit: BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

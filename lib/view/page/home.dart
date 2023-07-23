import 'package:flutter/material.dart';
import 'package:walplash/model/imagemodel.dart';
import 'package:walplash/presenter/presenter.dart';
import 'package:pinterest_nav_bar/pinterest_nav_bar.dart';
import 'package:walplash/view/page/categoryview.dart';
import 'package:walplash/view/page/fullimage.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Presenter presenter = Presenter();
  List<ImageModel>? _image;
  List<dynamic>? listMap;
  bool isClickCategory = true;
  bool isClickSearch = true;

  @override
  void initState() {
    showImage();
    listMap = _imageCategory.entries.toList();
    super.initState();
  }

  void showImage() async {
    _image = await presenter.fetchUser();
    setState(() {});
  }

  var _imageCategory = {
    'nature': 'assets/images/nature.jpg',
    'animal': 'assets/images/animal.jpg',
    'film': 'assets/images/film.jpg',
    'travel': 'assets/images/travel.jpg',
    'architecture': 'assets/images/architecture.jpg',
  };

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
                return Container(
                  height: 500,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else {
                if (snapshot.hasData) {
                  if (isClickCategory == false) {
                    return Expanded(
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: categoryImage(),
                      ),
                    );
                  } else {
                    return Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      child: GridView.builder(
                        physics: AlwaysScrollableScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2),
                        itemBuilder: (context, index) {
                          return imageUn(snapshot, context, index);
                        },
                      ),
                    ));
                  }
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
              if (isClickCategory == false) {
                isClickCategory = true;
              } else {
                isClickCategory = false;
              }
            });
          },
          child: Row(
            children: [
              Container(
                width: 160,
                decoration: BoxDecoration(
                    border: isClickCategory == true
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
              if (isClickCategory == false) {
                isClickCategory = true;
              } else {
                isClickCategory = false;
              }
            });
          },
          child: Row(
            children: [
              Container(
                width: 160,
                decoration: BoxDecoration(
                    border: isClickCategory == false
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

  Widget imageUn(AsyncSnapshot<List<ImageModel>?> snapshot,
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

  Widget categoryImage() {
    return ListView.builder(
      itemCount: _imageCategory.length,
      itemBuilder: (context, index) {
        return Container(
          height: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 8),
            color: Colors.red,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        CategoryView(category: listMap![index].key),
                  ));
            },
            child: Stack(children: [
              Positioned.fill(
                  child: Image.asset(
                '${listMap![index].value}',
                fit: BoxFit.cover,
              )),
              Positioned(
                  top: 130,
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      '${listMap![index].key}',
                      style: TextStyle(
                          fontSize: 24,
                          fontFamily: 'Beau',
                          color: Colors.white),
                    ),
                  ))
            ]),
          ),
        );
      },
    );
  }
}

                // if (isClickSearch == true) {
                //   isClickSearch = false;
                //   print(isClickSearch);
                // } else {
                //   isClickSearch = true;
                //   print(isClickSearch);
                // }
import 'package:flutter/material.dart';
import 'package:walplash/model/imagemodel.dart';
import 'package:walplash/presenter/presenter.dart';
import 'package:walplash/view/fullimage.dart';

class CategoryView extends StatefulWidget {
  String category;
  CategoryView({required this.category, super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  Presenter presenter = Presenter();
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
          FutureBuilder<List<ImageModel>?>(
            future: presenter.categoryImage(widget.category),
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
                        return imageUn(snapshot, context, index);
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
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

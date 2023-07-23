import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:walplash/model/imagemodel.dart';
import 'package:walplash/presenter/presenter.dart';
import 'package:walplash/services/notif_service.dart';

class FullImage extends StatefulWidget {
  final List<ImageModel> list;

  FullImage({required this.list, super.key});

  @override
  State<FullImage> createState() => _FullImageState();
}

class _FullImageState extends State<FullImage> {
  Presenter presenter = Presenter();
  late String outputDate;

  @override
  void initState() {
    outputDate = filterRelases();
    initNotiService();
    super.initState();
  }

  void initNotiService() {
    NotificationService().notificationsPlugin;
    NotificationService().initNotification();
    NotificationService().notificationsDetails();
  }

  String filterRelases() {
    DateTime dateTime = DateTime.parse(widget.list[0].created_at);
    DateFormat dateFormat = DateFormat('yy-MMM-dd');
    String output = dateFormat.format(dateTime);
    String result = output.replaceAll('-', ' ');
    return result;
  }

  @override
  Widget build(BuildContext context) {
    // print(widget.list[0].user.total_photos);
    print('links user: ${widget.list[0].links.html}');

    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 580,
                    child: Image.network(
                      widget.list[0].urls.regular,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 40,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 250),
                          child: GestureDetector(
                            onTap: () {
                              showMyProfile(widget.list[0].user.name,
                                  widget.list[0].user.profile_image.large);
                            },
                            child: CircleAvatar(
                              foregroundImage: NetworkImage(
                                widget.list[0].user.profile_image.large,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                height: 220,
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(color: Colors.black),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        maxLines: 2,
                        widget.list[0].alt_description!,
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontFamily: 'Madurai'),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 200,
                          child: TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(Colors.white)),
                              onPressed: () async {
                                presenter.saveImage(
                                    widget.list[0].urls.regular, context);
                              },
                              child: Text(
                                'Download',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              )),
                        ),
                        SizedBox(
                          width: 25,
                        ),
                        SizedBox(
                          height: 50,
                          width: 110,
                          child: TextButton(
                              style: ButtonStyle(
                                  side: MaterialStatePropertyAll(
                                      BorderSide(color: Colors.white))),
                              onPressed: () async {
                                shareImage(widget.list[0].links.html);
                              },
                              child: Text(
                                'Share',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Lobster',
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text(
                              widget.list[0].likes.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Madurai'),
                            ),
                            Text(
                              'Likes',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 55,
                        ),
                        Column(
                          children: [
                            Text(
                              outputDate,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Madurai'),
                            ),
                            Text(
                              'Published On',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            )
                          ],
                        ),
                        SizedBox(
                          width: 50,
                        ),
                        Column(
                          children: [
                            Text(
                              widget.list[0].user.total_photos.toString(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                  fontFamily: 'Madurai'),
                            ),
                            Text(
                              'Total Photos',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  Future showMyProfile(
    String name,
    String profile,
  ) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.black,
          content: Row(
            children: [
              CircleAvatar(
                backgroundImage: NetworkImage(profile),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: 18),
              )
            ],
          ),
          actions: [
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                height: 40,
                width: 60,
                child: TextButton(
                    style: ButtonStyle(
                        side: MaterialStatePropertyAll(
                            BorderSide(color: Colors.white))),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Ok',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            )
          ],
        );
      },
    );
  }

  void shareImage(String link) {
    Share.share(link.toString());
  }
}

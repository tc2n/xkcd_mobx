import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:xkcd_mobx/mobx/xkcd.dart';

class RandomComicScreen extends StatefulWidget {
  RandomComicScreen({Key key}) : super(key: key);

  @override
  _RandomComicScreenState createState() => _RandomComicScreenState();
}

class _RandomComicScreenState extends State<RandomComicScreen> {
  final XkcdService store = XkcdService();
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  DateFormat formatter = DateFormat('yMMMd');

  @override
  void initState() {
    getMainComic();
    super.initState();
  }

  getMainComic() async {
    await store.getRandomComic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Observer(
          builder: (context) {
            if (store.isMainComicLoading) {
              return Container(
                color: Colors.black,
                alignment: Alignment.center,
                child: Lottie.asset('assets/loading.json',
                    height: 120, width: 120),
              );
            } else {
              return Container(
                color: Colors.black87,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: Container(
                              color: Colors.white,
                              padding: EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                top: 5.0,
                                bottom: 5.0,
                              ),
                              child: Text(
                                " Random ",
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            store.getRandomComic();
                          },
                          color: Colors.black38,
                          icon: Icon(
                            Icons.refresh,
                            size: 30.0,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    Text(
                      "#${store.comic.getComicNumber}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Text(
                      "${formatter.format(DateTime.parse(store.comic.getComicDate))}",
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 14.0,
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                    Container(
                      // color: Colors.white,
                      height: MediaQuery.of(context).size.height * 0.12,
                      child: Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Text(
                                "${store.comic.getComicTitle}",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.03,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.42,
                      child: Card(
                        child: InteractiveViewer(
                          maxScale: 2.0,
                          child: Image.network(
                            "${store.comic.getComicUrl}",
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.20,
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: Center(
                        child: Text(
                          "${store.comic.getComicAlt}",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
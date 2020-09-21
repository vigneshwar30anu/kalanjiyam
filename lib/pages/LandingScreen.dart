import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:kalanjiyam/Categories.dart';
import 'package:kalanjiyam/pages/CategoryDetailPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final List<String> imgList = [
  'https://avstechs.in/kalanjiyam/images/category/ramayanam/ramayanam.jpg',
  'https://avstechs.in/kalanjiyam/images/category/mahabharat/mahabharat.jpg',
  'https://avstechs.in/kalanjiyam/images/category/thenaliraman/thenaliraman.jpg'
];

class LandingScreen extends StatefulWidget {
  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: new AppBar(
          centerTitle: true,

          // automaticallyImplyLeading: false, // this is to disable drawer icon
          backgroundColor: Color.fromRGBO(19, 71, 110, 0.9),
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                aspectRatio: 2.0,
                enlargeCenterPage: true,
              ),
              items: imageSliders,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: EdgeInsets.all(10),
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(5),
                      ),
                      Text(
                        'நல்லோர் இணைவோம். \nநல்வினை புரிவோம்.',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: listOfCategories(context),
            ),
          ],
        ),
      );
}

Widget listOfCategories(BuildContext context) => FutureBuilder(
    future: fetchCategories(context),
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, int i) {
              Categories categories = snapshot.data[i];

              return new Container(
                child: new Center(
                  child: new Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        shadowColor: Colors.blueGrey,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: InkWell(
                          child: Container(
                            padding: EdgeInsets.fromLTRB(5.0, 5.0, 0, 5.0),
                            width: MediaQuery.of(context).size.width * 0.9,
                            child: Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(5.0),
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        image: NetworkImage(
                                          categories.image,
                                        ),
                                        fit: BoxFit.fill),
                                  ),
                                ),
                                new Container(
                                  padding: EdgeInsets.only(left: 3.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    verticalDirection: VerticalDirection.down,
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        categories.categoryName,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Text(
                                          'Author Name : ' + categories.author),
                                      Text('Total Songs : 33'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          FlatButton(
                                            child: Icon(Icons.favorite),
                                            onPressed: () {
                                              /* ... */
                                            },
                                          ),
                                          FlatButton(
                                            child: Icon(Icons.share),
                                            onPressed: () {
                                              /* ... */
                                            },
                                          ),
                                          FlatButton(
                                            child: Icon(Icons.alarm),
                                            onPressed: () {
                                              /* ... */
                                            },
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CategoryDetailPage(
                                          id: categories.id,
                                          author: categories.author,
                                          category_Name:
                                              categories.categoryName,
                                          image: categories.image,
                                        )));
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              );
            });
      }

      return Center(child: new CircularProgressIndicator());
    });

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                child: Stack(
                  children: <Widget>[
                    Image.network(item, fit: BoxFit.cover, width: 1000.0),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(200, 0, 0, 0),
                              Color.fromARGB(0, 0, 0, 0)
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();
Future<List<Categories>> fetchCategories(BuildContext context) async {
  final jsonString = await http
      .get('https://avstechs.in/kalanjiyam/api/categories/all_categories.php');

  // debugPrint(jsonString);
  return categoriesFromJson(jsonString.body);
}

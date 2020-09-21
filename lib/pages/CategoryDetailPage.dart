import 'package:flutter/material.dart';
import 'package:kalanjiyam/Categories.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kalanjiyam/Songs.dart';
import 'package:kalanjiyam/SongDetails.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() => runApp(CategoryDetailPage());

class CategoryDetailPage extends StatefulWidget {
  final String id;
  final String author;
  final String category_Name;
  final String image;

  final _audioPlayer = AudioPlayer();

  CategoryDetailPage(
      {Key key, this.id, this.author, this.category_Name, this.image})
      : super();
  @override
  _CategoryDetailPageState createState() => _CategoryDetailPageState();
}

class _CategoryDetailPageState extends State<CategoryDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              centerTitle: false,
              flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  titlePadding: EdgeInsetsDirectional.fromSTEB(30, 25, 0, 10),
                  title: ListTile(
                    title: Text(widget.category_Name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                        )),
                    subtitle: Text(
                      widget.author,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  background: Image.network(
                    widget.image,
                    fit: BoxFit.cover,
                  )),
            ),
          ];
        },
        body: Container(
          margin: EdgeInsets.all(20),
          alignment: Alignment.topLeft,
          child:
              //  Padding(padding: EdgeInsets.fromLTRB(20.0, 5.0, 0.0, 0.0)),
              Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.category_Name + ' Collections',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: FutureBuilder(
                    future: fetchSongs(context, widget.id),
                    builder: (context, snapshot) {
                      final _audio = AudioPlayer();
                      if (snapshot.hasData) {
                        return ListView.builder(
                            itemCount: snapshot.data.length,
                            itemBuilder: (context, int i) {
                              SongList songList = snapshot.data[i];

                              print('Player' + _audio.playingStream.toString());

                              return new Container(
                                child: new Center(
                                  child: new Column(
                                    // mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Card(
                                        shadowColor: Colors.blueGrey,
                                        //elevation: 10,
                                        child: InkWell(
                                          child: Container(
                                            //    width: MediaQuery.of(context).size.width * 1,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  margin: EdgeInsets.all(5.0),
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    image: DecorationImage(
                                                        image: NetworkImage(
                                                          songList.image,
                                                        ),
                                                        fit: BoxFit.fill),
                                                  ),
                                                ),
                                                new Container(
                                                  padding: EdgeInsets.only(
                                                      left: 3.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    verticalDirection:
                                                        VerticalDirection.down,
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        songList.songName,
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600),
                                                      ),
                                                      Text('Author Name : ' +
                                                          songList.author),
                                                      SizedBox(
                                                        height: 40,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                ButtonBar(
                                                  children: <Widget>[
                                                    FlatButton(
                                                      child: Icon(
                                                        Icons
                                                            .play_circle_filled,
                                                        size: 44,
                                                      ),
                                                      onPressed: () {
                                                        /* ... */
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          onTap: () {
                                            _audio.playerStateStream
                                                .listen((event) {
                                              if (event.playing) {
                                                _audio.stop();
                                              }
                                            });

                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        SongDetails(
                                                            id: songList.id,
                                                            author:
                                                                songList.author,
                                                            song_name: songList
                                                                .songName,
                                                            image:
                                                                songList.image,
                                                            song_url: songList
                                                                .songUrl,
                                                            short_description:
                                                                songList
                                                                    .shortDescription)));
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
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget listOfSongs(BuildContext context) => FutureBuilder(
//     future: fetchSongs(context,context.widget.id),
//     builder: (context, snapshot) {
//       final _audio = AudioPlayer();
//       if (snapshot.hasData) {
//         return ListView.builder(
//             itemCount: snapshot.data.length,
//             itemBuilder: (context, int i) {
//               SongList songList = snapshot.data[i];

//               print('Player' + _audio.playingStream.toString());

//               return new Container(
//                 child: new Center(
//                   child: new Column(
//                     // mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Card(
//                         shadowColor: Colors.blueGrey,
//                         //elevation: 10,
//                         child: InkWell(
//                           child: Container(
//                             //    width: MediaQuery.of(context).size.width * 1,
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Container(
//                                   margin: EdgeInsets.all(5.0),
//                                   width: 50,
//                                   height: 50,
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     image: DecorationImage(
//                                         image: NetworkImage(
//                                           songList.image,
//                                         ),
//                                         fit: BoxFit.fill),
//                                   ),
//                                 ),
//                                 new Container(
//                                   padding: EdgeInsets.only(left: 3.0),
//                                   child: Column(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceEvenly,
//                                     verticalDirection: VerticalDirection.down,
//                                     mainAxisSize: MainAxisSize.min,
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Text(
//                                         songList.songName,
//                                         style: TextStyle(
//                                             fontSize: 20,
//                                             fontWeight: FontWeight.w600),
//                                       ),
//                                       Text('Author Name : ' + songList.author),
//                                       SizedBox(
//                                         height: 40,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 ButtonBar(
//                                   children: <Widget>[
//                                     FlatButton(
//                                       child: Icon(
//                                         Icons.play_circle_filled,
//                                         size: 44,
//                                       ),
//                                       onPressed: () {
//                                         /* ... */
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ),
//                           onTap: () {
//                             _audio.playerStateStream.listen((event) {
//                               if (event.playing) {
//                                 _audio.stop();
//                               }
//                             });

//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SongDetails(
//                                         id: songList.id,
//                                         author: songList.author,
//                                         song_name: songList.songName,
//                                         image: songList.image,
//                                         song_url: songList.songUrl,
//                                         short_description:
//                                             songList.shortDescription)));
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             });
//       }

//       return Center(child: new CircularProgressIndicator());
//     });

Future<List<SongList>> fetchSongs(BuildContext context, String id) async {
  final jsonString = await http.get(
      'https://avstechs.in/kalanjiyam/api/songs/get_single_song.php?category_id=$id');

  // debugPrint(jsonString);
  return songListFromJson(jsonString.body);
}

Widget bottomControl(BuildContext context) => Card(
      shadowColor: Colors.blueGrey,
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: InkWell(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Image(
                width: 120,
                image: AssetImage('assets/images/thiruvalluar_splash.png'),
              ),
              new Column(
                verticalDirection: VerticalDirection.down,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Category',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                  Text('Author Name : K. Vigneshwar'),
                  Text('Total Songs : 33'),
                  SizedBox(
                    height: 40,
                  ),
                  ButtonBar(
                    children: <Widget>[
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
                  ),
                ],
              ),
            ],
          ),
        ),
        // onTap: () {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => CategoryDetailPage()));
        //},
      ),
    );

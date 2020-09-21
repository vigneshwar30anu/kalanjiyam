import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:kalanjiyam/MusicPlayer/PlayerModel.dart';

void main() => runApp(SongDetails());

class SongDetails extends StatefulWidget {
  final String id;
  final String author;
  final String song_name;
  final String image;
  final String song_url;
  final String short_description;

  SongDetails(
      {Key key,
      this.id,
      this.author,
      this.song_name,
      this.image,
      this.song_url,
      this.short_description});

  @override
  _SongDetailsState createState() => _SongDetailsState();
}

class _SongDetailsState extends State<SongDetails> {
  final _audioPlayer = AudioPlayer();
  PlayerModel model;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    audioStart();
  }

  Future<void> audioStart() async {
    _audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        //model.update(true);

      } else {
        _audioPlayer.setUrl(widget.song_url);
        _audioPlayer.play();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text(widget.song_name),

        // automaticallyImplyLeading: false, // this is to disable drawer icon
        backgroundColor: Color.fromRGBO(19, 71, 110, 0.9),
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.bottomCenter,
            height: 400,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    widget.image,
                  ),
                  fit: BoxFit.cover),
            ),
            child: Container(
              padding: EdgeInsets.all(10),
              decoration:
                  BoxDecoration(color: Color.fromRGBO(255, 255, 255, 0.6)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    child: Icon(
                      Icons.fast_rewind,
                      size: 40,
                    ),
                  ),
                  Icon(Icons.skip_previous, size: 40),
                  // InkWell(

                  //   child: Icon(
                  //     Icons.play_circle_filled, size: 40),
                  //   onTap: () {
                  //     _audioPlayer.setUrl(widget.song_url);
                  //     _audioPlayer.stop();
                  //   },
                  // ),

                  new IconButton(
                      icon: new Icon(
                        _playing
                            ? Icons.pause_circle_filled
                            : Icons.play_circle_filled,
                      ),
                      onPressed: () {
                        setState(() {
                          if (model.isPlaying) {
                            _audioPlayer.pause();
                            model.update(null);
                          } else {
                            _audioPlayer.play();
                            model.update(null);
                          }

                          //<--update alreadSaved
                        });
                      }),

                  Icon(Icons.skip_next, size: 40),
                  Icon(Icons.fast_forward, size: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  onPressed() {
    if (model.isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
  }
}

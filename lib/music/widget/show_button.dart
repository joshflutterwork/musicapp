import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ShowButtonWidget extends StatefulWidget {
  final String imageUrl;
  final String urlSong;
  final AudioPlayer player;
  final String title;

  ShowButtonWidget({this.player, this.imageUrl, this.urlSong, this.title});
  @override
  State<ShowButtonWidget> createState() => _ShowButtonWidgetState();
}

class _ShowButtonWidgetState extends State<ShowButtonWidget> {
  bool playing = false;
  void seekToSec(int sec) {
    Duration newPos = Duration(milliseconds: sec);
    _player.seek(newPos);
  }

  Widget slider() {
    return Container(
      width: 200.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Slider.adaptive(
              activeColor: Colors.black,
              inactiveColor: Colors.grey[350],
              value: position?.inMilliseconds?.toDouble() ?? 0.0,
              max: musicLength?.inMilliseconds?.toDouble() ?? 0.0,
              onChanged: (value) {
                seekToSec(value.toInt());
              }),
          Text(
            widget.title,
            style: TextStyle(color: Colors.white),
          )
        ],
      ),
    );
  }

  Duration musicLength;
  Duration position;
  final AudioPlayer _player = AudioPlayer();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _player.setUrl(widget.urlSong);

    _player.play(widget.urlSong);
    playing = true;

    _player.onDurationChanged.listen((d) => setState(() => musicLength = d));

    _player.onAudioPositionChanged.listen((p) => setState(() => position = p));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _player.dispose();
    _player.onAudioPositionChanged.distinct();
    _player.onDurationChanged.distinct();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(),
        gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey,
              Colors.black45,
            ]),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(color: Colors.grey),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                slider(),
                Text(
                  "${position?.inMinutes}:${position?.inSeconds?.remainder(60)}",
                  style: const TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
                IconButton(
                    iconSize: 62.0,
                    color: Colors.black,
                    onPressed: () {
                      //here we will add the functionality of the play button
                      if (!playing) {
                        //now let's play the song

                        setState(() {
                          _player.play(
                            widget.urlSong,
                          );
                          // playBtn = Icons.pause;
                          playing = true;
                        });
                      } else {
                        _player.pause();
                        setState(() {
                          // playBtn = Icons.play_arrow;
                          playing = false;
                        });
                      }
                    },
                    icon: playing
                        ? Icon(
                            Icons.pause,
                          )
                        : Icon(Icons.play_arrow)),
              ],
            ),
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     IconButton(
          //       iconSize: 45.0,
          //       color: Colors.blue,
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.skip_previous,
          //       ),
          //     ),
          //     IconButton(
          //       iconSize: 62.0,
          //       color: Colors.blue[800],
          //       onPressed: () {
          //         //here we will add the functionality of the play button
          //         if (!playing) {
          //           //now let's play the song
          //           _player.play(
          //             "https://audio-ssl.itunes.apple.com/itunes-assets/AudioPreview125/v4/ff/47/ac/ff47acac-cd37-bfcd-7c81-b2a2363e912a/mzaf_4770048350788404385.plus.aac.p.m4a",
          //           );
          //           setState(() {
          //             playBtn = Icons.pause;
          //             playing = true;
          //           });
          //         } else {
          //           _player.pause();
          //           setState(() {
          //             playBtn = Icons.play_arrow;
          //             playing = false;
          //           });
          //         }
          //       },
          //       icon: Icon(
          //         playBtn,
          //       ),
          //     ),
          //     IconButton(
          //       iconSize: 45.0,
          //       color: Colors.blue,
          //       onPressed: () {},
          //       icon: Icon(
          //         Icons.skip_next,
          //       ),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}

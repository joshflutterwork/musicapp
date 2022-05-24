import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:musicapp/component_widget/dialogs_widget.dart';
import 'package:musicapp/music/bloc/music_bloc.dart';
import 'package:musicapp/music/widget/show_button.dart';

class MusicPage extends StatefulWidget {
  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  MusicBloc musicBloc = MusicBloc();

  final AudioPlayer _player = AudioPlayer(mode: PlayerMode.MEDIA_PLAYER);

  int currentIndex;

  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.black,
                  Colors.blueGrey,
                  Colors.grey,
                ]),
          ),
          child: ListView(
            children: [
              Container(
                  width: double.infinity,
                  height: 50,
                  child: TextFormField(
                    controller: _searchController,
                    obscureText: false,
                    decoration: InputDecoration(
                      labelText: "Search Artist Music",
                      hintText: "Search Artist Music",
                      fillColor: Colors.white,
                      filled: true,
                      contentPadding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide: BorderSide(color: Colors.grey)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide: BorderSide(color: Colors.grey.shade400)),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.0)),
                    ),
                    onEditingComplete: () {
                      musicBloc
                          .add(MusicAttempt(search: _searchController.text));
                      Navigator.of(context).pop();
                      currentIndex = null;
                    },
                  ),
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 5),
                    )
                  ])),
              Container(
                width: double.infinity,
                height: MediaQuery.of(context).size.height,
                child: BlocListener<MusicBloc, MusicState>(
                  bloc: musicBloc,
                  listener: (context, state) async {
                    if (state is MusicLoading) {
                      await DialogWidget().loading(context);
                    }
                    if (state is MusicLoaded) {
                      Navigator.pop(context);
                    }
                  },
                  child: BlocBuilder<MusicBloc, MusicState>(
                    bloc: musicBloc,
                    builder: (context, state) {
                      if (state is MusicLoaded)
                      // ignore: curly_braces_in_flow_control_structures
                      if (state.artistMusicModel.results.length > 0)
                        // ignore: curly_braces_in_flow_control_structures
                        return Expanded(
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.artistMusicModel.results.length,
                              itemBuilder: (_, index) {
                                // ignore: avoid_unnecessary_containers
                                return InkWell(
                                  onTap: () async {
                                    await _player.stop();

                                    setState(() {
                                      currentIndex = index;
                                    });

                                    showBottomSheet(
                                        context: context,
                                        builder: (context) {
                                          return ShowButtonWidget(
                                            imageUrl: state.artistMusicModel
                                                .results[index].artworkUrl100,
                                            player: _player,
                                            urlSong: state.artistMusicModel
                                                .results[index].previewUrl,
                                            title: state.artistMusicModel
                                                .results[index].trackName,
                                          );
                                        });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(top: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text("${index + 1}.",
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white)),
                                        Container(
                                          width: 100,
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              color: Colors.red),
                                          child: Image.network(
                                            state.artistMusicModel
                                                .results[index].artworkUrl100,
                                            fit: BoxFit.fitWidth,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Container(
                                          height: 150,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Container(
                                                width: 150,
                                                child: Text(
                                                  state
                                                          .artistMusicModel
                                                          .results[index]
                                                          .trackName ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                child: Text(
                                                  state
                                                          .artistMusicModel
                                                          .results[index]
                                                          .artistName ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ),
                                              Container(
                                                width: 100,
                                                child: Text(
                                                  state
                                                          .artistMusicModel
                                                          .results[index]
                                                          .collectionName ??
                                                      "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        currentIndex == index
                                            ? DialogWidget()
                                                .waveLoadDialog(context)
                                            : Container(
                                                width: 50,
                                              )
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        );
                      else {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "no data",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        );
                      }
                      else {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: Text(
                              "Search Your Music",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

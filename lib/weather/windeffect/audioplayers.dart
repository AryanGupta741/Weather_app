// import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';

// class WindSoundEffect extends StatefulWidget {
//   @override
//   _WindSoundEffectState createState() => _WindSoundEffectState();
// }

// class _WindSoundEffectState extends State<WindSoundEffect> {
//   final AudioPlayer _audioPlayer = AudioPlayer();

//   @override
//   void initState() {
//     super.initState();
//     playWindSound();
//   }

//   Future<void> playWindSound() async {
//     try {
//       // Play the sound and enable looping
//       await _audioPlayer.play(AssetSource('wind_sound.mp3'), volume: 1.0);
//       _audioPlayer.setReleaseMode(ReleaseMode.loop); // Loop the sound
//     } catch (e) {
//       print("Error playing sound: $e");
//     }
//   }

//   @override
//   void dispose() {
//     _audioPlayer.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(child: Text('Wind Sound Playing...')),
//     );
//   }
// }

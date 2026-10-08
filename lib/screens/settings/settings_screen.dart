import 'package:flutter/material.dart';
class SettingsScreen extends StatelessWidget{const SettingsScreen({super.key});@override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:const Text('Settings')),body:ListView(children:const[
 ListTile(leading:Icon(Icons.language),title:Text('Language'),subtitle:Text('Global multilingual support')),
 ListTile(leading:Icon(Icons.privacy_tip_outlined),title:Text('Privacy & Security')),
 ListTile(leading:Icon(Icons.help_outline),title:Text('Help & Support'))]));}
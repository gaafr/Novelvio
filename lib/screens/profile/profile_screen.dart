import 'package:flutter/material.dart';
import '../../core/services/supabase_service.dart';
class ProfileScreen extends StatefulWidget{const ProfileScreen({super.key});@override State<ProfileScreen> createState()=>_ProfileScreenState();}
class _ProfileScreenState extends State<ProfileScreen>{@override Widget build(BuildContext c){final u=SupabaseService.client?.auth.currentUser;return Scaffold(appBar:AppBar(title:const Text('Profile')),body:ListView(padding:const EdgeInsets.all(20),children:[
 const CircleAvatar(radius:42,child:Icon(Icons.person,size:42)),const SizedBox(height:16),Center(child:Text(u?.email??'Guest')),const SizedBox(height:20),
 ListTile(leading:const Icon(Icons.login),title:Text(u==null?'Sign in':'Signed in'),onTap:u==null?()=>Navigator.pushNamed(c,'/auth'):null),
 ListTile(leading:const Icon(Icons.settings),title:const Text('Settings'),onTap:()=>Navigator.pushNamed(c,'/settings')),
 if(u!=null)ListTile(leading:const Icon(Icons.logout),title:const Text('Sign out'),onTap:()async{await SupabaseService.client?.auth.signOut();setState((){});})
]));}}
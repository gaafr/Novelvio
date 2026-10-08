import 'package:flutter/material.dart';
import '../../core/services/supabase_service.dart';
class AuthScreen extends StatefulWidget{const AuthScreen({super.key});@override State<AuthScreen> createState()=>_AuthScreenState();}
class _AuthScreenState extends State<AuthScreen>{
 final email=TextEditingController(),password=TextEditingController();bool signUp=false,busy=false;String? error;
 Future<void> submit()async{final c=SupabaseService.client;if(c==null){setState(()=>error='Supabase is not configured.');return;}setState(()=>busy=true);try{if(signUp){await c.auth.signUp(email:email.text.trim(),password:password.text);}else{await c.auth.signInWithPassword(email:email.text.trim(),password:password.text);}if(mounted)Navigator.pop(context);}catch(e){setState(()=>error=e.toString());}finally{if(mounted)setState(()=>busy=false);}}
 @override Widget build(BuildContext c)=>Scaffold(appBar:AppBar(title:Text(signUp?'Create account':'Sign in')),body:ListView(padding:const EdgeInsets.all(20),children:[
 TextField(controller:email,decoration:const InputDecoration(labelText:'Email')),const SizedBox(height:12),TextField(controller:password,obscureText:true,decoration:const InputDecoration(labelText:'Password')),
 if(error!=null)Padding(padding:const EdgeInsets.only(top:12),child:Text(error!)),const SizedBox(height:20),FilledButton(onPressed:busy?null:submit,child:Text(signUp?'Create account':'Sign in')),
 TextButton(onPressed:()=>setState(()=>signUp=!signUp),child:Text(signUp?'I already have an account':'Create a new account'))]));}
}
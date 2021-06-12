import 'package:flutter/material.dart';
import 'package:json_parcing/model/Users.dart';
import 'package:json_parcing/service/Services.dart';
 
class JsonParseDemo extends StatefulWidget {
  //
//  JsonParseDemo() : super();
 
  @override
  _JsonParseDemoState createState() => _JsonParseDemoState();
}
 
class _JsonParseDemoState extends State<JsonParseDemo> {
  //
  List<User> _users;
  bool _loading = true;
  bool _show = false;
  List<User> _usersForDisplay;
  @override
  void initState() {
    super.initState();
    _loading = true;
    Services.getUsers().then((users) {
      setState(() {
        _users = users;
        _loading = false;
        _show = true;
        _usersForDisplay = _users;
      });
    });
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_loading ? 'Loading...' : 'Users'),
      ),
      body:  Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount:_usersForDisplay.length+1,
          itemBuilder: (context, index) {
            return index == 0? _searchBar(): _listItem(index-1);
          },
        ),
      ),
    );
  }
    _searchBar(){
      return Padding(padding: EdgeInsets.all(8),
      child: TextField(decoration: InputDecoration(hintText: 'search...'),
          onChanged: (text){
              text = text.toLowerCase();
              setState(() {
                _usersForDisplay = _users.where((user) {
                  var userName = user.username.toLowerCase();
                  return userName.contains(text);
                }).toList();
              });
          },
        ),
      );
    }
     _listItem(index){
      User user = _usersForDisplay[index];
            return  Card(borderOnForeground: true,
            elevation: 7.0,
            color: Colors.grey[50],
            margin: EdgeInsets.all(7),
            child: ListTile(
                leading: CircleAvatar(
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white, 
                    child: Text(user.id.toString())),
                title: Text(user.username),
                subtitle: Text(user.email),
              ),
            );
  }
}
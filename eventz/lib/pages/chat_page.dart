import 'package:awesome_flutter_widgets/widgets/awesome_textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventz/backend/models.dart';
import 'package:eventz/global_values.dart';
import 'package:eventz/utils/global_widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  final String chatId;
  const ChatPage({Key key, @required this.chatId}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<String> mediaUrls;
  TextEditingController _msg = TextEditingController();
  Future<void> sendMsg(msg) async {
    if (msg != null && msg != '')
      await FirebaseFirestore.instance
          .collection('chats')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .collection('chats')
          .add({
        'msg': msg,
        'senderId': FirebaseAuth.instance.currentUser.uid,
        'senderName': FirebaseAuth.instance.currentUser.displayName,
        'mediaUrls': mediaUrls,
        'timestamp': DateTime.now()
      });
    setState(() {
      mediaUrls = null;
      _msg.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        // backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Column(
          children: [
            Image.asset(
              GlobalValues.logoImageBlue,
              height: 60,
              width: 60,
            ),
            SubtitleText(
              'Live Chat 🔥',
              // fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            )
          ],
        ),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance
            .collection('chats')
            .doc(widget.chatId)
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData)
            return Center(
              child: SpinKitThreeBounce(
                color: Theme.of(context).primaryColor,
              ),
            );
          else {
            if (!snapshot.data.exists) {
              snapshot.data.reference.set({
                'senderId': FirebaseAuth.instance.currentUser.uid,
                'senderEmail': FirebaseAuth.instance.currentUser.email,
                'senderName': FirebaseAuth.instance.currentUser.displayName,
              });
            }
            return Stack(
              children: [
                Center(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    margin: EdgeInsets.only(bottom: 80.0),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('chats')
                          .doc(widget.chatId)
                          .collection('chats')
                          .orderBy('timestamp', descending: true)
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData)
                          return Center(
                            child: SpinKitThreeBounce(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        else
                          return ListView.builder(
                              reverse: true,
                              itemCount: snapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                Chat chat =
                                    Chat.fromDoc(snapshot.data.docs[index]);
                                bool isMe = chat.senderId ==
                                    FirebaseAuth.instance.currentUser.uid;
                                return ChatTile(
                                  isMe: isMe,
                                  chat: chat,
                                );
                              });
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: 100,
                    child: AwesomeTextField(
                      controller: _msg,
                      backgroundColor: Colors.black.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                      prefixIconConstraints: BoxConstraints(maxWidth: 55),
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FaIcon(
                          FontAwesomeIcons.solidComments,
                          color: Colors.grey,
                        ),
                      ),
                      hintText: 'Say something',
                      maxLines: 1,
                      suffix: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                            padding: EdgeInsets.zero,
                            splashRadius: 30,
                            onPressed: () {
                              sendMsg(_msg.text);
                            },
                            icon: FaIcon(
                              FontAwesomeIcons.solidPaperPlane,
                              color: Theme.of(context).primaryColor,
                            )),
                      ),
                      onSubmitted: (s) {
                        sendMsg(s);
                      },
                      borderType: InputBorderType.none,
                      hintStyle: TextStyle(color: Colors.grey),
                      inputStyle: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                )
              ],
            );
          }
        },
      ),
    );
  }
}

class ChatTile extends StatelessWidget {
  final Chat chat;
  final bool isMe;
  const ChatTile({Key key, @required this.chat, @required this.isMe})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isMe
          ? EdgeInsets.only(left: 150.0).add(EdgeInsets.all(8.0))
          : EdgeInsets.only(right: 150.0).add(EdgeInsets.all(8.0)),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
              color: !isMe
                  ? Theme.of(context).primaryColor
                  : Theme.of(context).cardColor,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: SubtitleText(
                chat.msg,
                fontSize: 18,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SubtitleText(
              DateFormat('MMM dd, h:m a').format(chat.timestamp.toDate()),
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}

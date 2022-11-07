import 'package:flutter/material.dart';
import 'package:pro_coach/models/message.dart';
import 'package:pro_coach/services/supabase_service.dart';
import 'package:pro_coach/widgets/custom_message.dart';
import 'package:pro_coach/widgets/custom_waiting_animation.dart';

import '../widgets/custom_background.dart';

class TraineeChat extends StatefulWidget {
  TraineeChat({
    required this.id,
    required this.title,
  });

  final String id;
  final String title;

  @override
  State<TraineeChat> createState() => _TraineeChatState();
}

class _TraineeChatState extends State<TraineeChat> {
  final controller = TextEditingController();
  String currentMessage = '';

  Future<void> send() async {
    try {
      await SupabaseService.addMessage(to: widget.id, message: currentMessage);
      setState(() {
        Message.allMessages.add(Message(
            SupabaseService.supabaseClient.auth.currentUser!.id,
            currentMessage,
            DateTime.now().toString()));
      });
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Cannot Send a Message Try Again Later',
                textAlign: TextAlign.center,
              ),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffDFF6FF),
      appBar: AppBar(
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_rounded),
          ),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff06283D).withOpacity(0.9),
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          //backGround Design
          CustomBackground(),

          //body
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Container(
                  child: FutureBuilder(
                    future: SupabaseService.getMessages(id: widget.id),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                          itemCount: Message.allMessages.length,
                          reverse: true,
                          itemBuilder: (context, index) {
                            //TODO Message Texts
                            return CustomMessage(
                              from: Message.allMessages[index].from,
                              message: Message.allMessages[index].message,
                              created_at: Message.allMessages[index].created_at,
                            );
                          },
                        );
                      } else {
                        return CustomWaitingAnimation();
                      }
                    },
                  ),
                ),
              ),
              Container(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Enter Your Message',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        controller: controller,
                        onChanged: (value) {
                          currentMessage = value;
                        },
                      ),
                    ),
                    Material(
                      clipBehavior: Clip.hardEdge,
                      color: Color(0xff06283D),
                      child: InkWell(
                        onTap: send,
                        splashColor: Colors.grey.withOpacity(0.3),
                        highlightColor: Colors.transparent,
                        child: Container(
                          width: 80,
                          height: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'Send',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

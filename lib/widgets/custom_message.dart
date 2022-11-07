import 'package:flutter/material.dart';
import 'package:pro_coach/services/supabase_service.dart';

class CustomMessage extends StatelessWidget {
  CustomMessage({
    required this.from,
    required this.message,
    required this.created_at,
  });

  final from;
  final String message;
  final String created_at;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          SupabaseService.supabaseClient.auth.currentUser!.id == from
              ? MainAxisAlignment.end
              : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: SupabaseService.supabaseClient.auth.currentUser!.id == from
                ? Color(0xff06283D)
                : Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            message,
            style: TextStyle(
              fontSize: 18,
              color: SupabaseService.supabaseClient.auth.currentUser!.id == from
                  ? Colors.white
                  : Color(0xff06283D),
            ),
          ),
        ),
      ],
    );
  }
}

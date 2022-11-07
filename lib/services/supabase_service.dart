import 'dart:io';

import 'package:pro_coach/models/message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase/supabase.dart';

class SupabaseService {
  static late SupabaseClient supabaseClient;

  static Future<void> initializeSupabase() async {
    supabaseClient = SupabaseClient(
      SupabaseCredentials.APIUrl,
      SupabaseCredentials.APIKey,
    );

    try {
      await restoreCurrentUser();
    } catch (e) {
      print('No Current User : $e');
    }
  }

  static Future<void> restoreCurrentUser() async {
    //Pull PERSIST_SESSION_KEY
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? session = prefs.getString('PERSIST_SESSION_KEY');

    if (session != null) {
      //Recover Session
      GotrueSessionResponse response =
          await supabaseClient.auth.recoverSession(session);

      //Error Occurred
      if (response.error != null) {
        prefs.remove('PERSIST_SESSION_KEY');
      } else {
        prefs.setString(
            'PERSIST_SESSION_KEY', response.data!.persistSessionString);
      }
      print(
          'Recovered Successfully : ${supabaseClient.auth.currentUser?.email}');
    }
  }

  static Future<void> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      GotrueSessionResponse response =
          await supabaseClient.auth.signUp(email, password);

      bool errorOccurred = response.error != null;

      //Authentication Error Occurred
      if (errorOccurred) {
        throw response.error!;

        //SignIn Successfully
      } else {
        //Store Current Session
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'PERSIST_SESSION_KEY',
          response.data!.persistSessionString,
        );

        print('Login Successfully : ${response.user?.email}');
      }

      //Authentication Error Catch
    } on GotrueError catch (e) {
      throw 'Authentication Failed : ${e.message}';

      //Unknown Error
    } catch (e) {
      throw 'Unknown Authentication, ERROR : ${e}';
    }
  }

  static Future<void> loginWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      GotrueSessionResponse response = await supabaseClient.auth.signIn(
        email: email,
        password: password,
      );

      bool errorOccurred = response.error != null;

      //Authentication Error Occurred
      if (errorOccurred) {
        throw response.error!;

        //SignIn Successfully
      } else {
        //Store Current Session
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString(
          'PERSIST_SESSION_KEY',
          response.data!.persistSessionString,
        );

        print('Login Successfully : ${response.user?.email}');
      }

      //Authentication Error Catch
    } on GotrueError catch (e) {
      throw 'Authentication Failed : ${e.message}';

      //Unknown Error
    } catch (e) {
      throw 'Unknown Authentication, ERROR : ${e}';
    }
  }

  static Future<dynamic> getCurrentUserInformation(String table) async {
    final idTitle;
    if (table == 'Coach') {
      idTitle = 'cid';
    } else {
      idTitle = 'tid';
    }
    try {
      final PostgrestResponse<dynamic> response = await supabaseClient
          .from(table)
          .select()
          .eq(idTitle, supabaseClient.auth.currentUser!.id)
          .execute();
      return response.data;
    } catch (e) {
      throw 'Failed to get My Activities, ERROR : $e';
    }
  }

  static Future<void> addTraineeInfo({
    required tid,
    required String name,
    required String city,
    required String phone,
    required String dob,
    required File imageFile,
    required String imageFileName,
  }) async {
    try {
      if (imageFileName != '') {
        imageFileName = (await uploadImage(
          id: tid,
          image: imageFile,
          imageName: imageFileName,
        ))!;
      } else {
        imageFileName =
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000';
      }
      Map values = {
        'tid': tid,
        'name': name,
        'city': city,
        'dob': dob,
        'phone_number': phone,
        'image': imageFileName,
      };
      await supabaseClient.from('Trainee').insert(values).execute();
    } catch (e) {
      throw 'Cannot Insert Trainee Info, ERROR: $e';
    }
  }

  static Future<void> addCoachInfo({
    required cid,
    required String name,
    required String city,
    required String bio,
    required String phone,
    required String price,
    required String gymUrl,
    required File certificateImage,
    required String certificateImageName,
    required File imageFile,
    required String imageFileName,
  }) async {
    try {
      if (certificateImageName != '') {
        certificateImageName = (await uploadCertificate(
          id: cid,
          image: certificateImage,
          imageName: certificateImageName,
        ))!;
      }
      if (imageFileName != '') {
        imageFileName = (await uploadImage(
          id: cid,
          image: imageFile,
          imageName: imageFileName,
        ))!;
      } else {
        imageFileName =
            'https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=2000';
      }
    } catch (e) {
      throw 'Cannot Upload Coach certificate, ERROR: $e';
    }
    Map values = {
      'cid': cid,
      'name': name,
      'city': city,
      'bio': bio,
      'gym_url': gymUrl,
      'phone_number': phone,
      'price': price,
      'certificate': certificateImageName,
      'image': imageFileName
    };
    try {
      await supabaseClient.from('Coach').insert(values).execute();
    } catch (e) {
      throw 'Cannot Insert Coach Info, ERROR: $e';
    }
  }

  static Future<void> subscribe({
    required bool coach,
    aid,
    cid,
  }) async {
    if (!coach) {
      Map values = {
        'tid': supabaseClient.auth.currentUser!.id,
        'aid': aid,
      };
      try {
        final res = await supabaseClient.from('Join').insert(values).execute();
        if (res.error != null) {
          throw 'Error';
        }
      } catch (e) {
        throw 'Cannot Insert Activity, ERROR: $e';
      }
    } else {
      final DateTime now = new DateTime.now();
      String date;
      if (now.month == 12) {
        date = '${now.year}-${1}-${now.day}';
      } else {
        date = '${now.year}-${now.month + 1}-${now.day}';
      }
      Map values = {
        'tid': supabaseClient.auth.currentUser!.id,
        'cid': cid,
        'start': '${now.year}-${now.month}-${now.day}',
        'end': date,
      };

      try {
        await supabaseClient.from('Subscribe').insert(values).execute();
      } catch (e) {
        throw 'Cannot Insert Subscribe, ERROR: $e';
      }
    }
  }

  static Future<void> removeActivity({
    required aid,
  }) async {
    try {
      await supabaseClient
          .from('Join')
          .delete()
          .eq('aid', aid)
          .eq('tid', supabaseClient.auth.currentUser!.id)
          .execute();
    } catch (e) {
      throw 'Cannot Remove Activity, ERROR: $e';
    }
  }

  static Future<void> deleteActivity({
    required aid,
  }) async {
    try {
      await supabaseClient.from('Join').delete().eq('aid', aid).execute();
      await supabaseClient.from('Activity').delete().eq('aid', aid).execute();
    } catch (e) {
      throw 'Cannot Delete Activity, ERROR: $e';
    }
  }

  static Future<void> addActivity({
    required String price,
    required String description,
    required String location,
    required String type,
    required String image,
  }) async {
    Map values = {
      'cid': supabaseClient.auth.currentUser!.id,
      'price': price,
      'description': description,
      'location': location,
      'type': type,
      'image': image,
    };
    try {
      await supabaseClient.from('Activity').insert(values).execute();
    } catch (e) {
      throw 'Cannot Insert Activity, ERROR: $e';
    }
  }

  static Future<void> addMessage({
    required to,
    required String message,
  }) async {
    Map values = {
      'from': supabaseClient.auth.currentUser!.id,
      'to': to,
      'message': message,
    };
    try {
      final PostgrestResponse<dynamic> response =
          await supabaseClient.from('Messages').insert(values).execute();
      if (response.error != null) {
        throw 'Error';
      }
    } catch (e) {
      throw 'Cannot Insert Message, ERROR: $e';
    }
  }

  static Future<void> getMessages({
    required id,
  }) async {
    Message.allMessages.clear();
    try {
      final PostgrestResponse<dynamic> responseAllMessages = await supabaseClient
          .from('Messages')
          .select('*')
          .or('and(from.eq.$id,to.eq.${supabaseClient.auth.currentUser!.id}),and(to.eq.$id,from.eq.${supabaseClient.auth.currentUser!.id})')
          .order('created_at')
          .execute();
      for (int i = 0; i < responseAllMessages.data.length; i++) {
        Message.allMessages.add(Message(
          responseAllMessages.data[i]['from'],
          responseAllMessages.data[i]['message'],
          responseAllMessages.data[i]['created_at'],
        ));
      }
    } catch (e) {
      throw 'Failed to get My Trainees, ERROR : $e';
    }
  }

  static Future<String?> uploadCertificate({
    required String id,
    required File image,
    required String imageName,
  }) async {
    try {
      await supabaseClient.storage
          .from('certificates')
          .upload('users/$id/$imageName', image);
      return await supabaseClient.storage
          .from('certificates')
          .getPublicUrl('users/$id/$imageName')
          .data;
    } catch (e) {
      throw 'Cannot upload Certificate, ERROR: $e';
    }
  }

  static Future<String?> uploadImage({
    required String id,
    required File image,
    required String imageName,
  }) async {
    try {
      await supabaseClient.storage
          .from('certificates')
          .upload('profile_images/users/$id/$imageName', image);
      return await supabaseClient.storage
          .from('certificates')
          .getPublicUrl('profile_images/users/$id/$imageName')
          .data;
    } catch (e) {
      throw 'Cannot upload Image, ERROR: $e';
    }
  }

  static Future<void> signOut() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove('PERSIST_SESSION_KEY');
      await supabaseClient.auth.signOut();
      print('Signed out Successfully');
    } catch (e) {
      throw 'Failed to sign out, ERROR : $e';
    }
  }

  static Future<int> checkIfVerified() async {
    try {
      final id = supabaseClient.auth.currentUser?.id;
      final isVerified = await supabaseClient
          .from('Coach')
          .select('verified')
          .eq('cid', id)
          .execute();

      if (isVerified.data[0]['verified'] as bool) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return -1;
    }
  }

  static Future<dynamic> getCoachs() async {
    try {
      final PostgrestResponse<dynamic> myCoachsCids = await supabaseClient
          .from('Subscribe')
          .select('cid')
          .eq('tid', supabaseClient.auth.currentUser!.id)
          .execute();

      String myCoachsValues = '';
      for (int i = 0; i < myCoachsCids.data.length; i++) {
        if (i == 0) {
          myCoachsValues = myCoachsCids.data[i]['cid'];
        } else {
          myCoachsValues = '$myCoachsValues,${myCoachsCids.data[i]['cid']}';
        }
      }
      myCoachsValues = '($myCoachsValues)';
      final PostgrestResponse<dynamic> otherCoachs = await supabaseClient
          .from('Coach')
          .select('*')
          .eq('verified', true)
          .not('cid', 'in', myCoachsValues)
          .execute();
      return otherCoachs.data;
    } catch (e) {
      throw 'Failed to get Coachs, ERROR : $e';
    }
  }

  static Future<dynamic> getActivities() async {
    try {
      final PostgrestResponse<dynamic> myActivityAids = await supabaseClient
          .from('Join')
          .select('aid')
          .eq('tid', supabaseClient.auth.currentUser!.id)
          .execute();
      String myActivitiesValues = '';
      for (int i = 0; i < myActivityAids.data.length; i++) {
        if (i == 0) {
          myActivitiesValues = myActivityAids.data[i]['aid'];
        } else {
          myActivitiesValues =
              '$myActivitiesValues,${myActivityAids.data[i]['aid']}';
        }
      }
      myActivitiesValues = '($myActivitiesValues)';
      final PostgrestResponse<dynamic> otherActivities = await supabaseClient
          .from('Activity')
          .select('*')
          .eq('accepted', true)
          .not('aid', 'in', myActivitiesValues)
          .execute();
      return otherActivities.data;
    } catch (e) {
      throw 'Failed to get Activities, ERROR : $e';
    }
  }

  static Future<dynamic> getActivityParticipants({
    required id,
  }) async {
    try {
      final PostgrestResponse<dynamic> myActivityParticipants =
          await supabaseClient
              .from('Join')
              .select('tid')
              .eq('aid', id)
              .execute();
      List<String> myActivitiesParticipantsValues = [];
      for (int i = 0; i < myActivityParticipants.data.length; i++) {
        myActivitiesParticipantsValues
            .add(myActivityParticipants.data[i]['tid']);
      }
      final PostgrestResponse<dynamic> otherActivities = await supabaseClient
          .from('Trainee')
          .select('*')
          .in_('tid', myActivitiesParticipantsValues)
          .execute();
      return otherActivities.data;
    } catch (e) {
      throw 'Failed to get Activity Participants, ERROR : $e';
    }
  }

  static Future<List<dynamic>> getMyCoachsAndActivities() async {
    try {
      final List<dynamic> data = [];
      final PostgrestResponse<dynamic> responseC =
          await supabaseClient.from('Subscribe').select('''*,Coach(*)
          ''').eq('tid', supabaseClient.auth.currentUser!.id).execute();

      final PostgrestResponse<dynamic> responseA =
          await supabaseClient.from('Join').select('''*,Activity(*)
          ''').eq('tid', supabaseClient.auth.currentUser!.id).execute();
      data.add(responseC.data);
      data.add(responseA.data);
      return data;
    } catch (e) {
      throw 'Failed to get My Coachs And Activities, ERROR : $e';
    }
  }

  static Future<dynamic> getMyTrainees() async {
    try {
      final PostgrestResponse<dynamic> response =
          await supabaseClient.from('Subscribe').select('''*,Trainee(*)
          ''').eq('cid', supabaseClient.auth.currentUser!.id).execute();
      return response.data;
    } catch (e) {
      throw 'Failed to get My Trainees, ERROR : $e';
    }
  }

  static Future<dynamic> getMyActivities() async {
    try {
      final PostgrestResponse<dynamic> response = await supabaseClient
          .from('Activity')
          .select()
          .eq('accepted', true)
          .eq('cid', supabaseClient.auth.currentUser!.id)
          .execute();
      return response.data;
    } catch (e) {
      throw 'Failed to get My Activities, ERROR : $e';
    }
  }
}

class SupabaseCredentials {
  static const String APIKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVqenFieHBiZmFyd3lubGl3Z2x4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NjQxMjUwNzQsImV4cCI6MTk3OTcwMTA3NH0.AwmBHGv1SD2Q2H77VlHCivyp7So_8nIidlugftY9tSk';
  static const String APIUrl = 'https://ujzqbxpbfarwynliwglx.supabase.co';
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';

class Database {
  static const String emptyString = "none";

  static String usersString = "Users";
  static String idString = "id";
  static String emailString = "email";
  static String usernameString = "username";
  static String nameString = "name";
  static String registeredDateString = "registeredDate";
  static String profileImageString = "profileImage";

  static String followString = "Follow";
  static String followersString = "Followers";
  static String followingString = "Following";

  static String searchLogString = "SearchLogs";

  static String postsString = "Posts";
  static String useridString = "userid";
  static String contentString = "content";
  static String showContentString = "showContent";
  static String imageString = "image";

  static String favoritesString = "Favorites";
  static String commentsString = "Comments";
  static String commentString = "comment";

  static String dateString = "date";

  static String keyString = "key";

  static String defaultValue = "default";

  static FirebaseDatabase getDatabase() {
    FirebaseDatabase database = FirebaseDatabase.instance;
    database.setLoggingEnabled(false);
    if (!kIsWeb) {
      database.setPersistenceEnabled(true);
      database.setPersistenceCacheSizeBytes(10000000);
    }
    return database;
  }

  static DatabaseReference getReference(String ref, {bool keepsynced = true}) {
    FirebaseDatabase database = getDatabase();
    DatabaseReference reference = database.ref(ref);
    setKeepSynced(reference, keepsynced);
    return reference;
  }

  static void setKeepSynced(DatabaseReference databaseReference, bool status) {
    if (!kIsWeb) {
      databaseReference.keepSynced(status);
    }
  }

  static void printError(Object e) {
    if (kDebugMode) {
      print("Veritabanı Hatası: " + e.toString());
    }
  }
}

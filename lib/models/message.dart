class Message {
  Message(
    this.from,
    this.message,
    this.created_at,
  );
  late String from;
  late String message;
  late String created_at;

  static List<Message> allMessages = [];
}

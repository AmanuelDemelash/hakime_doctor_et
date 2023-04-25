class MySubscription {
// bankinfo
  static String bankinfo = """
query bankinfo(\$id:Int!){
  bank_informations(where: {doctor_id: {_eq:\$id}}) {
    bank_name
    account_number
    full_name
    id
  }
}
""";
// experiance
  static String experiance = """
query experiance(\$id:Int!){
  experiences(where: {doctor_id: {_eq:\$id}}) {
    id
    department
    designation
    hospital_name
    start_date
    end_date
  }
}
""";
// chat body

  static String chat_body = '''
subscription chats(\$doctor_id:Int!,\$user_id:Int!){
  chats(where: {doctor_id: {_eq:\$doctor_id}, user_id: {_eq:\$user_id}},order_by: {created_at: desc}) {
    message
    from
    updated_at
    doctor {
     profile_image {
        url
      }
    }
  }
}
''';

// user notification
  static String user_notification = """
subscription(\$id:Int!){
  notifications(where: {user_id: {_eq:\$id}}) {
    id
    title
    description
    type
  }
}

""";
}

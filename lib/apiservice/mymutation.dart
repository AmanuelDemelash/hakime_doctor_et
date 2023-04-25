class Mymutation {
  // user signup
  static String usersignup = """ 
mutation userSignUp(\$full_name:String!,\$sex:String!,\$phone_number:String!,\$email:String!,\$password:String!,\$date_of_birth:String!) {
  userSignUp(full_name: \$full_name, sex:\$sex, phone_number:\$phone_number, email:\$email, password:\$password,date_of_birth:\$date_of_birth)
  {
    id
    token
  }
}
""";
// doctor signup
  static String doctorsignup = """ 
mutation doctorSignUp(\$full_name:String!,\$user_name:String!,\$date_of_birth:String!,\$experience_year:Int!,\$licence:Int!,
\$speciallity:Int!,\$phone_number:String!,\$profile_picture:Int!,\$current_hospital:String!,
\$email:String!,\$password:String!,\$sex:String!) {
doctorSignUp(full_name:\$full_name, user_name:\$user_name,date_of_birth:\$date_of_birth,
   experience_year:\$experience_year,licence:\$licence,speciallity:\$speciallity,
    phone_number:\$phone_number,
    profile_picture:\$profile_picture,
    current_hospital:\$current_hospital, email:\$email,
   password:\$password, sex:\$sex) {
    id
    token
    code
  }
}
""";
  // login
  static String login = """
  mutation login(\$email:String!,\$password:String!){
  login(email:\$email, password:\$password) {
    id
    token
    user_name
  }
}
  """;

// upload_file
  static String uploadfile = """
mutation uploadImage(\$base64:String!){
  uploadImage(base64:\$base64) {
    id
  }
}
""";
// verifay
  static String verifay = """
mutation(\$code:String!,\$id:Int!) {
  verify(code:\$code, id:\$id) {
    id
    is_verified
  }
}
""";
// add bank info

  static String addbank_info = """
mutation(\$doctor_id:Int!,\$bank_name:String!,\$account_number:String!,\$full_name:String!){
  insert_bank_informations(objects: {bank_name:\$bank_name, account_number:\$account_number, doctor_id:\$doctor_id, full_name:\$full_name}) {
    returning {
      id
    }
  }
}
""";
// Delete bank info
  static String delete_bank_info = """
mutation(\$id:Int!){
  delete_bank_information_by_pk(id:\$id) {
    id
  }
}
""";
// update doc profile

  static String update_doc_pro = """
mutation(\$id:Int!,\$full_name:String!,\$user_name:String!,\$phone_number:String!,\$current_hospital:String!,\$experience_year:Int!,\$sex:String!,\$speciallity:Int!,\$date_of_birth:String!,\$bio:String!){
  update_doctors_by_pk(pk_columns: {id:\$id}, _set: {full_name:\$full_name, user_name:\$user_name, phone_number:\$phone_number, current_hospital:\$current_hospital, experience_year:\$experience_year, sex:\$sex, speciallity:\$speciallity, date_of_birth:\$date_of_birth, bio:\$bio}) {
    id
  }
}
""";
// add experiance
  static String add_experiance = """
  mutation(\$doctor_id:Int!,\$hospital_name:String!,\$designation:String!,\$department:String!,\$start_date:String!,\$end_date:String!){
     insert_experiences(objects: {doctor_id:\$doctor_id, hospital_name:\$hospital_name, designation:\$designation, department:\$department, start_date:\$start_date, end_date:\$end_date}) {
    affected_rows
  }
  }
""";
// delete experiance
  static String delete_experiance = """
mutation(\$id:Int!){
  delete_experiences_by_pk(id:\$id) {
    id
  }
}
""";
// update appointment statuss
  static String update_appo_statuss = """
  mutation(\$id:Int!,\$status:String!){
  update_appointments_by_pk(pk_columns: {id:\$id}, _set: {status:\$status}) {
    id
  }
}
""";
// insert notificatiob for users
  static String insert_notification = """
  mutation(\$user_id:Int!,\$title:String!,\$description:String!,\$type:String!){
  insert_notifications(objects: {user_id:\$user_id, title:\$title, description:\$description, type:\$type}) {
    returning {
      id
    }
  }
}
""";
// insert notificatiob for doctor
  static String insert_notification_doc = """
  mutation(\$title:String!,\$description:String!,\$type:String!,\$doctor_id:Int!){
  insert_notifications(objects: {title:\$title, description:\$description, type:\$type,doctor_id:\$doctor_id}) {
    returning {
      id
    }
  }
}
""";

// insert package
  static String insert_package = """
mutation(\$doctor_id:Int!,\$video:Int!,\$voice:Int!,\$chat:Int!){
  insert_packages(objects: {doctor_id:\$doctor_id, video:\$video, voice:\$voice, chat:\$chat}) {
    returning {
      id
    }
  }
}
""";
// update package
  static String update_package = """
mutation(\$doctor_id:Int!,\$video:Int!,\$voice:Int!,\$chat:Int!){
  update_packages(where: {doctor_id: {_eq:\$doctor_id}}, _set: {video:\$video, voice:\$voice, chat:\$chat}) {
    returning {
      id
    }
  }
}
""";
// pay
  static String pay = """
mutation(\$amount:Int!,\$doctor_id:Int!,\$user_id:Int!,\$first_name:String!,\$last_name:String!,\$email:String!){
  pay(amount:\$amount, doctor_id:\$doctor_id, user_id:\$user_id, first_name:\$first_name, last_name:\$last_name, email:\$email) {
    redirect_url
    ref_no
  }
}
""";
// verifay payment
  static String verifay_payment = """
mutation(\$ref_no:String!){
  verifyPayment(arg1: {ref_no:\$ref_no}) {
    status
  }
}
""";
// reschedule appointment
  static String reschedule_appointment = """
mutation(\$id:Int!,\$date:String!,\$time:String!){
  update_appointments_by_pk(pk_columns: {id:\$id}, _set: {date:\$date, time:\$time}) {
    id
  }
}
""";

// update user info
  static String update_user = """
mutation(\$id:Int!,\$full_name:String!,\$phone_number:String!,\$sex:String!,\$email:String!,\$date_of_birth:String!) {
  update_users_by_pk(pk_columns: {id:\$id}, _set: {full_name:\$full_name, phone_number:\$phone_number, sex:\$sex, email:\$email, date_of_birth:\$date_of_birth}) {
    id
  }
}

""";
// online statuss
  static String update_online_statuss = """
mutation(\$id:Int!,\$is_online:boolean!) {
  update_doctors_by_pk(pk_columns: {id:\$id}, _set: {is_online:\$is_online}) {
    id
    is_online
  }
}
""";
// review
  static String review = """
mutation(\$rate:Int!,\$user_id:Int!,\$doctor_id:Int!,\$review:String!){
  insert_reviews(objects: {rate:\$rate, review:\$review, user_id:\$user_id, doctor_id:\$doctor_id}) {
    returning {
      id
    }
  }
}
""";
// delete notification
  static String delete_notification = """
  mutation(\$id:Int!){
  delete_notifications_by_pk(id:\$id) {
    id
  }
}
""";
// refund request
  static String refund_request = """
mutation(\$id:Int!){
  insert_refund(objects: {appointment_id:\$id}) {
    returning {
      id
    }
  }
}
""";
//withdraw request
  static String withdraw_request = """
mutation(\$doctor_id:Int!,\$amount:Int!){
  insert_withdrawals(objects: {doctor_id:\$doctor_id, amount:\$amount}) {
    returning {
      id
    }
  }
}
""";
// update wallet when withdraw
  static String update_wallet_withdraw = """
mutation(\$id:Int!,\$wallet:Int!){
  update_doctors_by_pk(pk_columns: {id:\$id}, _set: {wallet:\$wallet}) {
    id
  }
}

""";

// send chat
  static String send_message = """
mutation(\$doctor_id:Int!,\$user_id:Int!,\$from:String!,\$to:String!,\$message:String!) {
  sendChat(doctor_id:\$doctor_id, user_id:\$user_id, from:\$from, to:\$to, message:\$message) {
    id
  }
}
""";

// insert appointment
  static String insert_appointment = """
  mutation(\$date:String!,\$time:String!,\$price:String!,\$user_id:Int!,\$doctor_id:Int!,\$package_type:String!,\$channel:String!,\$full_name:String!,\$age:Int!,\$problem:String!){
  insert_appointments(objects: {date:\$date, time:\$time, price:\$price, user_id:\$user_id, doctor_id:\$doctor_id, package_type:\$package_type, channel:\$channel, patient: {data: {full_name:\$full_name, age:\$age, problem:\$problem}}}) {
    returning {
      id
    }
  }
}
""";

// insert blog
  static String insert_blog = """
mutation(\$image:Int!,\$title:String!,\$sub_title:String!,\$content:String!,\$doctor_id:Int!){
  insert_blogs(objects: {image:\$image, title:\$title, sub_title:\$sub_title, content:\$content,doctor_id:\$doctor_id}) {
    returning {
      id
    }
  }
}
""";

// like blog
  static String like_blog = """
mutation(\$id:Int!) {
  update_blogs_by_pk(pk_columns: {id:\$id}, _inc: {like: 1}) {
    id
  }
}

""";

// add favorite
  static String add_favorite_doc = """
mutation(\$user_id:Int!,\$doctor_id:Int!) {
  insert_favorite(objects: {user_id:\$user_id, doctor_id:\$doctor_id}) {
    returning {
      id
    }
  }
}

""";
// delete fav doc
  static String delete_fav_doc = """
mutation(\$id:Int!) {
  delete_favorite_by_pk(id:\$id) {
    id
  }
}

""";
// forgot password
  static String forgot_password = """
mutation(\$email:String!) {
  forgotPassword(arg1: {email:\$email}) {
    id
  }
}
""";
// delete blog
  static String delete_blog = """
mutation(\$id:Int!) {
  delete_blogs_by_pk(id:\$id) {
    id
  }
}

""";
}

// ignore_for_file: unnecessary_new

class UserData {
  final int userId;
  final String userToken;
  final String firstName;
  final String lastName;
  final String emailId;
  final String mobileNumber;
  // final String city;
  // final String state;
  // final String callPreference;
  // final String notificationPreference;
  // final String languagePreference;
  // final String philosophyType;
  // final String address;
  // final String locationCoordinates;
  // final String lastScreen;

  UserData(
      {required this.userId,
      required this.userToken,
      required this.firstName,
      required this.lastName,
      required this.emailId,
      required this.mobileNumber,
      // required this.city,
      // required this.state,
      // required this.callPreference,
      // required this.notificationPreference,
      // required this.languagePreference,
      // required this.philosophyType,
      // required this.address,
      // required this.locationCoordinates,
      // required this.lastScreen
      });

  factory UserData.fromMap(Map<String, dynamic> json) => new UserData(
      userId: json['userId'],
      userToken: json['userToken'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      emailId: json['emailId'],
      mobileNumber: json['mobileNumber'],
      // city: json['city'],
      // state: json['state'],
      // callPreference: json['callPreference'],
      // notificationPreference: json['notificationPreference'],
      // languagePreference: json['languagePreference'],
      // philosophyType: json['philosophyType'],
      // address: json['address'],
      // locationCoordinates: json['locationCoordinates'],
      // lastScreen: json['lastScreen']
      );

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userToken': userToken,
      'firstName': firstName,
      'lastName': lastName,
      'emailId': emailId,
      'mobileNumber': mobileNumber,
      // 'city': city,
      // 'state': state,
      // 'callPreference': callPreference,
      // 'notificationPreference': notificationPreference,
      // 'languagePreference': languagePreference,
      // 'philosophyType': philosophyType,
      // 'address': address,
      // 'locationCoordinates': locationCoordinates,
      // 'lastScreen': lastScreen
    };
  }

  //  @override
  // String toString() {
  //   var result1 =
  //       'UserData{userId: $userId,userToken: $userToken,firstName: $firstName,lastName: $lastName,emailId: $emailId,mobileNumber: $mobileNumber,city: $city,state: $state,callPreference: $callPreference,notificationPreference: $notificationPreference,languagePreference: $languagePreference,philosophyType: $philosophyType,address: $address,locationCoordinates: $locationCoordinates,lastScreen: $lastScreen}';
  //   print(result1);
  //   return result1;
  // }
}

// ignore_for_file: unnecessary_new

class BookingData {
  final int templeId;
  final int priestId;
  final int serviceId;
  final DateTime serviceDate;
  final DateTime serviceTime;
  final int bookingId;
  final String serviceNotes;
  final String promoCode;

  BookingData(
      {required this.templeId,
      required this.priestId,
      required this.serviceId,
      required this.serviceDate,
      required this.serviceTime,
      required this.bookingId,
      required this.serviceNotes,
      required this.promoCode});

  factory BookingData.fromMap(Map<String, dynamic> json) => new BookingData(
      templeId: json['templeId'],
      priestId: json['priestId'],
      serviceId: json['serviceId'],
      serviceDate: json['serviceDate'],
      serviceTime: json['serviceTime'],
      bookingId: json['bookingId'],
      serviceNotes: json['serviceNotes'],
      promoCode: json['promoCode']);

  Map<String, dynamic> toMap() {
    return {
      'templeId': templeId,
      'priestId': priestId,
      'serviceId': serviceId,
      'serviceDate': serviceDate,
      'serviceTime': serviceTime,
      'bookingId': bookingId,
      'serviceNotes': serviceNotes,
      'promoCode': promoCode
    };
  }

  //  @override
  // String toString() {
  //   var result2 =
  //       'UserData{templeId: $templeId,priestId: $priestId,serviceId: $serviceId,serviceDate: $serviceDate,serviceTime: $serviceTime,bookingId: $bookingId,serviceNotes: $serviceNotes,promoCode: $promoCode}';
  //   print(result2);
  //   return result2;
  // }
}

class FilterData {
  final String templeType;
  final int templeDistanceMin;
  final int templeDistanceMax;
  final String priestType;
  final String priestSortby;
  final int priestDistanceMin;
  final int priestDistanceMax;
  final double priestBudgetMin;
  final double priestBudgetMax;
  final int priestRatingMin;
  final int priestRatingMax;
  final int templeRatingMin;
  final int templeRatingMax;
  final String templeSortby;

  FilterData(
      {required this.templeType,
      required this.templeDistanceMin,
      required this.templeDistanceMax,
      required this.priestType,
      required this.priestSortby,
      required this.priestDistanceMin,
      required this.priestDistanceMax,
      required this.priestBudgetMin,
      required this.priestBudgetMax,
      required this.priestRatingMin,
      required this.priestRatingMax,
      required this.templeRatingMin,
      required this.templeRatingMax,
      required this.templeSortby});

  factory FilterData.fromMap(Map<String, dynamic> json) => new FilterData(
        templeType: json['templeType'],
        templeDistanceMin: json['templeDistanceMin'],
        templeDistanceMax: json['templeDistanceMax'],
        priestType: json['priestType'],
        priestSortby: json['priestSortby'],
        priestDistanceMin: json['priestDistanceMin'],
        priestDistanceMax: json['priestDistanceMax'],
        priestBudgetMin: json['priestBudgetMin'],
        priestBudgetMax: json['priestBudgetMax'],
        priestRatingMin: json['priestRatingMin'],
        priestRatingMax: json['priestRatingMax'],
        templeRatingMin: json['templeRatingMin'],
        templeRatingMax: json['templeRatingMax'],
        templeSortby: json['templeSortby'],
      );

  Map<String, dynamic> toMap() {
    return {
      'templeType': templeType,
      'templeDistanceMin': templeDistanceMin,
      'templeDistanceMax': templeDistanceMax,
      'priestType': priestType,
      'priestSortby': priestSortby,
      'priestDistanceMin': priestDistanceMin,
      'priestDistanceMax': priestDistanceMax,
      'priestBudgetMin': priestBudgetMin,
      'priestBudgetMax': priestBudgetMax,
      'priestRatingMin': priestRatingMin,
      'priestRatingMax': priestRatingMax,
      'templeRatingMin': templeRatingMin,
      'templeRatingMax': templeRatingMax,
      'templeSortby': templeSortby
    };
  }

  //  @override
  // String toString() {
  //   var result1 =
  //       'UserData{userId: $userId,userToken: $userToken,firstName: $firstName,lastName: $lastName,emailId: $emailId,mobileNumber: $mobileNumber,city: $city,state: $state,callPreference: $callPreference,notificationPreference: $notificationPreference,languagePreference: $languagePreference,philosophyType: $philosophyType,address: $address,locationCoordinates: $locationCoordinates,lastScreen: $lastScreen}';
  //   print(result1);
  //   return result1;
  // }
}

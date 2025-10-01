class PatientListModel {
  final String id;
  final String name;
  final String date;
//  final String treatment;
  final String user;

  PatientListModel(
      {required this.id,
      required this.name,
      required this.date,
    //  required this.treatment,
      required this.user});


  factory PatientListModel.fromJson(Map<String,dynamic> json){
    return PatientListModel(
      id: json['id'], 
      name: json['name'],
      date: json['date_nd_time'],  
     // treatment:json['id'], 
      user: json['user'], );

  }    
}

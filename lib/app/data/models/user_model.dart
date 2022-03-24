class UserModel {
  String? uid;
  String? namaLengkap;
  String? tempatLahir;
  String? tanggalLahir;
  String? golonganDarah;
  String? email;
  String? username;
  String? password;

  UserModel(
      {
      this.uid,
      this.namaLengkap,
      this.tempatLahir,
      this.tanggalLahir,
      this.golonganDarah,
      this.email,
      this.username,
      this.password});

  UserModel.fromJson(Map<String, Object?> snapshot)
      : this(
          uid: 'uid',
          namaLengkap: snapshot['namaLengkap']! as String,
          tempatLahir: snapshot['tempatLahir']! as String,
          tanggalLahir: snapshot['tanggalLahir'] as String,
          golonganDarah: snapshot['golonganDarah']! as String,
          email: snapshot['email']! as String,
          username: snapshot['username']! as String,
          password: snapshot['password']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'uid': uid,
      'namaLengkap': namaLengkap,
      'tempatLahir': tempatLahir,
      'tanggalLahir': tanggalLahir,
      'golonganDarah': golonganDarah,
      'email': email,
      'username': username,
      'password': password
    };
  }
}

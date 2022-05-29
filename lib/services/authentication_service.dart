import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../models/appointment_model.dart';
import '../models/doctors_data.dart';
import '../models/enums.dart';

@lazySingleton
class AuthenticationService {
  AccountType accountType = AccountType.patient;
  Map<String, dynamic>? doctorInfo;

  AccountType? userType;

  User? get user => _authInstance.currentUser;

  final _authInstance = FirebaseAuth.instance;
  final _firestoreInstace = FirebaseFirestore.instance;

  Future<void> signUp(String email, String password, String name) async {
    try {
      await _authInstance.createUserWithEmailAndPassword(
          email: email, password: password);
      await _authInstance.currentUser?.updateDisplayName(name);
      await _firestoreInstace
          .collection('users')
          .doc(_authInstance.currentUser?.uid)
          .set({
        'id': _authInstance.currentUser?.uid,
        'name': _authInstance.currentUser?.displayName
      });
      userType = AccountType.patient;
      if (accountType == AccountType.doctor && doctorInfo != null) {
        doctorInfo!['name'] = name;
        doctorInfo!['id'] = _authInstance.currentUser?.uid;
        await _firestoreInstace
            .collection('doctors')
            .doc(_authInstance.currentUser?.uid)
            .set({'info': jsonEncode(doctorInfo)});
        userType = AccountType.doctor;
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<void> login(String email, String password) async {
    try {
      await _authInstance.signInWithEmailAndPassword(
          email: email, password: password);
      print(user);
      if (user != null) {
        DocumentSnapshot doctor =
            await _firestoreInstace.collection("doctors").doc(user!.uid).get();
        if (doctor.data() != null) {
          userType = AccountType.doctor;
          doctorInfo = jsonDecode(doctor.get("info").toString());
        } else {
          userType = AccountType.patient;
        }
      } else {
        throw ('null user');
      }
    } catch (e) {
      throw ('connection error');
    }
  }

  Future<void> logout() async {
    await _authInstance.signOut();
    accountType = AccountType.patient;
    doctorInfo = null;
    userType = null;
  }

  initialize() async {
    try {
      if (user != null) {
        DocumentSnapshot doctor =
            await _firestoreInstace.collection("doctors").doc(user!.uid).get();
        if (doctor.data() != null) {
          userType = AccountType.doctor;
          doctorInfo = jsonDecode(doctor.get("info").toString());
        } else {
          userType = AccountType.patient;
        }
      } else {
        throw ('null user');
      }
    } catch (e) {
      throw (e.toString());
    }
  }

  String dateTimeToString(DateTime dateTime) {
    final dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    return dateFormat.format(dateTime);
  }

  DateTime stringToDateTime(String dateString) {
    final dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    return dateFormat.parse(dateString);
  }

  Future<List<Appointment>?> getRequestedAppointments() async {
    try {
      List<Appointment> appointments = <Appointment>[];
      await _firestoreInstace
          .collection("appointments")
          .where("fromId", isEqualTo: user?.uid)
          .where("status", isEqualTo: "Pending")
          .get()
          .then((querySnapshot) async {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Appointment appointment = Appointment(
              id: documentSnapshot.get("id"),
              fromId: documentSnapshot.get("fromId"),
              fromName: documentSnapshot.get("fromName"),
              toId: documentSnapshot.get("toId"),
              toName: documentSnapshot.get("toName"),
              toSpecializations: documentSnapshot.get("toSpecializations"),
              dateTime: stringToDateTime(documentSnapshot.get("dateTime")),
              status: documentSnapshot.get("status"));
          if (appointment.isExpired() == true) {
            await setAppointmentExpired(appointment.id);
          } else {
            appointments.add(appointment);
          }
        }
      });
      return appointments;
    } catch (e) {
      return null;
    }
  }

  Future<List<Appointment>?> getAppointmentRequests() async {
    try {
      List<Appointment> appointments = <Appointment>[];
      await _firestoreInstace
          .collection("appointments")
          .where("toId", isEqualTo: user?.uid)
          .where("status", isEqualTo: "Pending")
          .get()
          .then((querySnapshot) async {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Appointment appointment = Appointment(
              id: documentSnapshot.get("id"),
              fromId: documentSnapshot.get("fromId"),
              fromName: documentSnapshot.get("fromName"),
              toId: documentSnapshot.get("toId"),
              toName: documentSnapshot.get("toName"),
              toSpecializations: documentSnapshot.get("toSpecializations"),
              dateTime: stringToDateTime(documentSnapshot.get("dateTime")),
              status: documentSnapshot.get("status"));
          if (appointment.isExpired() == true) {
            await setAppointmentExpired(appointment.id);
          } else {
            appointments.add(appointment);
          }
        }
      });
      return appointments;
    } catch (e) {
      return null;
    }
  }

  Future<List<Appointment>?> getAppointmentsTaken() async {
    try {
      List<Appointment> appointments = <Appointment>[];
      await _firestoreInstace
          .collection("appointments")
          .where("fromId", isEqualTo: user?.uid)
          .where("status", isEqualTo: "Approved")
          .get()
          .then((querySnapshot) async {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Appointment appointment = Appointment(
              id: documentSnapshot.get("id"),
              fromId: documentSnapshot.get("fromId"),
              fromName: documentSnapshot.get("fromName"),
              toId: documentSnapshot.get("toId"),
              toName: documentSnapshot.get("toName"),
              toSpecializations: documentSnapshot.get("toSpecializations"),
              dateTime: stringToDateTime(documentSnapshot.get("dateTime")),
              status: documentSnapshot.get("status"));
          if (appointment.isExpired() == true) {
            await setAppointmentExpired(appointment.id);
          } else {
            appointments.add(appointment);
          }
        }
      });
      return appointments;
    } catch (e) {
      return null;
    }
  }

  Future<List<Appointment>?> getAppointmentsGiven() async {
    try {
      List<Appointment> appointments = <Appointment>[];
      await _firestoreInstace
          .collection("appointments")
          .where("toId", isEqualTo: user?.uid)
          .where("status", isEqualTo: "Approved")
          .get()
          .then((querySnapshot) async {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Appointment appointment = Appointment(
              id: documentSnapshot.get("id"),
              fromId: documentSnapshot.get("fromId"),
              fromName: documentSnapshot.get("fromName"),
              toId: documentSnapshot.get("toId"),
              toName: documentSnapshot.get("toName"),
              toSpecializations: documentSnapshot.get("toSpecializations"),
              dateTime: stringToDateTime(documentSnapshot.get("dateTime")),
              status: documentSnapshot.get("status"));
          if (appointment.isExpired() == true) {
            await setAppointmentExpired(appointment.id);
          } else {
            appointments.add(appointment);
          }
        }
      });
      return appointments;
    } catch (e) {
      return null;
    }
  }

  setAppointmentExpired(String id) async {
    try {
      await _firestoreInstace
          .collection("appointments")
          .doc(id)
          .update({"status": "Expired"});
    } catch (e) {
      return;
    }
  }

  setAppointmentAccepted(String id, DateTime date) async {
    try {
      await _firestoreInstace
          .collection("appointments")
          .doc(id)
          .update({"status": "Approved", "dateTime": dateTimeToString(date)});
    } catch (e) {
      return;
    }
  }

  deleteAppointment(String id) async {
    await _firestoreInstace.collection("appointments").doc(id).delete();
  }

  createAppointment(Doctor doctor) async {
    try {
      DocumentReference document =
          await _firestoreInstace.collection("appointments").add({
        "dateTime":
            dateTimeToString(DateTime.now().add(const Duration(days: 3))),
        "fromId": user!.uid,
        "fromName": user!.displayName!,
        "id": "xoxoxoxoxoxox",
        "status": "Pending",
        "toId": doctor.id,
        "toName": doctor.name,
        "toSpecializations": doctor.specialization?.join(', ') ?? ''
      });
      await _firestoreInstace
          .collection("appointments")
          .doc(document.id)
          .update({"id": document.id});
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<bool?> checkAppointmentExistence(Doctor doctor) async {
    try {
      QuerySnapshot querySnapshot1 = await _firestoreInstace
          .collection("appointments")
          .where("fromId", isEqualTo: user!.uid)
          .where("toId", isEqualTo: doctor.id)
          .where("status", isEqualTo: "Pending")
          .get();
      QuerySnapshot querySnapshot2 = await _firestoreInstace
          .collection("appointments")
          .where("fromId", isEqualTo: user!.uid)
          .where("toId", isEqualTo: doctor.id)
          .where("status", isEqualTo: "Approved")
          .get();
      if ((querySnapshot1.size + querySnapshot2.size) == 0) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<Doctor>> getDoctors() async {
    List<Doctor> doctors = <Doctor>[];
    try {
      await _firestoreInstace
          .collection("doctors")
          .get()
          .then((querySnapshot) async {
        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          Doctor doctor =
              Doctor.fromJson(jsonDecode(documentSnapshot.get("info")));
          doctor.doctorType = DoctorType.registered;
          doctors.add(doctor);
        }
      });
      return doctors;
    } catch (e) {
      return doctors;
    }
  }
}

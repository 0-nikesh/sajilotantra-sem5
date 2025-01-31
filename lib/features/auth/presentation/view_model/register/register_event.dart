import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

sealed class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterUserEvent extends RegisterEvent {
  final BuildContext context;
  final String fname;
  final String lname;
  final String email;
  // final String? profileImage;
  final String password;
  final String confirmPassword;
  final File file;

  const RegisterUserEvent({
    required this.context,
    required this.fname,
    required this.lname,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.file,
  });

  @override
  List<Object> get props => [
        fname,
        lname,
        email,
        password,
        confirmPassword,
        file,
      ];
}

class VerifyOtpEvent extends RegisterEvent {
  final BuildContext context;
  final String email;
  final String otp;

  const VerifyOtpEvent(
      {required this.context, required this.email, required this.otp});

  @override
  List<Object> get props => [email, otp];
}

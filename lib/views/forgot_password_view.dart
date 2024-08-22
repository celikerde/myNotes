import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_bloc.dart';
import 'package:mynotes/services/auth/bloc/auth_event.dart';
import 'package:mynotes/services/auth/bloc/auth_state.dart';
import 'package:mynotes/utilities/dialogs/error_dialog.dart';
import 'package:mynotes/utilities/dialogs/password_reset_send_email_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({super.key});

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await passwordResetSendEmailDialog(context);
          }
          if (state.exception.toString() == 'firebase_auth/invalid-email') {
            await showErrorDialog(
              context,
              'Invalid email',
            );
          }
          if (state.exception.toString() == 'firebase_auth/user-not-found') {
            await showErrorDialog(
              context,
              'You are not registered with this email',
            );
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Column(
          children: [
            const Text(
                'If you are forgot password, we will sent the link to reassign your password. Please enter your email below.'),
            TextField(
              controller: _controller,
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: 'Enter your email',
              ),
            ),
            TextButton(
              child: const Text('Send me link for reset password'),
              onPressed: () {
                final email = _controller.text;
                context.read<AuthBloc>().add(
                      AuthEventForgotPassword(email: email),
                    );
              },
            ),
            TextButton(
              child: const Text('Back to login page'),
              onPressed: () {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
            ),
          ],
        ),
      ),
    );
  }
}

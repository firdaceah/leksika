import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:leksika/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:leksika/features/auth/presentation/bloc/auth_event.dart';
import 'package:leksika/features/auth/presentation/bloc/auth_state.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    context.read<AuthBloc>().add(
          VerifyOtpRequested(otp: _otpController.text.trim()),
        );
  }

  void _resend() {
    context.read<AuthBloc>().add(const ResendOtpRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify OTP')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          if (state is OtpVerified) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP verified')),
            );
          }
          if (state is OtpResent) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('OTP resent')),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'OTP'),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'OTP is required';
                      }
                      if (value.trim().length != 6) {
                        return 'OTP must be 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : _submit,
                      child: Text(isLoading ? 'Loading...' : 'Verify'),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: isLoading ? null : _resend,
                    child: const Text('Resend OTP'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

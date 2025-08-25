import 'package:flutter/material.dart';
import 'package:hosta_app/generated/app_localizations.dart';
import 'package:hosta_app/widgets/app_logo.dart';

class VerificationCodeScreen extends StatefulWidget {
  final String destination;
  final bool isPhone;

  const VerificationCodeScreen({
    super.key,
    required this.destination,
    required this.isPhone,
  });

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final int codeLength = 5;
  final List<TextEditingController> _controllers = List.generate(
    5,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  void _checkAndNavigate() {
    final allFilled = _controllers.every((c) => c.text.length == 1);
    if (allFilled) {
      if (ModalRoute.of(context)?.isCurrent ?? true) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (!mounted) return;
          Navigator.pushReplacementNamed(context, '/reset-password');
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    if (widget.isPhone) {
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;

        const autoCode = "12345";
        for (int i = 0; i < codeLength; i++) {
          _controllers[i].text = autoCode[i];
        }
        _checkAndNavigate();
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  Widget _buildCodeFields() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(codeLength, (i) {
        return Container(
          width: 48,
          margin: const EdgeInsets.symmetric(horizontal: 6),
          child: TextField(
            controller: _controllers[i],
            focusNode: _focusNodes[i],
            enabled: !widget.isPhone,
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            maxLength: 1,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            decoration: const InputDecoration(
              counterText: "",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
            ),
            onChanged: (val) {
              if (val.isNotEmpty && i < codeLength - 1) {
                _focusNodes[i + 1].requestFocus();
              }
              if (val.isEmpty && i > 0) {
                _focusNodes[i - 1].requestFocus();
              }
              _checkAndNavigate();
            },
            onTap: () {
              if (!widget.isPhone) {
                _controllers[i].selection = TextSelection(
                  baseOffset: 0,
                  extentOffset: _controllers[i].text.length,
                );
              }
            },
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    String displayText = widget.isPhone
        ? "${AppLocalizations.of(context)?.verification_code_sent_phone ?? "We have sent you a 5 digit verification code on"}\n${widget.destination}"
        : "${AppLocalizations.of(context)?.verification_code_sent_email ?? "We have sent you a 5 digit verification code to"}\n${widget.destination}";
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Center(child: AppLogo(width: 120, height: 120)),
              const SizedBox(height: 24),
              Text(
                AppLocalizations.of(context)?.enter_verification_code ??
                    "Enter verification code",
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                displayText,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              _buildCodeFields(),
            ],
          ),
        ),
      ),
    );
  }
}

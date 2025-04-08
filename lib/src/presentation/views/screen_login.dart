import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../config/routes/app_routes.dart';

class ScreenLogin extends StatelessWidget {
  const ScreenLogin({super.key});

  @override
  Widget build(BuildContext context) {
    final phoneController = TextEditingController();
    final passwordController = TextEditingController();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 40),
              Center(
                child: Text(
                  'login'.tr(),
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                controller: phoneController,
                decoration: InputDecoration(
                  hintText: 'phone_number'.tr(),
                  prefixIcon: const Icon(Icons.person_outline),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'password'.tr(),
                  prefixIcon: const Icon(Icons.visibility_outlined),
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'forgot_password'.tr(),
                    style: const TextStyle(color: Color(0xFF51AACC)),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    RoutesConstants.screenMain,
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF51AACC),
                ),
                child: Text('login'.tr()),
              ),
              const SizedBox(height: 12),
              Center(
                child: Text.rich(
                  TextSpan(
                    text: 'no_account'.tr(),
                    children: [
                      TextSpan(
                        text: 'register'.tr(),
                        style: const TextStyle(color: Color(0xFF51AACC)),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Color(0xFF51AACC)),
                ),
                child: Text(
                  'guest_login'.tr(),
                  style: const TextStyle(color: Color(0xFF51AACC)),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
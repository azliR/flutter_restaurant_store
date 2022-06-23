import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_restaurant_store/l10n/l10n.dart';
import 'package:flutter_restaurant_store/views/core/misc/dialogs.dart';
import 'package:form_field_validator/form_field_validator.dart';

class LoginTabView extends StatefulWidget {
  const LoginTabView({
    Key? key,
    required this.onCompleted,
  }) : super(key: key);

  final VoidCallback? onCompleted;

  @override
  State<LoginTabView> createState() => _LoginTabViewState();
}

class _LoginTabViewState extends State<LoginTabView> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  bool _isAgree = false;
  bool _autovalidate = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: _formKey,
        autovalidateMode:
            _autovalidate ? AutovalidateMode.always : AutovalidateMode.disabled,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Spacer(),
            TextFormField(
              controller: _phoneNumberController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0-9\+]')),
              ],
              validator: RequiredValidator(errorText: context.l10n.emptyError),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: context.l10n.signInPhoneNumberHint,
                prefixIcon: Icon(
                  Icons.phone_rounded,
                  color: Theme.of(context).colorScheme.primary,
                  size: 22,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Checkbox(
                  value: _isAgree,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity.compact,
                  onChanged: (value) {
                    setState(() => _isAgree = value!);
                  },
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _isAgree = !_isAgree);
                    },
                    child: Text.rich(
                      TextSpan(
                        text: context.l10n.signInAgreement,
                        children: [
                          TextSpan(
                            text: context.l10n.signInTermAndService,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  setState(() => _autovalidate = true);

                  if (_formKey.currentState!.validate()) {
                    if (!_isAgree) {
                      showErrorSnackbar(
                          context, context.l10n.signInNeedAgreeError);
                    } else {
                      // context.router.push(OtpRoute(
                      //   phoneNumber: _phoneNumberController.text.trim(),
                      //   onCompleted: widget.onCompleted,
                      // ));
                    }
                  }
                },
                child: Text(context.l10n.signInContinueButton),
              ),
            ),
            const SizedBox(height: 22),
            Text(
              context.l10n.signInVerify,
              style: Theme.of(context).textTheme.caption,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

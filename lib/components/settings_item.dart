import 'package:flutter/material.dart';

class AppSettingsItem extends StatelessWidget {
  final String name;
  final IconData icon;
  const AppSettingsItem({
    super.key,
    required this.name,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(12, 12, 12, 12),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Icon(
              icon,
              size: 24,
            ),
            Padding(
              padding:
                  const EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
              child: Text(
                name,
              ),
            ),
            const Expanded(
              child: Align(
                alignment: AlignmentDirectional(0.9, 0),
                child: Icon(
                  Icons.arrow_forward_ios,               
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


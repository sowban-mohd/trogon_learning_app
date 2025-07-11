import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trogan_learning_app/core/color_palette.dart';
import 'package:trogan_learning_app/core/utils.dart';
import 'package:trogan_learning_app/models/subject.dart';
import 'package:trogan_learning_app/features/modules/presentation/screens/modules_page.dart';

class SubjectCard extends StatelessWidget {
  final Subject subject;

  const SubjectCard({super.key, required this.subject});

  @override
  Widget build(BuildContext context) {
    final deviceType = Utils.getDeviceType(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ModulesPage(subjectName: subject.title, subjectId: subject.id),
          ),
        );
       },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: Image.network(
                subject.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.image_not_supported)),
              ),
            ),

            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Center(
                  child: SingleChildScrollView(
                    child: Text(
                      subject.description,
                      style: GoogleFonts.hahmlet(
                        fontSize: deviceType == DeviceType.tablet
                            ? 10
                            : deviceType == DeviceType.desktop
                            ? 14
                            : 18,
                        color: ColorPalette.onSurface,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}

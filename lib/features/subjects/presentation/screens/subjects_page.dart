import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trogan_learning_app/core/color_palette.dart';
import 'package:trogan_learning_app/core/loader.dart';
import 'package:trogan_learning_app/core/utils.dart';
import 'package:trogan_learning_app/features/subjects/controller/subjects_cubit.dart';
import 'package:trogan_learning_app/models/subject.dart';
import 'package:trogan_learning_app/features/subjects/presentation/widgets/subject_card.dart';

class SubjectsPage extends StatefulWidget {
  const SubjectsPage({super.key});

  @override
  State<SubjectsPage> createState() => _SubjectsPageState();
}

class _SubjectsPageState extends State<SubjectsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SubjectsCubit>().fetchSubjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(65),
        child: AppBar(
          title: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              'Learning App',
              style: GoogleFonts.changa(fontSize: 30, fontWeight: FontWeight.w600),
            ),
          ),
           bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
        height: 1,
        thickness: 1,
        color: ColorPalette.dividerColor,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<SubjectsCubit, SubjectsState>(
          listener: (context, state) {
            if (state is SubjectsError) {
           Utils.showSnackBar(context, message: state.message);
            }
          },
          builder: (context, state) {
            if (state is SubjectsLoading) {
              return const Loader();
            } else if (state is SubjectsSuccess) {
              final List<Subject> subjects = state.subjects;
              final deviceType = Utils.getDeviceType(context);

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Text(
                      'Subjects',
                      style: GoogleFonts.nunito(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.onSurface,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: GridView.builder(
                        itemCount: subjects.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: deviceType == DeviceType.desktop
                              ? 4
                              : deviceType == DeviceType.tablet
                              ? 3
                              : 1,
                          childAspectRatio: 0.90,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final subject = subjects[index];
                          return SubjectCard(subject: subject);
                        },
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No data available.'));
            }
          },
        ),
      ),
    );
  }
}


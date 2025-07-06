import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trogan_learning_app/core/color_palette.dart';
import 'package:trogan_learning_app/core/loader.dart';
import 'package:trogan_learning_app/core/utils.dart';
import 'package:trogan_learning_app/features/modules/controller/modules_cubit.dart';
import 'package:trogan_learning_app/features/modules/presentation/widgets/module_card.dart';
import 'package:trogan_learning_app/models/module.dart';

class ModulesPage extends StatefulWidget {
  final String subjectName;
  final int subjectId;
  const ModulesPage({
    super.key,
    required this.subjectName,
    required this.subjectId,
  });

  @override
  State<ModulesPage> createState() => _ModulesPageState();
}

class _ModulesPageState extends State<ModulesPage> {
  @override
  void initState() {
    super.initState();
    context.read<ModulesCubit>().fetchModules(widget.subjectId);
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
              style: GoogleFonts.changa(
                fontSize: 30,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: ColorPalette.dividerColor
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<ModulesCubit, ModulesState>(
          listener: (context, state) {
            if (state is ModulesError) {
             Utils.showSnackBar(context, message: state.message);
            }
          },
          builder: (context, state) {
            if (state is ModulesLoading) {
              return const Loader();
            } else if (state is ModulesSuccess) {
              final List<Module> modules = state.modules;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    Column(
                      children: [
                         Text(
                          widget.subjectName,
                          style: GoogleFonts.nunito(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.onSurface,
                          ),
                        ),
                        Text(
                          'Modules',
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: ColorPalette.onSurface,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Expanded(
                      child: ListView.builder(
                        itemCount: modules.length,
                        itemBuilder: (context, index) {
                          return ModuleCard(module: modules[index]);
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

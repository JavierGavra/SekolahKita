import 'package:flutter/material.dart';
import '../../models/module_model.dart';
import '../../models/material_model.dart';
import '../../services/material_service.dart';

class MaterialContentPage extends StatefulWidget {
  final ModuleModel module;

  const MaterialContentPage({
    super.key,
    required this.module,
  });

  @override
  State<MaterialContentPage> createState() => _MaterialContentPageState();
}

class _MaterialContentPageState extends State<MaterialContentPage> {
  late MaterialModel material;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMaterial();
  }

  void _loadMaterial() {
    setState(() {
      isLoading = true;
    });

    // Simulasi loading - nanti bisa diganti dengan API call
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        material = MaterialService.getMaterialByModuleId(widget.module.id);
        isLoading = false;
      });
    });
  }

  void _onComplete() {
    // TODO: Implement logic untuk mark as completed
    // Misalnya: update database, update state management, dll
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Selamat! 🎉'),
        content: const Text('Kamu telah menyelesaikan materi ini!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pop(context, true);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: color.surface,
      appBar: AppBar(
        backgroundColor: color.primary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: color.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.module.title,
          style: TextStyle(
            color: color.onPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: color.primary,
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        Text(
                          material.title,
                          style: textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: color.onSurface,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Sections
                        ...material.sections.map((section) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: _buildSection(section, color, textTheme),
                          );
                        }),
                      ],
                    ),
                  ),
                ),

                // Complete Button
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: color.surface,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, -2),
                      ),
                    ],
                  ),
                  child: SafeArea(
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _onComplete,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color.primary,
                          foregroundColor: color.onPrimary,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Tandai Selesai',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildSection(
    MaterialSection section,
    ColorScheme color,
    TextTheme textTheme,
  ) {
    switch (section.type) {
      case 'text':
        return Text(
          section.content ?? '',
          style: textTheme.bodyLarge?.copyWith(
            height: 1.6,
            color: color.onSurface,
          ),
        );

      case 'image':
        return ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            section.imageUrl ?? '',
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                height: 200,
                decoration: BoxDecoration(
                  color: color.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(
                    Icons.image_not_supported,
                    size: 48,
                    color: color.outline,
                  ),
                ),
              );
            },
          ),
        );

      case 'list':
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: section.listItems?.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 6, right: 12),
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: color.primaryContainer,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: color.primary,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      item,
                      style: textTheme.bodyLarge?.copyWith(
                        height: 1.6,
                        color: color.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList() ?? [],
        );

      case 'highlight':
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.primaryContainer.withOpacity(0.3),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: color.primary.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    color: color.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    section.highlightTitle ?? 'Perhatian',
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: color.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                section.highlightContent ?? '',
                style: textTheme.bodyMedium?.copyWith(
                  height: 1.6,
                  color: color.onSurface,
                ),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}

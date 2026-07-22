import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:bloomtrack/data/database.dart';

class PdfExportService {
  static Future<File> generateCycleHistoryPdf(
      List<Cycle> cycles, ProfileData? profile) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text('BloomTrack - Cycle History'),
            ),
            if (profile != null) ...[
              pw.Text('Cycle Goal: ${profile.cycleGoal}'),
              pw.SizedBox(height: 10),
            ],
            pw.TableHelper.fromTextArray(
              context: context,
              headers: [
                'Start Date',
                'End Date',
                'Cycle Length',
                'Period Length',
                'Notes'
              ],
              data: cycles.map((cycle) {
                return [
                  cycle.startDate.toIso8601String().split('T')[0],
                  cycle.endDate?.toIso8601String().split('T')[0] ?? 'Present',
                  cycle.cycleLength?.toString() ?? '-',
                  cycle.periodLength?.toString() ?? '-',
                  cycle.notes ?? '-',
                ];
              }).toList(),
            ),
          ];
        },
      ),
    );

    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/bloomtrack_cycle_history.pdf');
    await file.writeAsBytes(await pdf.save());
    return file;
  }
}

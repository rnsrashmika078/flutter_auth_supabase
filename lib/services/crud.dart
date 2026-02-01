import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:superbase_auth/main.dart';

final user = supabase.auth.currentUser;

Future<void> insertData() async {
  await supabase.from(dotenv.env['SUPABASE_TABLE']!).upsert({
    'userId': user?.id,
    'email': user?.email,
    'username': user?.userMetadata?['full_name'] ?? user?.userMetadata?['name'],
    'dp': user?.userMetadata?['avatar_url'],
  });
}

Future<Map<String, dynamic>?> getUserData(String userId) async {
  return await supabase
      .from(dotenv.env['SUPABASE_TABLE']!)
      .select('userId,username, dp,email')
      .eq('userId', userId)
      .maybeSingle();
}

Future<List<Map<String, dynamic>>> getAllUsers() async {
  return await supabase.from(dotenv.env['SUPABASE_TABLE']!).select();
}

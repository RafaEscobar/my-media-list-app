import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:provider/provider.dart';

class Entertainment {
  static void saveField({required dynamic value, required String fieldName, bool isNext = true, dynamic defaultValue = ''}){
    EntertainmentEntityProvider entityProvider = navigatorKey.currentState!.context.read<EntertainmentEntityProvider>();
    if (entityProvider.type == TypeEnum.media.name) {
      entityProvider.mediaData[fieldName] = isNext ? value : defaultValue;
    } else if (entityProvider.type == TypeEnum.saga.name){
      entityProvider.sagaData[fieldName] = isNext ? value : defaultValue;
    }
  }
}
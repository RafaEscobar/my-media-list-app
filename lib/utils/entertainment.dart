import 'package:mymedialist/enum/type_enum.dart';
import 'package:mymedialist/main.dart';
import 'package:mymedialist/provider/entertainment_entity_provider.dart';
import 'package:provider/provider.dart';

class Entertainment {
  static void saveField({required dynamic value, required String fieldName}){
    EntertainmentEntityProvider entityProvider = navigatorKey.currentState!.context.read<EntertainmentEntityProvider>();
    if (entityProvider.type == TypeEnum.media.name) {
      entityProvider.mediaData[fieldName] = value;
    } else if (entityProvider.type == TypeEnum.saga.name){
      entityProvider.sagaData[fieldName] = value;
    }
  }
}
import 'package:emel/models/morador.dart';

class MockUsuario {
  Map<String, Morador> moradores = {
    "user": Morador("user",  "1234"),
    "Yuri Alberto": Morador("Yuri Alberto", "1910"),
    "Gabriel": Morador("Gabriel", "Corinthians")
  };
}
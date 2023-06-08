import 'package:form_field_validator/form_field_validator.dart';

class Validator {
  static MultiValidator nameValidator = MultiValidator([
    RequiredValidator(errorText: "* Campo obrigatório"),
  ]);

  static MultiValidator emailValidator = MultiValidator([
    RequiredValidator(errorText: "* Campo obrigatório"),
    EmailValidator(errorText: "Digite um email válido"),
  ]);

  static MultiValidator passwordValidator = MultiValidator([
    MinLengthValidator(6,
        errorText: "A senha deve ter pelo menos 6 caracteres"),
    RequiredValidator(errorText: "* Campo obrigatório"),
    MaxLengthValidator(15,
        errorText: "A senha não pode ter mais de 15 caracteres")
  ]);

  static MultiValidator titleValidator = MultiValidator([
    RequiredValidator(errorText: "Por favor, insira algum texto"),
  ]);
}

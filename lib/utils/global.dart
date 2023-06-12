import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//  cor

const backgroundColor = Colors.black;
const basicColor = Color.fromARGB(255, 255, 255, 255);
const greyColor = Color.fromARGB(255, 103, 103, 103);
const secondaryColor = Color(0xFF707070);
const tertiaryColor = Color.fromARGB(255, 60, 59, 59);
const redColor = Color.fromARGB(255, 211, 1, 1);
const whiteColor = Color.fromARGB(255, 255, 255, 255);
const boxColor = Color.fromARGB(255, 37, 37, 37);
const colorTextPrimary = Color.fromARGB(255, 255, 255, 255);
const colorNumberPrimary = Color.fromARGB(255, 255, 255, 255);
const colorBoxPrimary = Color.fromARGB(255, 80, 76, 76);

// Texto

const login = "Entrar";
const signUp = "Criar Conta";
const sair = "Sair";
const haveAccount = "Ja possue uma conta? ";
const somethingWrong = "Algo saiu errado!";
const forgotPasswordTtitle = "Resetar Senha";
const forgotPassword = "Esqueceu a senha?";
const forgotPassword2 = "Receber um email para resetar a senha?";
const forgotPassword3 = 'Enviar';
const editList = 'Editar Lista';
const today = 'Hoje';
const noToday = 'Sem tarefas hoje';
const concludeds = 'Concluidas';
const concluded = "Concluida";
const noConcluded = 'Sem tarefas concluidas';
const all = 'Todas';
const noAll = 'Sem tarefas cadastradas';
const scheduled = 'Agendadas';
const noScheduled = 'Sem tarefas agendadas';
const list = 'Listas';
const nolist = 'Adicione novas listas';
const notask = 'Adicionar novas tarefas';
const cancel = "Voltar";
const title = "Titulo";
const create = 'Criar';
const update = 'Atualizar';
const configuracoes = 'Configurações';
const time = 'Hora';
const description = 'Descrição';
const add = 'Adicionar';
const newTask = 'Nova tarefa';
const updateTask = 'Editar Tarefa';

//SizedBox

SizedBox espaco(double size) {
  return SizedBox(
    height: size,
  );
}

// TextoStyles

TextStyle barTextStyle = GoogleFonts.notoSans(
  fontSize: 30,
  color: basicColor,
  fontWeight: FontWeight.bold,
);

TextStyle infoTextStyle = const TextStyle(color: Colors.white, fontSize: 23.0);

TextStyle heading(color) =>
    TextStyle(color: color, fontSize: 50.0, fontWeight: FontWeight.bold);

TextStyle formInputText = const TextStyle(color: Colors.white, fontSize: 20);

TextStyle hintTextStyle = const TextStyle(
  color: Color.fromARGB(255, 173, 173, 173),
  fontSize: 20,
);

TextStyle counterTextStyle = const TextStyle(
  color: Color.fromARGB(255, 173, 173, 173),
  fontSize: 15,
);

TextStyle paragraphGray =
    const TextStyle(color: secondaryColor, fontSize: 20.0);

TextStyle paragraphPrimary =
    const TextStyle(color: Colors.white, fontSize: 20.0);

TextStyle paragraphWhiteBig =
    const TextStyle(color: Colors.white, fontSize: 20.0);

TextStyle buttonTextWhite =
    const TextStyle(color: Colors.white, fontSize: 23.0);

TextStyle menuTextStyle =
    const TextStyle(fontSize: 20, color: Color(0xFFEAEAEA));

TextStyle taskScreenStyle = const TextStyle(fontSize: 24.0, color: basicColor);

TextStyle filteredTextStyle = GoogleFonts.notoSans(
  color: basicColor,
  fontSize: 23.0,
);

TextStyle filteredDateStyle = GoogleFonts.notoSans(
  color: basicColor,
  fontSize: 20.0,
);

TextStyle actionButtonTextStyle =
    const TextStyle(fontSize: 20.0, color: basicColor);

// Decorat

InputDecoration emailInputDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(20.0),
    isDense: true,
    focusColor: Colors.transparent,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(9),
      ),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    filled: true,
    fillColor: const Color.fromARGB(255, 48, 48, 48),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(9),
      ),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    hintText: 'Email',
    hintStyle: hintTextStyle);

InputDecoration nameDecoration = InputDecoration(
    contentPadding: const EdgeInsets.all(20.0),
    isDense: true,
    focusColor: Colors.transparent,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(9),
      ),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    filled: true,
    fillColor: const Color.fromARGB(255, 48, 48, 48),
    border: const OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(9),
      ),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    ),
    hintText: 'Nome',
    hintStyle: hintTextStyle);

InputDecoration passwordDecoracao(passwordVisible, VoidCallback onPressed) =>
    InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.all(20.0),
        focusColor: Colors.transparent,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        filled: true,
        fillColor: const Color.fromARGB(255, 48, 48, 48),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(9),
          ),
          borderSide: BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintText: 'Senha',
        suffixIcon: IconButton(
            splashColor: Colors.transparent,
            icon:
                Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: onPressed),
        hintStyle: hintTextStyle);

TextStyle optionsTextStyle = GoogleFonts.notoSans(
  fontSize: 17.0,
  color: const Color(0xFFEAEAEA),
);

TextStyle todoTitleStyle(condition) => GoogleFonts.notoSans(
      color: basicColor,
      fontSize: 23.0,
      decoration:
          (condition) ? TextDecoration.lineThrough : TextDecoration.none,
      decorationColor: basicColor,
      decorationThickness: 2,
    );

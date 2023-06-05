# Aplicativo de Gerenciamento de Tarefas

Este é um aplicativo de gerenciamento de tarefas desenvolvido com o framework Flutter e utiliza o Firebase como backend para autenticação de usuários e armazenamento de dados. O aplicativo permite que os usuários criem uma conta, façam login, adicionem tarefas, definam datas de vencimento e marquem as tarefas como concluídas.

## Recursos

O aplicativo inclui os seguintes recursos:

- Autenticação de usuários: Os usuários podem criar uma conta e fazer login para acessar suas tarefas pessoais.
- Adição de tarefas: Os usuários podem adicionar novas tarefas especificando um título, descrição e data de vencimento.
- Marcar tarefas como concluídas: Os usuários podem marcar suas tarefas como concluídas para acompanhamento de progresso.
- Notificações push: O aplicativo pode enviar notificações push para lembrar os usuários sobre tarefas pendentes.
- Integração com API REST: O aplicativo pode se comunicar com uma API REST para sincronizar dados entre dispositivos ou permitir integração com outros aplicativos.

## Tecnologias Utilizadas

- Flutter: Framework de desenvolvimento de aplicativos multiplataforma baseado em Dart.
- Firebase: Plataforma de desenvolvimento de aplicativos móveis do Google que fornece uma variedade de serviços, incluindo autenticação de usuários e armazenamento de dados em tempo real.

## Configuração

Para configurar o projeto localmente, siga as etapas abaixo:

1. Certifique-se de ter o Flutter instalado em seu ambiente de desenvolvimento. Para obter mais informações sobre a instalação do Flutter, consulte a documentação oficial do Flutter: [https://flutter.dev/docs/get-started/install](https://flutter.dev/docs/get-started/install)

2. Clone este repositório para o seu ambiente local:

   ```
   git clone https://github.com/seu-usuario/nome-do-repositorio.git
   ```

3. Abra o diretório do projeto no seu editor de código preferido.

4. Configure o Firebase para o seu projeto:

   - Crie um projeto no [Firebase Console](https://console.firebase.google.com).
   - Siga as instruções do Firebase para adicionar o Flutter ao seu projeto.
   - Copie o arquivo `google-services.json` gerado pelo Firebase para a pasta `/android/app` do projeto.

5. Execute o comando abaixo para baixar as dependências do Flutter:

   ```
   flutter pub get
   ```

6. Inicie o aplicativo emulando um dispositivo ou conectando um dispositivo físico:

   ```
   flutter run
   ```

7. O aplicativo agora deve estar em execução e pronto para uso.

## Contribuição

Contribuições são bem-vindas! Se você tiver alguma melhoria ou correção para sugerir, fique à vontade para abrir uma issue ou enviar um pull request.

## Licença

Este projeto está licenciado sob a [Licença MIT](LICENSE). Sinta-se à vontade para usar, modificar e distribuir este código conforme necessário.

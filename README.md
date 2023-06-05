# Aplicativo de Gerenciamento de Tarefas

Este repositório contém um aplicativo de gerenciamento de tarefas, no qual os usuários podem criar uma conta, fazer login, adicionar tarefas, definir datas de vencimento e marcar as tarefas como concluídas. O aplicativo foi desenvolvido utilizando o Firebase como plataforma de backend e API REST para sincronização de dados entre dispositivos.

## Funcionalidades

O aplicativo possui as seguintes funcionalidades principais:

1. Registro e login de usuários: Os usuários podem criar uma conta e fazer login utilizando suas credenciais. O Firebase Authentication é utilizado para a autenticação do usuário.

2. Adicionar tarefas: Os usuários podem adicionar novas tarefas, fornecendo um título, uma descrição e uma data de vencimento. As tarefas são armazenadas no banco de dados do Firebase Firestore.

3. Marcar tarefas como concluídas: Os usuários podem marcar as tarefas como concluídas, atualizando o status no banco de dados.

4. Notificações push: O aplicativo pode enviar notificações push para lembrar os usuários sobre tarefas pendentes. O Firebase Cloud Messaging (FCM) é utilizado para enviar essas notificações.

5. Sincronização de dados entre dispositivos: O aplicativo se integra com uma API REST para sincronizar os dados das tarefas entre diferentes dispositivos. Isso permite que os usuários acessem suas tarefas em diferentes plataformas.

## Configuração do Projeto

Siga as etapas abaixo para configurar o projeto em seu ambiente de desenvolvimento:

1. Clone este repositório para o seu ambiente local.

2. Certifique-se de ter o Node.js e o npm instalados em seu sistema.

3. Navegue até o diretório raiz do projeto e execute o seguinte comando para instalar as dependências necessárias:

   ```
   npm install
   ```

4. Configure o Firebase para o projeto:

   - Crie um projeto no [Firebase Console](https://console.firebase.google.com).
   - Copie as configurações do projeto, incluindo as chaves da API, fornecidas pelo Firebase e cole-as no arquivo `firebase-config.js`, localizado em `src/config/firebase-config.js`.

5. Configure a API REST:

   - Consulte a documentação da API REST que será integrada para obter as informações necessárias para a configuração.
   - Copie a URL da API e cole-a no arquivo `api-config.js`, localizado em `src/config/api-config.js`.

6. Execute o seguinte comando para iniciar o servidor de desenvolvimento:

   ```
   npm start
   ```

7. O aplicativo estará acessível no seu navegador em `http://localhost:3000`.

## Contribuição

Se você quiser contribuir para este projeto, sinta-se à vontade para fazer um fork e enviar um pull request. Também agradecemos qualquer problema relatado ou sugestões de melhorias.

## Licença

Este projeto está licenciado sob a [MIT License](LICENSE).

---

Espero que esta descrição do README seja útil para você! Se tiver mais alguma dúvida, não hesite em perguntar.

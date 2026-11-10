# Guia de desenvolvimento — Minha Lista (Flutter + Supabase)

> **Disciplina:** Desenvolvimento de Dispositivos Móveis  
> **Material-base:** Aula 10 — Flutter + Supabase (33 slides)  
> **Atividade:** desenvolver o aplicativo **Minha Lista**, conforme a prática guiada do **slide 30**.  
> **Escopo:** este guia segue os requisitos e procedimentos apresentados nos slides. As recomendações de empacotamento da entrega são identificadas separadamente, pois o material **não especifica o formato do envio**.

## 1. Objetivo

Desenvolver um aplicativo Flutter de lista de itens que utilize o Supabase para:

- criar contas, autenticar usuários e encerrar sessões;
- listar, adicionar, editar e excluir itens (CRUD);
- manter os itens armazenados na nuvem mesmo após fechar o aplicativo;
- permitir que cada usuário consulte e altere **somente os próprios itens**.

**Referência:** slides 2, 7 e 30.

## 2. Checklist geral

Marque os itens conforme avançar.

### Backend (Supabase)

- [ ] Criar um projeto no Supabase.
- [ ] Obter a **Project URL** e a **publishable key**.
- [ ] Criar a tabela `public.items` com as colunas definidas no material.
- [ ] Habilitar **Row Level Security (RLS)** na tabela.
- [ ] Configurar permissões `GRANT` / `REVOKE`.
- [ ] Criar políticas RLS para `SELECT`, `INSERT`, `UPDATE` e `DELETE`.
- [ ] Verificar a configuração de autenticação por e-mail.
- [ ] Confirmar que a tabela pode ser acessada pela Data API, quando necessário.

### Flutter

- [ ] Instalar o pacote `supabase_flutter`.
- [ ] Configurar a URL e a publishable key do projeto.
- [ ] Inicializar o Supabase **antes** de `runApp`.
- [ ] Criar interface para cadastro de usuário.
- [ ] Criar interface para login.
- [ ] Implementar logout.
- [ ] Identificar a conta autenticada (`currentUser`).
- [ ] Listar os itens do usuário conectado.
- [ ] Adicionar novos itens.
- [ ] Editar o nome de itens existentes.
- [ ] Excluir itens.
- [ ] Exibir carregamento e mensagens de erro nas operações remotas.
- [ ] Atualizar a interface quando as operações forem concluídas.

### Testes finais

- [ ] Confirmar que o usuário consegue se cadastrar, entrar e sair.
- [ ] Confirmar que as quatro operações CRUD funcionam.
- [ ] Fechar e reabrir o app e verificar se os itens continuam salvos.
- [ ] Criar duas contas diferentes e verificar o isolamento dos itens.
- [ ] Verificar que a segurança permanece no banco, com RLS habilitado.

**Referências:** slides 7, 24–31.

---

## 3. Criar o projeto no Supabase

**Referências:** slides 9–11.

1. Acesse <https://supabase.com> e entre no dashboard.
2. Selecione a organização e clique em **New project**.
3. Informe o nome do projeto, escolha a região e crie uma senha forte para o banco.
4. Crie o projeto.
5. Localize a **Project URL** e a **publishable key** em **Connect** ou **Project Settings → API Keys**.

### Qual chave utilizar?

| Chave | Uso |
|---|---|
| `sb_publishable_...` | Pode ser usada pelo aplicativo Flutter. |
| `sb_secret_...` | Exclusiva de backend controlado; **nunca deve ser colocada no app**. |

A chave publicável **não substitui** autenticação, permissões e RLS. A senha do banco também **não** é a chave usada pelo aplicativo.

---

## 4. Banco de dados: tabela `items`

**Referências:** slides 8 e 12.

A tabela tem quatro campos:

| Coluna | Tipo | Regra |
|---|---|---|
| `id` | `uuid` | Chave primária gerada automaticamente. |
| `name` | `text` | Nome obrigatório e não vazio. |
| `user_id` | `uuid` | Referência a `auth.users(id)`. |
| `created_at` | `timestamptz` | Data/hora de criação, preenchida automaticamente. |

No dashboard, abra **SQL Editor → New query**, cole o SQL e execute em **Run**.

### 4.1. Criar a tabela

```sql
create table public.items (
  id uuid primary key default gen_random_uuid(),
  name text not null
    check (length(trim(name)) > 0),
  user_id uuid not null
    references auth.users(id) on delete cascade,
  created_at timestamptz not null default now()
);
```

### 4.2. Ativar RLS e configurar privilégios

**Referência:** slide 13.

```sql
alter table public.items
  enable row level security;

revoke all on table public.items
  from anon, authenticated;

grant usage on schema public
  to authenticated;

grant select, insert, update, delete
  on table public.items
  to authenticated;
```

> **GRANT/REVOKE** determinam que operações o papel pode executar na tabela. **RLS** determina quais linhas podem ser acessadas.

### 4.3. Criar as quatro políticas RLS

**Referências:** slides 14 e 15.

```sql
-- Apenas consultar os próprios registros
create policy "items_select_own"
on public.items
for select to authenticated
using ((select auth.uid()) = user_id);

-- Apenas inserir registros vinculados à própria conta
create policy "items_insert_own"
on public.items
for insert to authenticated
with check ((select auth.uid()) = user_id);

-- Apenas alterar registros próprios, sem transferi-los a outra conta
create policy "items_update_own"
on public.items
for update to authenticated
using ((select auth.uid()) = user_id)
with check ((select auth.uid()) = user_id);

-- Apenas excluir registros próprios
create policy "items_delete_own"
on public.items
for delete to authenticated
using ((select auth.uid()) = user_id);
```

**Importante:** esses comandos de criação pressupõem que a tabela e as políticas ainda não existem. Evite executar novamente uma criação que já foi concluída. Para a operação `UPDATE` funcionar como esperado, também é necessária a política `SELECT`.

### 4.4. Conferir a Data API

**Referência:** slide 17.

O SDK Flutter consulta os dados pela **Data API**. Se a tabela não responder, verifique:

- **Integrations → Data API**;
- schemas expostos;
- privilégios do papel;
- políticas RLS.

O material recomenda expor apenas tabelas e funções necessárias ao aplicativo.

---

## 5. Preparar o projeto Flutter

### 5.1. Instalar o pacote

**Referência:** slide 18.

No terminal, dentro da raiz do projeto Flutter:

```powershell
flutter pub add supabase_flutter
```

O slide 18 indica a versão **2.18.3** como a estável consultada em **03/11/2026** e informa requisito de **Dart SDK >= 3.9**. A instrução da aula é deixar o Flutter resolver a versão estável compatível, sem instalar o pacote `supabase` separadamente.

#### Problema já encontrado: conflito de nome do projeto

Se o terminal mostrar:

```text
Because supabase_flutter depends on supabase_flutter, version solving failed.
```

verifique o nome do pacote no arquivo `pubspec.yaml`. **Não deixe seu próprio projeto com o nome `supabase_flutter`**, pois esse é o nome da dependência que você está tentando instalar.

Exemplo:

```yaml
name: minha_lista
```

Depois execute:

```powershell
flutter pub get
flutter pub add supabase_flutter
```

> Esta observação é uma solução para o erro encontrado durante o desenvolvimento; **não é um requisito dos slides**.

### 5.2. Configurar URL e chave publicável

**Referência:** slide 19.

Na raiz do projeto Flutter, crie `supabase_config.json`:

```json
{
  "SUPABASE_URL": "https://seu-projeto.supabase.co",
  "SUPABASE_PUBLISHABLE_KEY": "sb_publishable_..."
}
```

Substitua os exemplos pelos dados obtidos no seu projeto Supabase. O slide orienta **evitar versionar** arquivos de configuração específicos do projeto. Não coloque nenhuma `secret key` no app.

### 5.3. Inicializar o cliente

**Referência:** slide 20.

Exemplo de inicialização apresentado no material:

```dart
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment('SUPABASE_URL'),
    publishableKey: const String.fromEnvironment(
      'SUPABASE_PUBLISHABLE_KEY',
    ),
  );

  runApp(const MyApp());
}

final supabase = Supabase.instance.client;
```

> O trecho demonstra a integração. A classe `MyApp` deverá estar definida/importada no projeto.

Execute o app passando o arquivo de configuração:

```powershell
flutter run --dart-define-from-file=supabase_config.json
```

Use `Supabase.instance.client` nas telas e serviços. **Não inicialize um cliente por tela.**

---

## 6. Configurar e implementar autenticação

**Referências:** slides 21–23.

### 6.1. Configurar autenticação por e-mail no dashboard

Acesse **Authentication → Sign In / Providers → Email**.

- **Allow new users to sign up:** permite novas contas.
- **Confirm Email:** se habilitado, a pessoa precisa confirmar o e-mail antes de receber uma sessão.

O material recomenda **manter confirmação habilitada em produção** e configurar SMTP próprio. Em exercícios locais, é importante compreender o impacto de desabilitá-la.

### 6.2. Cadastro, login e logout no Flutter

```dart
// Criar conta
await supabase.auth.signUp(
  email: email,
  password: password,
);

// Entrar
await supabase.auth.signInWithPassword(
  email: email,
  password: password,
);

// Sair
await supabase.auth.signOut();
```

As credenciais devem ser tratadas pelo **Supabase Auth**, e não por uma tabela própria de senhas.

### 6.3. Identificar a conta conectada

```dart
final user = supabase.auth.currentUser;

if (user == null) {
  // Não existe conta conectada.
} else {
  final userId = user.id;
  final email = user.email;
}
```

O campo `user.id` fornece o UUID que será gravado em `items.user_id`. A sessão pode ser restaurada pelo SDK, mas todas as operações continuam sujeitas às permissões e ao RLS.

### 6.4. Interface necessária

A interface precisa permitir:

- informar e-mail e senha;
- criar uma conta;
- entrar em uma conta existente;
- sair da sessão;
- chegar à tela de itens após autenticar.

O material não exige que o visual das telas reproduza exatamente a ilustração do slide 7.

**Validação antes de avançar:** confirme cadastro, login, logout e identificação da sessão. O slide 30 orienta a **não avançar ao CRUD** antes de validar conexão e autenticação.

---

## 7. Implementar CRUD dos itens

**Referências:** slides 24 e 25.

Todos os exemplos a seguir usam o cliente `supabase` inicializado anteriormente e a tabela `public.items`.

### 7.1. Listar itens (`SELECT`)

```dart
final items = await supabase
    .from('items')
    .select('id, name, user_id, created_at')
    .order('created_at', ascending: false);
```

O RLS filtra automaticamente as linhas permitidas. Com as políticas corretas, não é necessário adicionar um filtro manual por `user_id` na consulta.

### 7.2. Adicionar item (`INSERT`)

```dart
final user = supabase.auth.currentUser!;

await supabase.from('items').insert({
  'name': name,
  'user_id': user.id,
});
```

O campo `name` não aceita texto vazio. Esse exemplo pressupõe usuário autenticado.

### 7.3. Renomear item (`UPDATE`)

```dart
await supabase
    .from('items')
    .update({'name': newName})
    .eq('id', itemId);
```

### 7.4. Excluir item (`DELETE`)

```dart
await supabase
    .from('items')
    .delete()
    .eq('id', itemId);
```

**Atenção:** `UPDATE` e `DELETE` devem direcionar a operação com filtro pelo ID do registro escolhido. O RLS permanece aplicado mesmo com o ID correto.

### 7.5. Interface da lista

A tela deve permitir:

- visualizar todos os itens da conta atual;
- digitar e adicionar um novo item;
- editar o nome de um item existente;
- excluir o item escolhido;
- sair da conta.

O slide 7 apresenta exemplos de itens como **Comprar caderno**, **Estudar Flutter** e **Enviar atividade**. São exemplos de conteúdo, não registros que precisam estar pré-cadastrados.

---

## 8. Organização sugerida dos arquivos

**Referência:** slide 26.

```text
lib/
├── main.dart
├── app.dart
├── pages/
│   ├── login_page.dart
│   └── items_page.dart
├── services/
│   └── item_service.dart
└── models/
    └── item.dart
```

| Arquivo ou pasta | Responsabilidade sugerida |
|---|---|
| `main.dart` | Inicialização do Flutter e Supabase. |
| `app.dart` | Configuração geral do aplicativo. |
| `pages/` | Telas, formulários e interação visual. |
| `services/` | Acesso ao banco e operações CRUD. |
| `models/` | Representação Dart dos dados da tabela. |

**Não é uma estrutura obrigatória:** o material diz que você pode começar simples e extrair serviços quando a lógica de acesso crescer.

---

## 9. Carregamento, erros e segurança

### 9.1. Tratar operações assíncronas

**Referência:** slide 27.

- **Durante a requisição:** exibir um indicador de carregamento.
- **Em caso de sucesso:** atualizar a lista e mostrar os dados.
- **Em caso de erro:** capturar a exceção e mostrar uma mensagem útil.

Padrão apresentado pelo professor:

```dart
try {
  await carregarItens();
} catch (error) {
  // Mostrar SnackBar ou estado de erro.
}
```

Após `await`, verifique `mounted` antes de chamar `setState` ou utilizar `context`.

### 9.2. Diagnóstico de problemas comuns

**Referência:** slide 28.

| Problema | O que verificar |
|---|---|
| `401 / Invalid API key` | URL e publishable key, em Connect. |
| `403 / 42501` | `GRANT`, schema usage, Data API e RLS. |
| Lista vazia inesperadamente | Sessão e valor de `user_id`; políticas RLS. |
| Tabela não encontrada | Nome/schema e exposição da tabela na Data API. |
| Cadastro sem sessão | Se `Confirm Email` está ativo e o e-mail foi confirmado. |

**Não desative RLS para “resolver” erros de permissão.** Corrija a política ou o privilégio.

### 9.3. Checklist de segurança

**Referência:** slide 29.

- [ ] RLS habilitado na tabela exposta.
- [ ] Políticas separadas para `SELECT`, `INSERT`, `UPDATE`, `DELETE`.
- [ ] `user_id` validado por `auth.uid()`.
- [ ] Privilégios mínimos concedidos ao papel necessário.
- [ ] Somente a publishable key utilizada no app.
- [ ] Senhas tratadas pelo Supabase Auth, nunca por tabela própria.

---

## 10. Testar o aplicativo

### 10.1. Teste obrigatório na prática: duas contas

**Referência:** slide 31.

1. Criar a **Conta A**.
2. Entrar com a Conta A.
3. Criar o item **Meu registro A**.
4. Sair da Conta A.
5. Criar e/ou entrar com a **Conta B**.
6. Confirmar que a lista da Conta B **não contém “Meu registro A”**.

**Resultado esperado:** a Conta B não pode visualizar, editar ou excluir registros da Conta A. Se isso acontecer, revise imediatamente as políticas RLS.

### 10.2. Outros testes coerentes com os requisitos dos slides

- [ ] Criar um item e conferir que ele aparece na lista.
- [ ] Editar o nome e confirmar que a alteração foi salva.
- [ ] Excluir um item e confirmar que desapareceu.
- [ ] Fechar e reabrir o app e conferir que os dados persistiram.
- [ ] Sair e entrar novamente na mesma conta e conferir os itens.
- [ ] Confirmar que o app informa carregamento e falhas sem travar.

---

## 11. Entrega: o que os slides especificam?

Os slides descrevem **o aplicativo e a sequência de desenvolvimento**, mas **não determinam**:

- formato de envio (`.zip`, `.apk` ou repositório GitHub);
- relatório em PDF ou DOCX;
- quantidade de capturas de tela;
- prazo de entrega;
- rubrica de avaliação ou pontuação.

### Sugestão de organização para o envio (não exigida pelo PDF)

Se não houver novas instruções do professor, uma opção prática é reunir:

1. **Projeto Flutter** completo, para possibilitar execução e avaliação.
2. **Script SQL** da tabela, permissões e políticas RLS (por exemplo, `database/setup.sql`).
3. **README** com instruções de configurar URL e publishable key e executar o app.
4. Se necessário, **evidências dos testes** (prints), especialmente o teste com as duas contas.

Não inclua uma **secret key**. Evite compartilhar o arquivo de configuração real do seu projeto. Em vez disso, você pode fornecer um arquivo de exemplo com valores fictícios.

---

## 12. Referências indicadas no slide 33

Estas são as referências que o próprio material da aula apresenta:

- [Supabase — Flutter Quickstart](https://supabase.com/docs/guides/getting-started/quickstarts/flutter) — criação do projeto e inicialização do Flutter.
- [Supabase — API Keys](https://supabase.com/docs/guides/getting-started/api-keys) — diferença entre chaves publicáveis e secretas.
- [Supabase — Migrating API Keys](https://supabase.com/docs/guides/getting-started/migrating-to-new-api-keys) — migração das chaves antigas.
- [Supabase — Row Level Security](https://supabase.com/docs/guides/database/postgres/row-level-security) — privilégios, políticas e `auth.uid()`.
- [Supabase — Flutter User Management](https://supabase.com/docs/guides/getting-started/tutorials/with-flutter) — exemplo de gerenciamento de usuários.
- [pub.dev — supabase_flutter](https://pub.dev/packages/supabase_flutter) — documentação do pacote.

**Fonte primária:** *Aula 10 — Flutter + Supabase — Banco de dados, autenticação e persistência na nuvem*, Diego Possamai, material revisado em 03/11/2026.

---

## 13. Critério prático para considerar o projeto concluído

O aplicativo **Minha Lista** está pronto quando é possível:

1. cadastrar duas contas por e-mail;
2. fazer login e logout;
3. criar, listar, editar e excluir itens;
4. fechar e reabrir o app sem perder os itens salvos;
5. comprovar que cada conta acessa apenas seus próprios registros;
6. manter as políticas RLS ativas e a autenticação gerenciada pelo Supabase Auth.

> **Resumo:** o Flutter solicita; o Supabase autentica e encaminha; o PostgreSQL, por meio das permissões e do RLS, autoriza ou bloqueia. (Ideia central do slide 32.)

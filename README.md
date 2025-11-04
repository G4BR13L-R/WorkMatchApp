# WorkMatch — Aplicativo Mobile

## Descrição do Projeto

O **WorkMatch** é um aplicativo desenvolvido para conectar pessoas que buscam serviços temporários
com contratantes que necessitam de mão de obra rápida e informal.

## Requisitos

- **Flutter** (>= 8.2)
- Integração com API **Laravel** + **PostgreSQL**

## Instalação e Execução

### Passo 1: Clonar o repositório

```bash
git clone https://github.com/G4BR13L-R/WorkMatchApp.git
cd WorkMatchApp
```

### Passo 2: Instalar dependências

```bash
flutter pub get
```

### Passo 3: Configurar a URL da API

Renomeie o arquivo responsável pela configuração `.env.example` para `.env` e configure a URL da
API:

```bash
API_URL=https://seu-servidor:8000/api
```

### Passo 4: Executar o aplicativo

```bash
flutter run
```

## Build para Produção

### Android — APK Release

```bash
flutter build apk --release
```

📍 APK gerado em:

```
build/app/outputs/flutter-apk/app-release.apk
```

### Android — AAB (obrigatório para Play Store)

```bash
flutter build appbundle --release
```

📍 AAB gerado em:

```
build/app/outputs/bundle/release/app-release.aab
```

## Desenvolvedor

- **Gabriel Silva de Rezende**
- CGM: 802.239

## Licença

Este projeto é desenvolvido para fins acadêmicos no **Centro Universitário da Grande Dourados**.
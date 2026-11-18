# Кодын гарын авлага (Dulguun, Purevtulga)

Энэ багц нь `flutter create` хийсний дараа **шууд ажиллах** анхны төсөл (skeleton).
Ингэснээр хоёулаа ажилладаг код дээрээс эхлээд, хэсэг хэсгээрээ сайжруулна.

## 1. Анхны commit (Dulguun, нэг удаа)

```
git clone https://github.com/Unknown-coder-a11y/mobile-tech-memory-game-.git
cd mobile-tech-memory-game-
flutter create --project-name memory_game .
flutter pub add provider
```

Дараа нь энэ багцын `lib/`, `test/`, `docs/` хавтсыг репогийн хавтас руу хуулна.
"Replace" асуувал **Yes** (flutter create-ийн `lib/main.dart`, `test/widget_test.dart`-г солино).

```
flutter pub get
flutter test
flutter run -d chrome
git add .
git commit -m "feat: initial working skeleton (game logic, screens, tests)"
git push origin main
```

Ажиллахгүй бол алдааны мессежийг хуулж явуулаарай.

## 2. Purevtulga

Collaborator урилгыг Accept хийж, clone хийнэ:

```
git clone https://github.com/Unknown-coder-a11y/mobile-tech-memory-game-.git
cd mobile-tech-memory-game-
flutter pub get
flutter run -d chrome
git checkout -b feature/ui-firebase
```

Dulguun: `git checkout -b feature/game-logic`

## 3. Файл бүрийн эзэн

| Хавтас / файл | Эзэн |
|---|---|
| `lib/models/*` | Dulguun |
| `lib/logic/game_provider.dart` | Dulguun |
| `test/game_provider_test.dart` | Dulguun |
| `lib/screens/*` | Purevtulga |
| `lib/widgets/card_widget.dart` | Purevtulga |
| `lib/services/*`, `docs/firebase/*` | Purevtulga |
| `lib/main.dart`, `test/widget_test.dart` | Purevtulga |

Өөр хүний хавтсанд өөрчлөлт хийх бол эхлээд бие биедээ хэлнэ (conflict гарахаас сэргийлнэ).

## 4. Дараагийн ажлууд

**Dulguun (`feature/game-logic`)**
- [ ] Хамгийн сайн оноог тооцох (жишээ нь алхам + хугацаагаар оноо)
- [ ] Тохиромжтой нэмэлт тест: хугацаа эхлэх/зогсох, түвшин солих
- [ ] Картын эх сурвалжийг emoji-оос зураг болгох сонголт (хүсвэл)
- [ ] Онолын судалгаа, PPT-ийн онол/дүгнэлт хэсэг

**Purevtulga (`feature/ui-firebase`)**
- [ ] Figma загварын дагуу өнгө, фонт, дэлгэцийн байршил
- [ ] Картын эргэх animation-г сайжруулах (3D flip гэх мэт)
- [ ] Firebase холбох (`docs/firebase/firestore_score_service.dart.example`)
- [ ] Тохиргоо: дуу, dark theme
- [ ] Постер (A3), PPT-ийн ижил төстэй системийн хэсэг

## 5. Pull Request

1. Ажлаа commit хийж `git push -u origin feature/...`
2. GitHub дээр **Compare & pull request**, `base: main`
3. Нөгөө хүн кодыг нь харж Approve хийгээд Merge
4. Хоёулаа `git checkout main && git pull` хийж, ажлын салбар руугаа `git merge main`

## 6. Одоогийн хязгаарлал

- Оноо апп хаагдахад арилна (`InMemoryScoreService`), Firebase холбосны дараа үлдэнэ.
- Дуу, dark theme, Figma загвар хараахан ороогүй.

# 🕹️ GameOn – Your Gateway to the World of Sports

Welcome to **GameOn**, a powerful mobile app platform built using **Flutter** that bridges the gap between sports enthusiasts, mentors, competitions, and a vibrant sports store. The app includes both a **User Interface** and an **Admin Panel** to manage the ecosystem efficiently.

> 🔗 [GitHub Repository](https://github.com/Naman-Gayakwad/GameOn)  
> 📱 [Download APKs (User & Admin)](https://drive.google.com/drive/folders/1Z-fZauXMEA8KPouGXMwedSvJZIv-YM18?usp=sharing)

---

## 🚀 Key Features

### 🔹 User App
- ✅ **Mentor Discovery** – Users can explore verified mentors in their preferred sport.
- 📅 **Competitions** – Join sports events that are manually approved by admins.
- 📰 **News** – Stay informed with up-to-date sports news and articles.
- 🛍 **Store** – Browse and shop for sporting gear and equipment.
- 🧑‍🏫 **Coaches** – Find and contact certified sports coaches.
- 🎮 **Indoor & Outdoor Toggle** – Toggle between sports categories with dynamic dropdowns.
- 🔐 **Secure Auth** – Log in via email or phone number.

### 🔹 Admin Panel
- 🔐 **Mentor Verification** – All mentor applications must be reviewed and approved.
- 📋 **Competition Approval** – Competitions are listed only after admin approval.
- 🛒 **Product Management** – Add, update, and manage product listings with image uploads.
- 🧾 **View Users & Feedback** – Access user lists and review user-submitted feedback.
- 🌐 **News Management** – Publish and manage news content for users.

---

## 🔧 Firebase Integration (Note)

For security purposes, Firebase configuration has been removed from the repository.

To connect your own Firebase project:
1. Create a Firebase project.
2. Add `google-services.json` (Android) or `GoogleService-Info.plist` (iOS).
3. Enable Firebase services like:
   - Authentication
   - Firestore Database
   - Firebase Storage

Everything else is fully set up and ready to go! Just link Firebase and run.

---

## 📸 Screenshots

### 👤 User App Preview
| Splash Screen | Login Page | Register Page |
|-------------|------------|------------------|
| ![Splash Home](https://github.com/user-attachments/assets/9ff42817-57d1-415b-8467-1c664f591e0f) | ![Login](https://github.com/user-attachments/assets/3718974c-cf9e-4a1c-af6b-96c83d05d653) | ![Register](https://github.com/user-attachments/assets/5c9bd96b-01fe-46f3-b473-56780238308b)|


| Home Screen | Coach Page | Competition Page |
|-------------|------------|------------------|
| ![User Home](https://github.com/user-attachments/assets/59872183-ac15-4cd8-b740-95f47dc750c7) | ![Coach](https://github.com/user-attachments/assets/424572bc-08b6-41a5-aa90-4bb7e0200b03) | ![Competition](https://github.com/user-attachments/assets/9d3ca923-f112-40d7-9bef-565afa57c009) |

| Learn & Practice | News Page | Store Page |
|------------------|-----------|------------|
| ![Learn](https://github.com/user-attachments/assets/63724af3-f14b-4ae5-9e2e-bf00aa04fab6) | ![News](https://github.com/user-attachments/assets/2ad44891-f1ed-45d8-baa5-6a7298d1fc2c) | ![Store](https://github.com/user-attachments/assets/03adb8eb-cef7-43a5-a093-141cdcbf3b79) |

> 🔜 More like: Setting, Profile, Cart, etc
---

### 🛠 Admin Panel Preview

| Upload Product | Verify Mentors | Approve Competitions |
|----------------|----------------|----------------------|
| ![Upload](https://github.com/user-attachments/assets/77f58507-7ff9-4077-9dea-614087e895c3) | ![Verify](https://github.com/user-attachments/assets/9f7b61b9-1c60-4070-b776-44d4e678ef49) | ![Approve](https://github.com/user-attachments/assets/3b7af1f2-45ee-401b-8bc8-0249e6a9da58) |



---

## 📁 Project Structure

```bash
GameOn/
├── admin/              # Admin Flutter App
│   └── lib/
├── user/               # User Flutter App
│   └── lib/
├── assets/             # Common images and logos
├── screenshots/        # Screenshots used in README
├── README.md           # This file
└── .gitignore
```
## 🧰 Built With

- Flutter & Dart
- Firebase (Auth, Firestore, Storage)
- Figma – UI Design
- Provider – State Management

---

## 👤 About the Creator

Made with ❤️ by **Naman Gayakwad**  
🎓 B.Tech CSE, VIT Bhopal    
🏆 Hackathon Winner & Team Leader  
📧 namangayakwad089@gmail.com

---

## 📬 Feedback & Contributions

Found a bug or have a feature idea?  
Feel free to open an issue or submit a PR!

# Task Manager App (Flutter + GetX)

A clean and modern Flutter task management app using **GetX** for state management and **REST API** for backend interaction. The app follows **Clean Architecture** principles and delivers a smooth user experience with organized code structure.

## ✨ Features

- 🔐 User Registration & Login
- ✅ Add New Task
- 📝 Edit Task
- ❌ Delete Task
- 📋 Task Filtering by Status:
    - New Tasks
    - In Progress Tasks
    - Completed Tasks
    - Cancelled Tasks
- 👤 Update User Profile
- 🔄 Password Recovery via Email + OTP

## 🧱 Tech Stack

- **Flutter** – UI Framework
- **GetX** – State Management & Routing
- **Dart** – Programming Language
- **REST API** – Backend communication
- **Clean Architecture** – Data / Domain / Presentation layers
- **Modern UI** – Responsive, reusable widget-based structure


## 🌐 API Endpoints (used)

- POST `/registration`
- POST `/login`
- POST `/createTask`
- GET `/taskStatusCount`
- GET `/listTaskByStatus/New`
- GET `/listTaskByStatus/Progress`
- GET `/listTaskByStatus/Completed`
- GET `/listTaskByStatus/Cancelled`
- GET `/updateTaskStatus/{taskId}/{status}`
- GET `/deleteTask/{taskId}`
- POST `/profileUpdate`
- GET `/RecoverVerifyEmail/{email}`
- GET `/RecoverVerifyOTP/{email}/{otp}`
- POST `/RecoverResetPass`


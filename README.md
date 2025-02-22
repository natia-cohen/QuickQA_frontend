# QuickQA - Frontend (Flutter)

## 📌 Overview

QuickQA is a real-time Q&A application where users can post questions, respond to them, and view new responses in real time.

This project consists of:

- **Backend**: Developed with Flask & MongoDB, serving as the API layer.
- **Frontend**: Built with Flutter, providing the user interface.

---

##  Installation & Setup

---

## 📡 Backend (Flask + MongoDB)

### 📌 **Prerequisites**

- Python 3.8+
- MongoDB installed and running
- Flask and dependencies installed

### 🔹 **Backend Setup**

1. Navigate to the backend directory:

```sh
 cd backend
```

2. Create and activate a virtual environment (optional but recommended):

```sh
 python -m venv venv
 source venv/bin/activate  # macOS/Linux
 venv\Scripts\activate  # Windows
```

3. Install dependencies:

```sh
 pip install -r requirements.txt
```

4. Start the Flask server:

```sh
 python app.py
```

5. The API should now be running at:

```
 http://127.0.0.1:5000
```

---

##  Frontend (Flutter)

###  **Prerequisites**

- Flutter installed 
- Dart SDK installed
- Chrome browser (for web testing)

### 🔹 **Frontend Setup**

1. Navigate to the frontend directory:

```sh
 cd frontend
```

2. Install Flutter dependencies:

```sh
 flutter pub get
```

3. Run the Flutter app:

```sh
 flutter run -d chrome
```

4. The frontend should now be accessible at a dynamically assigned port, e.g.:

```
 http://localhost:55083
```

---

##  API Endpoints

### Questions API:

- **GET** `/questions` → Retrieve all questions
- **POST** `/questions` → Create a new question

### Answers API:

- **POST** `/answer` → Add an answer to a question
- **GET** `/answers?question_id=123` → Retrieve answers for a specific question

---





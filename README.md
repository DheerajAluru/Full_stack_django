# 🍽️ Restaurant Management App – Full Stack Project

This repository contains a complete full-stack application for managing restaurants, built with:

- **Backend**: Django + DRF + PostgreSQL + Redis + gRPC + MQTT
- **Frontend**: React (Task 3 - List, Task 4 - Form)
- **Mobile**: Flutter App
- **DevOps**: Docker, Nginx

---
```bash
## 📁 Project Structure

root/
├── backend/
│ ├── task1/ # Django REST API
│ └── task2/ # gRPC, MQTT protocols
│
├── frontend/
│ ├── task3/ # React App – List restaurants
│ ├── task4/ # React App – Add restaurant form
│ └── nginx/ # Nginx config
│
├── mobile/
│ └── task5_flutter_app/ # Flutter mobile app
```

## ✅ Tasks Completed

| Section     | Task                          | Description                                       |
|-------------|-------------------------------|---------------------------------------------------|
| Backend     | Task 1                        | Django REST APIs with PostgreSQL & Redis         |
| Frontend    | Task 2                        | React: List all restaurants                      |
| Frontend    | Task 3                        | React: Add restaurant form                       |
| Mobile      | Task 4                        | Flutter app to fetch restaurant list             |

---

## ⚙️ Backend Setup – Django + PostgreSQL + Redis

### 📦 Install Dependencies

```bash
cd backend/task1
python -m venv venv
source venv/bin/activate  # Windows: venv\Scripts\activate
pip install -r ../requirements.txt
```
```bash
DEBUG=True
SECRET_KEY=your-secret-key
ALLOWED_HOSTS=*
```

```bash
POSTGRES_DB=postgres
POSTGRES_USER=postgres
POSTGRES_PASSWORD=postgres
DB_HOST=db
DB_PORT=5432

REDIS_HOST=redis
REDIS_PORT=6379
```
```bash
🐳 Start Database Services
bash
Copy
Edit
docker-compose up -d

```
```bash
🛠 Run Migrations & Start Server

python manage.py migrate
python manage.py createsuperuser
python manage.py runserver

```
```bash
🌐 Frontend Setup – React (Task 3 & 4)
Task 3: List Restaurants

cd frontend/task3
npm install
npm start
Task 4: Add Restaurant Form
bash
Copy
Edit
cd frontend/task4
npm install
npm start
```
```bash
📱 Mobile Setup – Flutter (Task 5)
📦 Install & Run

cd mobile/task5_flutter_app
flutter pub get
flutter run
Make sure backend is running on your host and accessible via http://10.0.2.2:8000 (for Android emulator).
```

📄 API Endpoints
Method	Endpoint	Description
GET	/api/restaurants/	List all restaurants
POST	/api/restaurants/	Create new restaurant
GET	/admin/	Django admin panel


🧠 Technologies Used
Layer	Tools
Backend	Django, DRF, PostgreSQL, Redis
Frontend	React, Axios, React Hooks
Mobile	Flutter, Dart
DevOps	Docker, Docker Compose, Nginx

Demo

<!DOCTYPE html>
<html>
<body>
  
  <iframe src="https://drive.google.com/file/d/1T4cq2H7UwBtpvjyErm2NaBJpfH4wgQEy/preview" width="640" height="480" allow="autoplay"></iframe>
  
  <!--aloow full screen add tag -->
  
<iframe allowfullscreen="allowfullscreen" src="https://drive.google.com/file/d/1T4cq2H7UwBtpvjyErm2NaBJpfH4wgQEy/preview" ></iframe>

</body>
</html>
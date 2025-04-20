# WEBC

![](/ReadMe_images/logo.jpg)

# 📚 Academic Management System – Professional Programming Project

This project was developed as part of the **Professional Programming** course. Its goal was to implement good practices in full-stack web development, mimicking platforms like WebCursos (UAI).

## 🎯 Project Objective

To build an educational platform supporting interactions between **students**, **teachers**, and **administrators**. Features include:

- JWT-based authentication
- Role-based access control
- File upload (from frontend)
- QR code-based attendance
- Course creation and management
- Course enrollment
- Role-specific views
- Optional chatbot for support

## 🧪 Technologies Used

### 🔧 Backend
- **Python**
- **Flask**
- **Flask-RESTx**
- **JWT** for authentication
- **bcrypt** for password hashing
- **SQLAlchemy** for database ORM
- **Flask-CORS** for CORS handling

### 🎨 Frontend
- **React.js**
- **JavaScript**
- **Axios** for API requests
- **React Router** for navigation

### 🗄️ Database
- **PostgreSQL**

## 🔐 User Roles

- 👩‍🎓 **Student:** View courses, mark attendance, access files.
- 👨‍🏫 **Teacher:** Manage attendance, see enrolled students.
- 🛠️ **Admin:** Create courses, manage users and enrollment.

## 🚀 How to Run the Project

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/project-name.git
cd project-name
```

### 2. Backend

```bash
cd backend
pip install -r requirements.txt
python main.py
```

### 3. Frontend

```bash
cd frontend
npm install
npm start
```

The app will be available at [http://localhost:3000](http://localhost:3000)

## 🧪 Default Users

| Name     | Email              | Password | Role      |
|----------|--------------------|----------|-----------|
| Javiera  | javi@correo.cl     | queso    | student   |
| Nachito  | nachito@correo.cl  | Nachito  | admin     |
| Cony     | cony@correo.cl     | Cony     | teacher   |




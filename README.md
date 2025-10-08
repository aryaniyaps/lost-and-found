# 🔍 Lost & Found System

<div align="center">

![Java](https://img.shields.io/badge/Java-21-orange?style=for-the-badge&logo=openjdk)
![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.x-brightgreen?style=for-the-badge&logo=spring)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-15-blue?style=for-the-badge&logo=postgresql)
![TailwindCSS](https://img.shields.io/badge/Tailwind-CSS-38B2AC?style=for-the-badge&logo=tailwind-css)

**A modern web application to help reunite lost items with their owners**

[Features](#-features) • [Quick Start](#-quick-start) • [API Documentation](#-api-documentation) • [Tech Stack](#-tech-stack)

</div>

---

## ✨ Features

### 🎯 Core Functionality
- **Item Management** - Report lost or found items with detailed descriptions
- **Smart Search** - Real-time search across titles and descriptions
- **Category Filtering** - Filter items by category (Electronics, Clothing, Documents, Keys, etc.)
- **Intelligent Matching** - Automatic suggestions for potential matches between lost and found items

### 💬 Social Features
- **Comment System** - Users can comment on items to provide additional information
- **User Dashboard** - Personalized statistics and recent activity overview
- **Complaint System** - File and track complaints with status updates

### 🔐 Security
- **JWT Authentication** - Secure token-based authentication
- **Role-based Access** - Protected endpoints and user-specific data
- **Password Encryption** - BCrypt password hashing

---

## 🚀 Quick Start

### Prerequisites
- Java 21
- Docker & Docker Compose
- Maven (included via wrapper)

### Installation

1. **Clone the repository**
```bash
git clone <repository-url>
cd lost-and-found
```

2. **Start the database**
```bash
docker-compose up -d
```

3. **Run the application**
```bash
cd spring-app
./mvnw spring-boot:run
```

4. **Access the application**
```
http://localhost:8080
```

### Clean Build
```bash
./mvnw clean spring-boot:run
```

---

## 📸 Screenshots

### Home Page
Modern landing page with quick access to report and view items.

### Items Dashboard
Browse all lost and found items with search and filter capabilities.

### User Dashboard
Track your items, complaints, and activity statistics.

---

## 🛠️ Tech Stack

### Backend
- **Spring Boot 3.x** - Application framework
- **Spring Security** - Authentication & authorization
- **Spring Data JPA** - Database operations
- **PostgreSQL** - Primary database
- **JWT** - Token-based authentication
- **Maven** - Dependency management

### Frontend
- **JSP** - Server-side rendering
- **TailwindCSS** - Modern utility-first CSS
- **Vanilla JavaScript** - Client-side interactivity

---

## 📡 API Documentation

### Authentication
```http
POST /api/auth/register
POST /api/auth/login
```

### Items
```http
GET    /api/items                    # Get all items
GET    /api/items?type=LOST          # Filter by type
GET    /api/items/search?q=phone     # Search items
GET    /api/items/filter?category=Electronics  # Filter by category
GET    /api/items/{id}               # Get item details
GET    /api/items/{id}/matches       # Get potential matches
POST   /api/items                    # Create new item
PATCH  /api/items/{id}/status        # Update item status
DELETE /api/items/{id}               # Delete item
```

### Comments
```http
GET  /api/items/{itemId}/comments    # Get comments
POST /api/items/{itemId}/comments    # Add comment
```

### Dashboard
```http
GET /api/dashboard/stats             # Get user statistics
```

### Complaints
```http
GET  /api/complaints                 # Get all complaints
POST /api/complaints                 # File new complaint
```

---

## 🗂️ Project Structure

```
lost-and-found/
├── spring-app/
│   ├── src/
│   │   ├── main/
│   │   │   ├── java/com/example/demo/
│   │   │   │   ├── config/          # Security configuration
│   │   │   │   ├── controller/      # REST & View controllers
│   │   │   │   ├── dto/             # Data transfer objects
│   │   │   │   ├── entity/          # JPA entities
│   │   │   │   ├── repository/      # Data repositories
│   │   │   │   ├── security/        # JWT utilities
│   │   │   │   └── service/         # Business logic
│   │   │   ├── resources/
│   │   │   │   └── application.properties
│   │   │   └── webapp/WEB-INF/views/  # JSP templates
│   │   └── test/
│   └── pom.xml
├── docker-compose.yml
└── README.md
```

---

## 🎨 Features Breakdown

### Item Search & Filter
- **Real-time Search**: Search items as you type
- **Category Filter**: Dropdown filter for quick category selection
- **Type Filter**: Filter between Lost and Found items
- **Case-insensitive**: All searches and filters work regardless of case

### Smart Matching Algorithm
The system automatically suggests potential matches by:
- Finding opposite type items (Lost ↔ Found)
- Matching by category (case-insensitive)
- Comparing titles and descriptions
- Ranking by relevance

### User Dashboard
Track your activity with:
- Total items reported
- Active vs claimed items
- Complaint statistics
- Recent items list with quick links

### Comment System
- Add comments to any item
- View comment history
- See commenter details and timestamps
- Threaded discussion support

---

## 🔧 Configuration

### Database Configuration
Edit `spring-app/src/main/resources/application.properties`:
```properties
spring.datasource.url=jdbc:postgresql://localhost:5432/lostfound
spring.datasource.username=postgres
spring.datasource.password=postgres
```

### JWT Configuration
```properties
jwt.secret=your-secret-key
jwt.expiration=86400000
```

---

<div align="center">

**[⬆ back to top](#-lost--found-system)**

</div>

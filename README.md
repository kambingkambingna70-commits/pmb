# PMB - Penerimaan Mahasiswa Baru (Student Admissions System)

Repository ini berisi 2 project utama:

## 📁 Struktur Project

### 1. `tugasakhir/` - Main Application
- **Type**: Spring Boot Java Application (Tugas Akhir)
- **Framework**: Spring Boot, Thymeleaf, JPA/Hibernate
- **Database**: MySQL/PostgreSQL
- **Features**: 
  - Online Registration System
  - Exam Management
  - Payment Processing (BRIVA Integration)
  - Admin Dashboard
  - User Authentication & Authorization
  - AI-powered Chat Assistant (Gemini Integration)

**Build & Run**:
```bash
cd tugasakhir
mvn spring-boot:run
```

### 2. `Latex-TA-IF-ITERA-main/` - Thesis Documentation
- **Type**: LaTeX Document
- **Content**: Technical documentation and thesis for student admissions system
- **Build**: Use LaTeX compiler (pdflatex, xelatex)

## 🚀 Getting Started

### Prerequisites
- Java 17+
- Maven 3.8+
- MySQL 8.0+
- Node.js (optional, for frontend dev)

### Quick Start
```bash
cd tugasakhir
cp .env.example .env
# Update .env with your database credentials
mvn clean install
mvn spring-boot:run
```

Application will be available at: `http://localhost:8080`

## 📝 Documentation
- See `tugasakhir/README.md` for detailed setup instructions
- See `Latex-TA-IF-ITERA-main/README.md` for thesis documentation

## 👨‍💼 Author
Mychael Daniel - ITERA 2024-2026

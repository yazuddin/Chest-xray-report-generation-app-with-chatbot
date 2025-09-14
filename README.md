# Chest X-Ray Report Generation App with Chatbot

A comprehensive medical imaging application that generates detailed chest X-ray analysis reports using AI/ML models and includes an intelligent chatbot for medical consultations.

## 🏗️ Project Structure

```
chest-xray-app/
├── frontend/                 # React.js frontend application
│   ├── public/
│   ├── src/
│   │   ├── components/       # Reusable React components
│   │   │   ├── Header.js
│   │   │   ├── ImageUpload.js
│   │   │   ├── PatientForm.js
│   │   │   ├── ReportDisplay.js
│   │   │   ├── FloatingChatbot.js
│   │   │   └── HistoryView.js
│   │   ├── App.js           # Main application component
│   │   ├── App.css          # Global styles
│   │   └── index.js         # Application entry point
│   ├── package.json         # Frontend dependencies
│   └── package-lock.json
├── backend/                  # Node.js backend API
│   ├── config/
│   │   └── database.js      # Database configuration
│   ├── utils/
│   │   └── fileDatabase.js  # File-based database utilities
│   ├── data/                # Database storage directory
│   ├── server.js            # Main backend server
│   ├── test_server.js       # Simplified test server
│   ├── package.json         # Backend dependencies
│   └── package-lock.json
├── chestxray/               # Python ML service
│   ├── models/              # AI/ML model files
│   ├── app_simple.py        # Flask API server
│   ├── requirements.txt     # Python dependencies
│   └── images/              # Sample X-ray images
├── README.md                # Project documentation
└── .gitignore              # Git ignore rules
```

## ✨ Features

### 🔬 Medical Analysis
- **AI-Powered X-Ray Analysis**: Upload chest X-ray images for automated analysis
- **Detailed Medical Reports**: Generate comprehensive reports with clinical findings
- **Patient Information Management**: Store and manage patient data securely
- **Analysis History**: View and access previous medical analyses

### 💬 Intelligent Chatbot
- **Medical Consultation**: Interactive chatbot for medical queries
- **Session Management**: Persistent chat sessions with history storage
- **Contextual Responses**: AI-powered responses for medical questions
- **Real-time Communication**: Instant messaging interface

### 🎨 Modern UI/UX
- **Responsive Design**: Optimized for desktop, tablet, and mobile devices
- **Dark/Light Mode**: Toggle between dark and light themes
- **Smooth Animations**: Framer Motion powered animations and transitions
- **Intuitive Interface**: User-friendly design with modern aesthetics

### 💾 Data Management
- **File-Based Database**: Lightweight storage for chat history and analyses
- **Session Persistence**: Maintain user sessions across visits
- **Data Export**: Export medical reports and analysis data

## 🚀 Quick Start

### Prerequisites
- Node.js (v14 or higher)
- Python (v3.8 or higher)
- npm or yarn package manager

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd chest-xray-app
   ```

2. **Set up the Python ML Service**
   ```bash
   cd chestxray
   pip install -r requirements.txt
   python app_simple.py
   ```
   The Flask API will run on `http://localhost:5001`

3. **Set up the Node.js Backend**
   ```bash
   cd backend
   npm install
   node test_server.js
   ```
   The backend API will run on `http://localhost:5003`

4. **Set up the React Frontend**
   ```bash
   cd frontend
   npm install
   npm start
   ```
   The frontend will run on `http://localhost:3000`

### 🔧 Configuration

#### Backend Configuration
- **Port**: Default port is 5003 (configurable via environment variables)
- **Database**: File-based storage in `backend/data/` directory
- **Flask API**: Connects to Python service on port 5001

#### Frontend Configuration
- **API Base URL**: `http://localhost:5003/api`
- **Theme**: Supports dark/light mode with localStorage persistence
- **Responsive Breakpoints**: Mobile (480px), Tablet (768px), Desktop (1024px+)

## 📡 API Endpoints

### Backend API (Port 5003)

#### Medical Analysis
- `POST /api/analyze` - Upload and analyze X-ray images
- `GET /api/medical-analyses` - Retrieve all medical analyses
- `GET /api/medical-analysis/:id` - Get specific analysis by ID

#### Chat System
- `POST /api/general-chat` - Send chat message and get response
- `GET /api/chat-history/:sessionId` - Retrieve chat history for session

#### Health Check
- `GET /api/health` - Server health status

### Python ML API (Port 5001)
- `POST /analyze` - Process X-ray image and generate medical report

## 🛠️ Development

### Running in Development Mode

1. **Start all services simultaneously:**
   ```bash
   # Terminal 1: Python ML Service
   cd chestxray && python app_simple.py
   
   # Terminal 2: Node.js Backend
   cd backend && node test_server.js
   
   # Terminal 3: React Frontend
   cd frontend && npm start
   ```

2. **Access the application:**
   - Frontend: `http://localhost:3000`
   - Backend API: `http://localhost:5003`
   - ML Service: `http://localhost:5001`

### 🧪 Testing

#### Test X-Ray Analysis
```bash
curl -X POST -F "image=@images/sample.png" -F "reportLength=100" http://localhost:5003/api/analyze
```

#### Test Chat API
```bash
curl -X POST -H "Content-Type: application/json" -d '{"message":"Hello","sessionId":"test123"}' http://localhost:5003/api/general-chat
```

## 🔒 Security Features

- **Input Validation**: Comprehensive validation for all user inputs
- **File Upload Security**: Secure handling of medical image uploads
- **Session Management**: Secure session handling with unique identifiers
- **Error Handling**: Graceful error handling and user feedback

## 📱 Responsive Design

### Mobile Optimization
- Touch-friendly interface elements
- Optimized image upload for mobile devices
- Responsive navigation and layout
- Mobile-first CSS approach

### Accessibility
- WCAG 2.1 compliant design
- Keyboard navigation support
- Screen reader compatibility
- High contrast mode support

## 🎯 Performance Optimizations

- **Code Splitting**: Lazy loading of components
- **Image Optimization**: Efficient handling of medical images
- **Caching**: Strategic caching of API responses
- **Bundle Optimization**: Minimized JavaScript bundles

## 🚀 Deployment

### Production Build

1. **Build Frontend**
   ```bash
   cd frontend
   npm run build
   ```

2. **Configure Environment Variables**
   ```bash
   # Backend
   export PORT=5003
   export NODE_ENV=production
   
   # Python Service
   export FLASK_ENV=production
   ```

3. **Start Production Services**
   ```bash
   # Use PM2 or similar process manager
   pm2 start backend/test_server.js --name "backend"
   pm2 start chestxray/app_simple.py --name "ml-service"
   ```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Check the documentation
- Review the API endpoints

## 🔄 Version History

- **v1.0.0** - Initial release with core functionality
  - X-ray analysis with AI/ML integration
  - Interactive chatbot system
  - Responsive web interface
  - File-based data storage
  - Dark/light theme support

---

**Note**: This application is for educational and demonstration purposes. Always consult with qualified medical professionals for actual medical diagnoses and treatment decisions.
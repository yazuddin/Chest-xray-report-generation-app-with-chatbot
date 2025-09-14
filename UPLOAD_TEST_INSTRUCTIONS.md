# X-Ray Upload Test Instructions

## Test Accounts Available

### Medical Technician Account
- **Email:** tech@test.com
- **Password:** password123
- **Role:** medical_technician

### Patient Accounts
- **Patient 1:** patient@test.com / password123 (Patient ID: P167863299)
- **Patient 2:** patient2@test.com / password123 (Patient ID: P167863300)

## How to Test Upload Functionality

### Step 1: Access the Application
1. Open your browser and go to: http://localhost:3000
2. You should see the authentication page

### Step 2: Login as Technician
1. Click "Sign In" tab
2. Enter technician credentials:
   - Email: tech@test.com
   - Password: password123
3. Click "Sign In"
4. Select "Medical Technician" role
5. You should be redirected to the technician dashboard

### Step 3: Test Upload
1. On the technician dashboard, you'll see:
   - Patient ID input field
   - File upload area
   - "Test API Connection" button (blue)
   - "Upload X-Ray" button (green)

2. **First, test the API connection:**
   - Click the "Test API Connection" button
   - Check browser console (F12) for connection status
   - You should see a success message

3. **Upload an X-ray:**
   - Enter Patient ID: **P167863300**
   - Select any image file (JPG, PNG)
   - Click "Upload X-Ray"
   - Check browser console (F12) for detailed debug information

### Step 4: Check Results
- If successful, you should see:
  - Success toast notification
  - Analysis results displayed
  - Upload added to history

### Debugging Information
The upload function now includes extensive console logging. Open browser developer tools (F12) and check the Console tab to see:
- Authentication status
- File and patient ID details
- Request/response information
- Detailed error messages if upload fails

## Backend API Testing (Alternative)

If frontend upload doesn't work, you can test the backend directly:

```bash
# 1. Login to get token
curl -X POST http://localhost:5004/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"email": "tech@test.com", "password": "password123"}'

# 2. Use the token from step 1 to upload (replace TOKEN_HERE)
curl -X POST http://localhost:5004/api/analyze \
  -H "Authorization: Bearer TOKEN_HERE" \
  -F "image=@path/to/your/image.jpg" \
  -F "patientId=P167863300" \
  -F "reportLength=100"
```

## Troubleshooting

### Common Issues:
1. **"Please select a file and enter patient ID"** - Make sure both fields are filled
2. **"User not authenticated"** - Login again or check token in localStorage
3. **"Patient not found"** - Use Patient ID: P167863300 (confirmed to exist)
4. **Network errors** - Ensure backend server is running on port 5004

### Check Server Status:
- Frontend: http://localhost:3000
- Backend: http://localhost:5004/api/health (should return health status)

## Status Update

✅ **Backend API**: Fully functional - login, authentication, and image upload/analysis working
✅ **Authentication**: Token-based auth working correctly
✅ **Patient Records**: Test patients created and verified
✅ **Frontend**: Enhanced with debugging and corrected API endpoints

The upload functionality should now work correctly. If you still experience issues, check the browser console for detailed error information.
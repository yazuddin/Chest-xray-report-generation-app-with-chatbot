// Complete Upload Flow Test Script
const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');
const path = require('path');

const API_BASE = 'http://localhost:5004/api';

async function testCompleteFlow() {
  console.log('=== Testing Complete Upload Flow ===\n');
  
  try {
    // Step 1: Login as technician
    console.log('1. Logging in as technician...');
    const loginResponse = await axios.post(`${API_BASE}/auth/login`, {
      email: 'tech@test.com',
      password: 'password123'
    });
    
    const token = loginResponse.data.token;
    console.log('✓ Login successful');
    console.log('Token:', token.substring(0, 50) + '...');
    
    // Step 2: Set up axios with token
    const authenticatedAxios = axios.create({
      baseURL: API_BASE,
      headers: {
        'Authorization': `Bearer ${token}`
      }
    });
    
    // Step 3: Test profile endpoint
    console.log('\n2. Testing profile endpoint...');
    const profileResponse = await authenticatedAxios.get('/auth/profile');
    console.log('✓ Profile retrieved:', profileResponse.data.user.email);
    
    // Step 4: Test image upload
    console.log('\n3. Testing image upload...');
    
    // Create a test image file if it doesn't exist
    const testImagePath = path.join(__dirname, 'test-xray.jpg');
    if (!fs.existsSync(testImagePath)) {
      // Create a minimal test file
      fs.writeFileSync(testImagePath, Buffer.from('fake-image-data'));
      console.log('Created test image file');
    }
    
    const formData = new FormData();
    formData.append('image', fs.createReadStream(testImagePath));
    formData.append('patientId', 'P167863300');
    formData.append('reportLength', '100');
    
    const uploadResponse = await authenticatedAxios.post('/analyze', formData, {
      headers: {
        ...formData.getHeaders()
      }
    });
    
    console.log('✓ Upload successful!');
    console.log('Analysis ID:', uploadResponse.data.analysisId);
    console.log('Report preview:', uploadResponse.data.report.substring(0, 100) + '...');
    
    console.log('\n=== All tests passed! ===');
    
  } catch (error) {
    console.error('❌ Test failed:');
    console.error('Error:', error.response?.data || error.message);
    console.error('Status:', error.response?.status);
    console.error('Headers:', error.response?.headers);
  }
}

testCompleteFlow();
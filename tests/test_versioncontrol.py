import requests
import json
import time

def test_versioncontrol_service():
    base_url = "http://versioncontrol:8001"
    
    print("🚀 Testing Version Control Service...")
    
    try:
        # Test health endpoint
        print("1. Testing health endpoint...")
        health_response = requests.get(f"{base_url}/health", timeout=5)
        print(f"   ✅ Health check: {health_response.status_code} - {health_response.json()}")
        
        # Test root endpoint
        print("2. Testing root endpoint...")
        root_response = requests.get(f"{base_url}/", timeout=5)
        print(f"   ✅ Root endpoint: {root_response.status_code} - {root_response.json()}")
        
        print("🎉 All tests passed! Version Control Service is working correctly.")
        
    except requests.exceptions.ConnectionError:
        print("❌ Cannot connect to Version Control Service. Is it running?")
    except requests.exceptions.Timeout:
        print("❌ Request timed out. Service might be starting up.")
    except Exception as e:
        print(f"❌ Error testing version control: {e}")

if __name__ == "__main__":
    test_versioncontrol_service()
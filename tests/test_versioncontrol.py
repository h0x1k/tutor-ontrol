import requests
import json

def test_versioncontrol_service():
    base_url = "http://versioncontrol:8001"
    
    print("Testing Version Control Service...")
    
    try:
        # Test health endpoint
        health_response = requests.get(f"{base_url}/health")
        print(f"Health check: {health_response.status_code} - {health_response.json()}")
        
        # Test creating a repository
        repo_data = {
            "name": "test-repo",
            "description": "Test repository"
        }
        create_response = requests.post(f"{base_url}/repositories", json=repo_data)
        print(f"Create repo: {create_response.status_code} - {create_response.json()}")
        
        # Test listing repositories
        list_response = requests.get(f"{base_url}/repositories")
        print(f"List repos: {list_response.status_code} - {list_response.json()}")
        
    except Exception as e:
        print(f"Error testing version control: {e}")

if __name__ == "__main__":
    test_versioncontrol_service()
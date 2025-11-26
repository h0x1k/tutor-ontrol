#!/bin/bash

# Generate self-signed SSL certificate for production (or use real certificates)

SSL_DIR="./nginx/ssl"
mkdir -p "$SSL_DIR"

echo "🔐 Generating SSL certificate..."

# For production, you should use real certificates from Let's Encrypt or your CA
# This script generates a self-signed certificate as a fallback

if [ -f "$SSL_DIR/cert.pem" ] && [ -f "$SSL_DIR/key.pem" ]; then
    echo "⚠️  SSL certificates already exist."
    echo "   To regenerate, delete $SSL_DIR/cert.pem and $SSL_DIR/key.pem first"
    exit 0
fi

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$SSL_DIR/key.pem" \
    -out "$SSL_DIR/cert.pem" \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

echo "✅ SSL certificate generated!"
echo "📁 Certificate: $SSL_DIR/cert.pem"
echo "📁 Private key: $SSL_DIR/key.pem"
echo ""
echo "⚠️  For production, use real SSL certificates:"
echo "   1. Get certificates from Let's Encrypt (certbot)"
echo "   2. Or use certificates from your CA"
echo "   3. Place them in $SSL_DIR/"


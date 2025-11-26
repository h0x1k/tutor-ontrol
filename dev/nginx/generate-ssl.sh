#!/bin/bash

# Generate self-signed SSL certificate for development

SSL_DIR="./nginx/ssl"
mkdir -p "$SSL_DIR"

echo "🔐 Generating self-signed SSL certificate for development..."

openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout "$SSL_DIR/key.pem" \
    -out "$SSL_DIR/cert.pem" \
    -subj "/C=US/ST=State/L=City/O=Organization/CN=localhost"

echo "✅ SSL certificate generated!"
echo "📁 Certificate: $SSL_DIR/cert.pem"
echo "📁 Private key: $SSL_DIR/key.pem"
echo ""
echo "⚠️  This is a self-signed certificate for development only."
echo "   Your browser will show a security warning - this is normal."
echo "   Click 'Advanced' → 'Proceed to localhost' to continue."


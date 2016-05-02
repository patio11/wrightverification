# Usage: ruby verification.rb <FILE TO VERIFY AGAINST PUBLIC KEY AND SIGNATURE.>
require "openssl"

file_to_verify = ARGV[1] || "sn7-message.txt"

claimed_public_key = File.read("claimed-public-key.txt").split.join.strip
claimed_public_key_bign = claimed_public_key.to_i(16).to_bn

group = OpenSSL::PKey::EC::Group.new('secp256k1')
curve = OpenSSL::PKey::EC.new(group)

curve.public_key = OpenSSL::PKey::EC::Point.new(group, claimed_public_key_bign)

signature = File.binread("sig.asn1")
claimed_signed_hash = File.binread(file_to_verify)

verifies = curve.dsa_verify_asn1(claimed_signed_hash, signature)

puts "File #{file_to_verify} " + (verifies ? "verifies" : "does not verify") + " against Wright's provided signature."

double_hashed = OpenSSL::Digest::SHA256.digest(claimed_signed_hash)

verifies = curve.dsa_verify_asn1(double_hashed, signature)

puts "*The hash of* #{file_to_verify} " + (verifies ? "verifies" : "does not verify") + " against Wright's provided signature."


# Usage: ruby verification.rb <FILE TO VERIFY AGAINST PUBLIC KEY AND SIGNATURE.>
require "openssl"

file_to_verify = ARGV[1] || "sn7-message.txt"

claimed_public_key = "0411db93e1dcdb8a016b49840f8c53bc1eb68a382e97b1482ecad7b148a6909a5cb2e0eaddfb84ccf9744464f82e160bfa9b8b64f9d4c03f999b8643f656b412a3"
claimed_public_key_bign = claimed_public_key.to_i(16).to_bn


group = OpenSSL::PKey::EC::Group.new('secp256k1')
curve = OpenSSL::PKey::EC.new(group)

curve.public_key = OpenSSL::PKey::EC::Point.new(group, claimed_public_key_bign)

asn1 = File.binread("sig.asn1")
claimed_signed_hash = File.binread(file_to_verify)

verifies = curve.dsa_verify_asn1(claimed_signed_hash, asn1)

puts "File #{file_to_verify} " + (verifies ? "verifies" : "does not verify") + " against Wright's provided signature."
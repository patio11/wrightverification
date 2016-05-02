# Attempting (Failed) Verification of the Wright Signature

Craig Wright (claims)[http://www.drcraigwright.net/jean-paul-sartre-signing-significance/] to be Satoshi, the pseudonymous creator of Bitcoin.

His proferred proof for this is a cryptographic signature.  This gets complicated:

1)  A certain [well-known transaction](https://blockchain.info/tx/f4184fc596403b9d638783cf57adfe4c75c605f6356fbc91338530e9831e9e16), Bitcoin's first, was between Satoshi and Hal Finney.
We treat the provenance of this transaction as a settled question.

2)  Anyone controlling the public key corresponding either the input address or the change address from that transaction is, presumptively, associated with Satoshi.

3)  Craig claims that he can sign an arbitrary message with the public key corresponding to the input address, 12cbQLTFMXRnSzktFkuoG3eHoMeFtpTu3S

4)  Craig claims to have signed a passage about Sartre.

# The Part Which Actually Works

Craig is successfully able to go from a Bitcoin address to the public key associated with it, and you can, too!

[Here](http://gobittest.appspot.com/Address) are the steps, with handy on-page execution of them.

We can see, via inputing Wright's claimed public key (transcribed in claimed-public-key.txt), that it does match the 12cbQLTF address which sent Finney Bitcoin.

# The Part Which Doesn't Work

Let's review the proferred signature.

To review Public/Private Crypto 101, you sign with your private key.  One verifies with the public key.

We don't possess Satoshi's private key.  We do possess one public key presumptively belonging to him.  We also possess a bag-of-bytes from Wright, which he claims signs the Sartre text.

Spoiler: j controllers


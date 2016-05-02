# Attempting (Failed) Verification of the Wright Signature

Craig Wright [claims](http://www.drcraigwright.net/jean-paul-sartre-signing-significance/) to be Satoshi, the pseudonymous creator of Bitcoin.

His proferred proof for this is a cryptographic signature.  This gets complicated:

1)  A certain [well-known transaction](https://blockchain.info/tx/f4184fc596403b9d638783cf57adfe4c75c605f6356fbc91338530e9831e9e16), Bitcoin's first, was between Satoshi and Hal Finney.
We treat the provenance of this transaction as a settled question.

2)  Anyone controlling the private key corresponding either the input address or the change address from that transaction is, presumptively, associated with Satoshi.

3)  Craig claims that he can sign an arbitrary message with the private key corresponding to the input address, 12cbQLTFMXRnSzktFkuoG3eHoMeFtpTu3S

4)  Craig claims to have signed a passage about Sartre.

## The Part Which Actually Works

Craig is successfully able to go from a Bitcoin address to the public key associated with it, and you can, too!

[Here](http://gobittest.appspot.com/Address) are the steps, with handy on-page execution of them.

We can see, via inputing Wright's claimed public key (transcribed in claimed-public-key.txt), that it does match the 12cbQLTF address which sent Finney Bitcoin.

## The Part Which Doesn't Work

Let's review the proferred signature.

To review Public/Private Crypto 101, you sign with your private key.  One verifies with the public key.

We don't possess Satoshi's private key.  We do possess one public key presumptively belonging to him.  We also possess a bag-of-bytes from Wright, which he claims signs the Sartre text.

First, we generate the sig.  Wright has provided `MEUCIQDBKn1Uly8m0UyzETObUSL4wYdBfd4ejvtoQfVcNCIK4AIgZmMsXNQWHvo6KDd2Tu6euEl1
3VTC3ihl6XUlhcU+fM4=` for us, which is transcribed into signature.der in this repository.

We then use a Wright-blessed command to transform the signature into a form that our utilities can work with.

```
  # Base64 decode the signature into ASN1 form.
  $ base64 --decode signature.der > sig.asn1
```

We've got the public key, we've got the signature, now we just need the text which the signature claims to match.
Dan Kaminsky generously [transcribed](https://dankaminsky.com/2016/05/02/validating-satoshi-or-not/) the hash of the text, which Wright claims the signature corresponds to.  I've included hash as sn7-message.txt.  You can verify that it matches the claimed hash from Wright.

```
  # Verify signature of hash file.
  hexdump sn7-message.txt
  # You'll have to visually compare this against Wright's screenshots, but it matches.
  # If this sounds *fishy* to you, well, you're right.  Also fishy: making people hand-edit hex values
  # to verify trivial parts of this evidence chain.
```

And now we try to validate the message, using Ruby's OpenSSL bindings.

```
  ruby verification.rb sn7-message.txt
```

Feel free to inspect the code and tell me if I'm misunderstanding those bindings, but I rather don't think I am.

The hash of the message **fails signature validation**.  At this point, we don't know whether the signature is anything other than random bytes.

## Spoiler: It Isn't Random Bytes

The signature provided isn't actually a signature of any text of Sartre.  It is actually a bag of bytes already taken from the blockchain,
as [discovered by /u/JoukeH on /r/Bitcoin](https://www.reddit.com/r/Bitcoin/comments/4hf4xj/creator_of_bitcoin_reveals_identity/d2pf70v).

** Edit a little later:**

[Ryan Castelluci](https://twitter.com/ryancdotorg/) [did some legwork](https://gist.github.com/ryancdotorg/893815f426f181d838c1b44aa187f05a) 
if you want to see how the scriptSig that Wright re-used corresponds to a transaction already on the blockchain, on the verifying-the-transaction level.
This is apparently how Wright constructed the signature (from the published scriptSig).

I'm not entirely sure why I fail to validate it if it could be validated -- possibly a version mixup on OpenSSL, like Dan Kaminsky is reporting.

## My Head Hurts. What Does This Mean?

Wright's post is flimflam and hokum which stands up to a few minutes of cursory scrutiny, and demonstrates a competent sysadmin's level of familiarity
with cryptographic tools, but ultimately demonstrates no non-public information about Satoshi.

## Do You Believe Wright Is Satoshi?

But for the endorsement of core developer [Gavin Andresen](http://gavinandresen.ninja/satoshi), I would assume that Wright used amateur magician tactics to distract
non-technical or non-expert staff of the BBC and the Economist during a stage-managed demonstration.  I'm reasonably confident that
I could have sold the same story, with approximately two hours of preparation.  The non-experts did not ask to see things which would
be hard for non-Satoshi to provide -- they were at the mercy of the charlatan (paging James Randi, James Randi to the courtesy phone please).

I'm mystified as to how this got past Andresen, though.

The entire protocol for the verification is suspect: you shouldn't ask the purported Satoshi to do a series of operations under his own control,
on his own machine or anyone else's.  You should simply give him an arbitrary message (e.g. "I, Wright, am Satoshi -- here's a random nonce: 4203234."), have him sign it and transfer you the signature, then *you* verify the signature on your own machine against a public key that *you*
trust belonged to Satoshi.

One of the very few things that Bitcoin meaningfully has accomplished as an ecosystem is a world-readable repository of reasonably-well-attested-to-keys.  Why was this demonstration so hard?!  It's bleeping trivial to the real Satoshi (or anyone possessing his private key) and nigh-upon impossible for anyone else.  (An acceptable alternative would have been "Move any Bitcoin from that same output, to anywhere, on command", but there are at
least conceivable reasons why that would have been unwise.)

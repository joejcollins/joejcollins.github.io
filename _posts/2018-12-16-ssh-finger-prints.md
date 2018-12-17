---
layout: post
---

For the given ssh public key generate md5 (`65:73:b8:a1:2b:f0:08:36:f7:c4:5d:e4:d7:d8:56:08`) and sha256
(`qReUyTyRzocnY1bfy0ghVGOudo4CrAWvbdbMi4vQ0FI`) hashes.

    ssh-rsa
    AAAAB3NzaC1yc2EAAAADAQABAAABBwDWEzJA55Okk7P8VPdhOw5a
    TsLsxnuT0iLbpFb+/
    BOJ6SIvPtKNq1Tr4DXoIf9UG8Q6Mcuuglm1CFLDutVzcRHNjJ8FLu+LKQ
    X9tn6fJy3oWHMtB15vRVM8J2sg48Fy8lFncT4mxG1ig2/
    vrjNdKJXj93wNsLn4oUMLWim1+5BIFoejw2+Oq26/In6gXxGj2LG+
    +z9yG540cOMZkxr8dcKi91ozvuJt8I1H2uh1Ujt33xqNGmYKBevsAb/
    RpbWF9dLJ/
    myJLVK6H6k2x479ZvWVRsK4O+oY3IBlR316NG58BO+ICmNArSPfHOfF
    1rtoGlrSrsxBxTE6N2xF+YqBqwX7vKKnDcMp DevInteriew

## Using ssh-keygen

The key includes newlines and there is no space after `ssh-rsa` so `ssh-keygen -lf key-original.pub` reports that 
`key-original.pub is not a public key file.`  I took out the newlines and added the space in an editor on the assumption that the newline had been added in transmission so now `ssh-keygen -lf key-edited.pub -E md5` reports `D5:ad:86:95:d7:5c:5d:fc:00:9d:87:57:f0:ff:5d:fc:e7` which doesn't match the original fingerprint.  So either the key and fingerprints don't match or the edits have messed something up.

For test purposes I've generated an additional key and edited it to put in some new lines.  Running `for file in ./*.pub; do ssh-keygen -lf "$file" -E md5; done` confirms that `ssh-keygen` doesn't like newlines.

    ./key-generated-edited.pub is not a public key file.
     (RSA)D5:0f:3e:30:30:b0:27:c8:59:f9:58:d9:30:a8:b6:e4:72 key-generated
     (RSA)D5:ad:86:95:d7:5c:5d:fc:00:9d:87:57:f0:ff:5d:fc:e7 key-original-edited
    ./key-original.pub is not a public key file.

For completeness `for file in ./*.pub; do ssh-keygen -lf "$file" -E sha256; done` delivers this.

    ./key-generated-edited.pub is not a public key file.
     (RSA)HA256:69yuLaGVhPMp+3q3PzN/2ekzhnujMcNTdODpbCc/nhU key-generated
     (RSA)HA256:VjwHh8jTGMCibdfEboLjn+dWAjcsyarVeQ7m9xfBNLk key-original-edited
    ./key-original.pub is not a public key file.



```python
%%capture
# Install sshpubkeys because it doesn't come by default with Azure Notebooks
!pip install sshpubkeys 
import hashlib
import base64
import sshpubkeys
import glob
```

## Using Python

The favoured answer on Stackoverflow &lt;https: 6682815="" deriving-an-ssh-fingerprint-from-a-public-key-in-python="" questions="" stackoverflow.com=""&gt; is the function below, which can cope with the original key and the edited one but both of which generate different output neither of which match the submitted fingerprints.&lt;/https:&gt;


```python
def lineToFingerprint(line):
    key = base64.b64decode(line.strip().split()[1].encode('ascii'))
    fp_plain = hashlib.md5(key).hexdigest()
    return ':'.join(a+b for a,b in zip(fp_plain[::2], fp_plain[1::2]))

key_original = open("key-original.pub", "r").read()
lineToFingerprint(key_original)
```

    'e5:db:b7:38:3c:77:de:4c:97:8c:b0:77:4a:a1:49:8f'

```python
key_edited = open("key-original-edited.pub", "r").read()
lineToFingerprint(key_edited)
```

    'ad:86:95:d7:5c:5d:fc:00:9d:87:57:f0:ff:5d:fc:e7'

At least the fingerprint for `key-original-edited.pub` matches the one provided by `ssh-keygen`.

## Using sshpubkeys package

The task is to generate both md5 and sha256 hashes.  It seems most straight forward to use the `sshpubkeys` package which will parse the keys and provide both (and incidentally uses the Stackoverflow answer for the md5 fingerprint).

```python
for key_file in glob.glob('*.pub'):
    key_string = open(key_file, "r").read()
    key = sshpubkeys.SSHKey(key_string)
    print(key_file)
    print(key.hash_md5())
    print(key.hash_sha256())
```

    key-original.pub
    MD5:e5:db:b7:38:3c:77:de:4c:97:8c:b0:77:4a:a1:49:8f
    SHA256:iouUdQd3Rz9Vj7zGxMBVj8HTyvRwQG5nCjwpV/5CIkE
    key-generated.pub
    MD5:0f:3e:30:30:b0:27:c8:59:f9:58:d9:30:a8:b6:e4:72
    SHA256:69yuLaGVhPMp+3q3PzN/2ekzhnujMcNTdODpbCc/nhU
    key-generated-edited.pub
    MD5:4a:1f:d8:d1:b9:79:21:10:c9:8b:ff:c6:17:c2:34:20
    SHA256:Nh9It/NEWD93hSE+z6QN9QtSb6vDuqJ88yn1AfwDNak
    key-original-edited.pub
    MD5:ad:86:95:d7:5c:5d:fc:00:9d:87:57:f0:ff:5d:fc:e7
    SHA256:VjwHh8jTGMCibdfEboLjn+dWAjcsyarVeQ7m9xfBNLk

## Conclusion

None of the fingerprints match so it is clear (and unsurprising) that you cannot arbitrarily go adding or removing newlines in keys.  I do remember removing newlines from a key Stuart emailed to me but this was to get it back into the form it was before emailing.

I am at a loss to know why the given fingerprints don't match the ones generated.

---
layout: post
---

There might be some utility in rapidly rejecting obviously incorrect
email addresses without sending an email confirmation to a clearly
bogus address.  So I'd go with the regex from <https://emailregex.com/>.

```python
# -*- coding: utf-8 -*-
import re
import unittest

def is_valid_email(email):
    ''' return true if it kind of looks like an email address

    ^(?!\.)   don't start with .
    \"        allow " in the username
    @(?!-)    no - after the @
    (?<!\.)@  no . before the @
    \[        allow [ in the first part of the hostname
    \.(?!\.)  no . after the .
    \]        allow ] in the last part of the hostname

    '''
    email_regex = r"(^(?!\.)[\"a-zA-Z0-9_.+-]+(?<!\.)@(?!-)[\[a-zA-Z0-9-]+\.(?!\.)[a-zA-Z0-9-.\]]+$)"
    if len(email) > 7:
        if re.match(email_regex, email) != None:
            return True
    return False
```

Use the function like this:


```python
EMAIL_ADDRESS = "name@mailserver.com"
if is_valid_email(EMAIL_ADDRESS):
    print EMAIL_ADDRESS + " is a valid email address"
else:
    print EMAIL_ADDRESS + " is not a valid email address"
```

    name@mailserver.com is a valid email address


## Tests

Developing the regex without tests is kind of implausible, so I'll use some supposedly valid and invalid emails from <https://blogs.msdn.microsoft.com/testing123/2009/02/06/email-address-test-cases/>.

```python
class TestValid(unittest.TestCase):
    def test_valid_emails(self):
        valid_emails = ["email@domain.com", "firstname.lastname@domain.com",
                        "email@subdomain.domain.com", "firstname+lastname@domain.com",
                        "email@123.123.123.123", "1234567890@domain.com",
                        "email@domain-one.com", "_______@domain.com",
                        "email@domain.name", "email@domain.co.jp",
                        "firstname-lastname@domain.com", '"email"@domain.com',
                        "email@[123.123.123.123]"]
        for email in valid_emails:
            self.assertTrue(is_valid_email(email))
```

There is also a list of invalid emails from <https://blogs.msdn.microsoft.com/testing123/2009/02/06/email-address-test-cases/>.

```python
class TestInvalid(unittest.TestCase):
    def test_invalid_emails(self):
        invalid_emails = ["plainaddress", "#@%^%#$@#$@#.com", "@domain.com",
                          "Joe Smith <email@domain.com>", "email.domain.com",
                          "email@domain@domain.com", u"あいうえお@domain.com",
                          "email@domain.com (Joe Smith)", "email@domain",
                          "email@-domain.com", ".email@domain.com",
                          "email.@domain.com", "email@domain..com"]
        for email in invalid_emails:
            self.assertFalse(is_valid_email(email))
```

### Tests Incomplete

Unfortunately these supposedly invalid emails pass as valid.

    "email@domain.web",
    "email..email@domain.com",
    "email@111.222.333.44444"

...but the regex is getting harder to read so maybe I should split it up into a series of regexes that are easier to read and focus on particular invalid features.

```python
unittest.main(argv=[''], verbosity=2, exit=False)
```

    test_invalid_emails (__main__.TestInvalid) ... ok
    test_valid_emails (__main__.TestValid) ... ok
    
    ----------------------------------------------------------------------
    Ran 2 tests in 0.015s
    
    OK





    <unittest.main.TestProgram at 0x7fc7ba338d10>


